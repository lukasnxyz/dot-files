local api = vim.api
local fn = vim.fn

local M = {}

-- Default configuration
M.config = {
  model = "llama3.1",
  ollama_url = "http://localhost:11434",
  system_prompt = "You are a helpful assistant.",
  max_tokens = 2000,
  temperature = 0.7,
  prompt_prefix = "User: ",
  response_prefix = "Llama: ",
  keymaps = {
    send = "<leader>as",
    stop = "<leader>ad"
  }
}

-- Current state
M.state = {
  job_id = nil,
  streaming = false,
  current_buffer = nil,
  insertion_line = nil,
  current_line_count = 0
}

-- Stop the current streaming job
function M.stop_streaming()
  if M.state.job_id then
    fn.jobstop(M.state.job_id)
    M.state.job_id = nil
  end
  M.state.streaming = false

  -- Add a note that streaming was stopped
  if M.state.current_buffer and api.nvim_buf_is_valid(M.state.current_buffer) then
    if M.state.insertion_line ~= nil then
      local line_idx = M.state.insertion_line + M.state.current_line_count
      local current_line = api.nvim_buf_get_lines(M.state.current_buffer, line_idx, line_idx + 1, false)[1]
      api.nvim_buf_set_lines(M.state.current_buffer, line_idx, line_idx + 1, false,
                           {current_line .. " [Stream stopped]"})
    end
  end

  print("Ollama streaming stopped")
end

-- Handle token that contains newlines
function M.handle_token_with_newlines(token)
  if not M.state.current_buffer or not api.nvim_buf_is_valid(M.state.current_buffer) then
    return
  end

  local lines = vim.split(token, "\n", { plain = true })

  if #lines == 1 then
    -- No newlines, just append to current line
    local current_line_idx = M.state.insertion_line + M.state.current_line_count
    local current_line = api.nvim_buf_get_lines(M.state.current_buffer, current_line_idx, current_line_idx + 1, false)[1]
    api.nvim_buf_set_lines(M.state.current_buffer, current_line_idx, current_line_idx + 1, false, {current_line .. lines[1]})
  else
    -- Handle multiple lines
    local current_line_idx = M.state.insertion_line + M.state.current_line_count
    local current_line = api.nvim_buf_get_lines(M.state.current_buffer, current_line_idx, current_line_idx + 1, false)[1]

    -- Update first line
    api.nvim_buf_set_lines(M.state.current_buffer, current_line_idx, current_line_idx + 1, false, {current_line .. lines[1]})

    -- Add remaining lines
    for i = 2, #lines do
      api.nvim_buf_set_lines(M.state.current_buffer, current_line_idx + i - 1, current_line_idx + i - 1, false, {lines[i]})
    end

    -- Update line count
    M.state.current_line_count = M.state.current_line_count + #lines - 1
  end

  -- Move cursor to the end of the content
  local win = api.nvim_get_current_win()
  local current_line_idx = M.state.insertion_line + M.state.current_line_count
  local current_line = api.nvim_buf_get_lines(M.state.current_buffer, current_line_idx, current_line_idx + 1, false)[1]
  api.nvim_win_set_cursor(win, {current_line_idx + 1, #current_line})
end

-- Parse JSON from Ollama response and update buffer
function M.parse_response(data)
  for _, line in ipairs(data) do
    if line ~= "" then
      local success, parsed = pcall(vim.json.decode, line)
      if success and parsed.response then
        -- Process the token (which might contain newlines)
        M.handle_token_with_newlines(parsed.response)
      end

      -- Handle stream completion
      if success and parsed.done then
        M.state.streaming = false
        -- Add a newline after completion
        if M.state.current_buffer and api.nvim_buf_is_valid(M.state.current_buffer) then
          local final_line_idx = M.state.insertion_line + M.state.current_line_count
          api.nvim_buf_set_lines(M.state.current_buffer, final_line_idx + 1, final_line_idx + 1, false, {""})
        end
        break
      end
    end
  end
end

-- Stream response from Ollama
function M.stream_response(prompt, start_line, end_line)
  if M.state.streaming then
    print("Already streaming. Please stop the current stream first.")
    return
  end

  -- Reset state
  M.state.streaming = true
  M.state.current_buffer = api.nvim_get_current_buf()
  M.state.insertion_line = end_line
  M.state.current_line_count = 0

  -- Insert the response line with just the prefix initially
  api.nvim_buf_set_lines(M.state.current_buffer, M.state.insertion_line, M.state.insertion_line, false,
                       {M.config.response_prefix})

  -- Create the JSON request
  local request = {
    model = M.config.model,
    prompt = prompt,
    system = M.config.system_prompt,
    stream = true,
    options = {
      temperature = M.config.temperature,
      num_predict = M.config.max_tokens,
    }
  }

  local json_request = vim.json.encode(request)
  local temp_file = fn.tempname()
  local f = io.open(temp_file, "w")
  f:write(json_request)
  f:close()

  -- Start the job to communicate with Ollama
  M.state.job_id = fn.jobstart({
    "curl",
    "-s",
    M.config.ollama_url .. "/api/generate",
    "-H", "Content-Type: application/json",
    "-d", "@" .. temp_file
  }, {
    on_stdout = function(_, data)
      vim.schedule(function()
        M.parse_response(data)
      end)
    end,
    on_exit = function()
      vim.schedule(function()
        M.state.streaming = false
        os.remove(temp_file)
      end)
    end
  })
end

-- Get current line or selected text as prompt
function M.get_current_text()
  local mode = api.nvim_get_mode().mode

  if mode == "v" or mode == "V" or mode == "" then
    -- Get visual selection
    local start_pos = fn.getpos("'<")
    local end_pos = fn.getpos("'>")
    local start_line, start_col = start_pos[2], start_pos[3]
    local end_line, end_col = end_pos[2], end_pos[3]

    local lines = api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

    if #lines == 0 then
      return "", 0, 0
    elseif #lines == 1 then
      return string.sub(lines[1], start_col, end_col), start_line - 1, end_line
    else
      lines[1] = string.sub(lines[1], start_col)
      lines[#lines] = string.sub(lines[#lines], 1, end_col)
      return table.concat(lines, "\n"), start_line - 1, end_line
    end
  else
    -- Get current line and position
    local current_line = api.nvim_get_current_line()
    local line_num = api.nvim_win_get_cursor(0)[1]
    return current_line, line_num - 1, line_num
  end
end

-- Send current text to Ollama
function M.send_to_ollama()
  local text, start_line, end_line = M.get_current_text()
  if text and text ~= "" then
    M.stream_response(text, start_line, end_line)
  else
    print("No text selected")
  end
end

-- Setup the plugin
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})

  -- Create commands
  api.nvim_create_user_command("OllamaStream", function()
    M.send_to_ollama()
  end, {})

  api.nvim_create_user_command("OllamaStop", function()
    M.stop_streaming()
  end, {})

  -- Set keymaps
  vim.keymap.set({"n", "v"}, M.config.keymaps.send, function()
    M.send_to_ollama()
  end, {silent = true, noremap = true, desc = "Send to Ollama"})

  vim.keymap.set("n", M.config.keymaps.stop, function()
    M.stop_streaming()
  end, {silent = true, noremap = true, desc = "Stop Ollama stream"})
end

return M
