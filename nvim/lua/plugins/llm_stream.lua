local M = {}

-- TODO: to be per model not provider
-- TODO: fix visual mode buffer content
-- TODO: openrouter setup
-- TODO: system prompt to set in init.lua config
-- TODO: message of generation bottom right like rust-analyzer does
-- TODO: gen everything in () so I can vi(

local config = {
    default_provider = 'ollama',
    providers = {
        ollama = {
            url = 'http://localhost:11434/api/generate',
            model = 'qwen2.5-coder:latest',
        },
        google_gemini = {
            url = 'https://generativelanguage.googleapis.com/v1beta/models/%s:generateContent',
            model = 'gemini-2.0-flash',
            api_key = os.getenv('GEMINI_API_KEY') or '',
        },
    },
}

local active_job_id = nil

local providers = {
    ollama = {
        stream = function(cfg, on_data, on_error)
            local payload = vim.fn.json_encode({
                model = cfg.model,
                prompt = cfg.prompt,
                stream = true,
            })
            local curl_cmd = string.format(
                'curl -s --no-buffer -X POST %s -d %s',
                vim.fn.shellescape(cfg.url),
                vim.fn.shellescape(payload)
            )

            local stderr = {}
            local first_chunk = true
            local separator = string.rep('-', 50)

            local job_id = vim.fn.jobstart(curl_cmd, {
                on_stdout = function(_, data, _)
                    if data then
                        for _, line in ipairs(data) do
                            if line ~= '' then
                                local ok, json = pcall(vim.fn.json_decode, line)
                                if ok and json.response then
                                    if first_chunk then
                                        on_data(separator .. '\n')
                                        first_chunk = false
                                    end
                                    on_data(json.response)
                                elseif not ok then
                                    on_error('failed to parse json: ' .. line)
                                end
                            end
                        end
                    end
                end,
                on_stderr = function(_, data, _)
                    if data then
                        for _, line in ipairs(data) do
                            if line ~= '' then
                                table.insert(stderr, line)
                            end
                        end
                    end
                end,
                on_exit = function(_, code, _)
                    if code == 0 then
                        vim.schedule(function()
                            -- Add bottom separator
                            on_data('\n' .. separator)

                            local cursor_pos = vim.api.nvim_win_get_cursor(0)
                            local row = cursor_pos[1] - 1
                            local line_count = vim.api.nvim_buf_line_count(0)
                            if row + 1 <= line_count then
                                vim.api.nvim_buf_set_lines(0, row + 1, row + 1, false, { '' })
                            end
                            vim.notify('Generation completed', vim.log.levels.INFO)
                        end)
                    else
                        local err_msg = 'ollama stream failed with exit code: ' .. code
                        if #stderr > 0 then
                            err_msg = err_msg .. ' | error: ' .. table.concat(stderr, '')
                        end
                        on_error(err_msg)
                    end
                    active_job_id = nil
                end,
            })

            if job_id <= 0 then
                on_error('failed to start ollama stream')
                active_job_id = nil
            else
                active_job_id = job_id
            end
        end,
    },
    google_gemini = {
        stream = function(cfg, on_data, on_error)
            if not cfg.api_key or cfg.api_key == '' then
                on_error('Google Gemini API key is missing')
                return
            end

            vim.notify('Querying Google Gemini...', vim.log.levels.INFO)

            local url = string.format(cfg.url, cfg.model) .. '?key=' .. cfg.api_key
            local payload = {
                contents = {
                    {
                        parts = {
                            { text = cfg.prompt }
                        }
                    }
                }
            }

            local curl_cmd = string.format(
                'curl -s --no-buffer -X POST %s -H "Content-Type: application/json" -d %s',
                vim.fn.shellescape(url),
                vim.fn.shellescape(vim.fn.json_encode(payload))
            )

            local stderr = {}
            local response_buffer = ''
            local separator = string.rep('-', 50)

            local job_id = vim.fn.jobstart(curl_cmd, {
                on_stdout = function(_, data, _)
                    if data then
                        for _, line in ipairs(data) do
                            if line ~= '' then
                                response_buffer = response_buffer .. line
                            end
                        end
                    end
                end,

                on_stderr = function(_, data, _)
                    if data then
                        for _, line in ipairs(data) do
                            if line ~= '' then
                                table.insert(stderr, line)
                            end
                        end
                    end
                end,

                on_exit = function(_, code, _)
                    vim.schedule(function()
                        if code == 0 then
                            if response_buffer ~= '' then
                                local ok, json = pcall(vim.fn.json_decode, response_buffer)
                                if ok then
                                    if json.candidates and json.candidates[1] and
                                        json.candidates[1].content and json.candidates[1].content.parts then

                                        local full_text = ''
                                        for _, part in ipairs(json.candidates[1].content.parts) do
                                            if part.text then
                                                full_text = full_text .. part.text
                                            end
                                        end

                                        if full_text ~= '' then
                                            -- Add top separator, content, and bottom separator
                                            on_data(separator .. '\n' .. full_text .. '\n' .. separator)

                                            local cursor_pos = vim.api.nvim_win_get_cursor(0)
                                            local row = cursor_pos[1] - 1
                                            local line_count = vim.api.nvim_buf_line_count(0)
                                            if row + 1 <= line_count then
                                                vim.api.nvim_buf_set_lines(0, row + 1, row + 1, false, { '' })
                                            end
                                            vim.notify('Generation completed', vim.log.levels.INFO)
                                        else
                                            on_error('Empty response text from Google Gemini')
                                        end
                                    else
                                        on_error('Unexpected JSON structure: ' .. vim.fn.json_encode(json))
                                    end
                                else
                                    on_error('Failed to parse JSON response: ' .. response_buffer)
                                end
                            else
                                on_error('Empty response from Google Gemini')
                            end
                        else
                            local err_msg = 'Google Gemini request failed with exit code: ' .. code
                            if #stderr > 0 then
                                err_msg = err_msg .. ' | error: ' .. table.concat(stderr, ' ')
                            end
                            on_error(err_msg)
                        end
                        active_job_id = nil
                    end)
                end,
            })

            if job_id <= 0 then
                on_error('Failed to start Google Gemini request')
                active_job_id = nil
            else
                active_job_id = job_id
            end
        end,
    },
}

local function wrap_text(text, max_len, current_line)
    if type(text) ~= 'string' or text == '' then
        return {}, current_line
    end
    local lines = {}
    current_line = current_line or ''

    -- split on newlines to handle explicit line breaks
    local segments = vim.split(text, '\n', { trimempty = false })
    for i, segment in ipairs(segments) do
        local remaining = segment
        while #remaining > 0 do
            -- calculate display length of current_line
            local tab_width = vim.bo.tabstop or 8
            local current_display_len = current_line:gsub('\t', string.rep(' ', tab_width)):len()

            -- find the next space or tab to split on
            local next_space = remaining:find('[ \t]', 1) or #remaining + 1
            local word = remaining:sub(1, next_space - 1)
            local separator = remaining:sub(next_space, next_space) or ''
            local word_display_len = word:gsub('\t', string.rep(' ', tab_width)):len()
            local separator_display_len = separator == '\t' and tab_width or (separator == ' ' and 1 or 0)

            if current_display_len + word_display_len + separator_display_len <= max_len then
                current_line = current_line .. word .. separator
                remaining = remaining:sub(next_space + 1)
            else
                if current_line ~= '' then
                    table.insert(lines, current_line)
                end
                current_line = word .. separator
                remaining = remaining:sub(next_space + 1)
            end
        end

        -- add a line break for explicit newlines (except for the last segment)
        if i < #segments then
            if current_line ~= '' then
                table.insert(lines, current_line)
            end
            current_line = ''
        end
    end
    return lines, current_line
end

local function get_buffer_content()
    if vim.g.llm_selected_text then
        local selected = vim.g.llm_selected_text
        vim.g.llm_selected_text = nil
        return selected
    end

    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    return table.concat(lines, '\n')
end

function M.stream_to_buffer(provider_name)
    local provider_config = config.providers[provider_name]
    if not provider_config then
        vim.notify('Unknown provider: ' .. provider_name, vim.log.levels.ERROR)
        return
    end

    local provider = providers[provider_name]
    if not provider then
        vim.notify('Provider implementation not found: ' .. provider_name, vim.log.levels.ERROR)
        return
    end

    local prompt = get_buffer_content()
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local row = cursor_pos[1] - 1
    local col = cursor_pos[2]

    vim.api.nvim_buf_set_lines(bufnr, row + 1, row + 1, false, { '' })
    row = row + 1
    col = 0
    vim.api.nvim_win_set_cursor(0, { row + 1, col })

    local current_line = ''

    provider.stream({
        prompt = prompt,
        url = provider_config.url,
        model = provider_config.model,
        api_key = provider_config.api_key,
    }, function(data)
        vim.schedule(function()
            if data then
                -- wrap the incoming data
                local wrapped_lines, new_current_line = wrap_text(data, 100, current_line)
                current_line = new_current_line

                -- get the current line count to validate row
                local line_count = vim.api.nvim_buf_line_count(bufnr)

                -- append wrapped lines after the current row
                if #wrapped_lines > 0 then
                    vim.api.nvim_buf_set_lines(bufnr, row, row, false, wrapped_lines)
                    row = row + #wrapped_lines
                end

                -- append or update the current_line content
                local current_lines = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)
                if #current_lines == 0 then
                    vim.api.nvim_buf_set_lines(bufnr, row, row, false, { current_line })
                else
                    vim.api.nvim_buf_set_text(bufnr, row, 0, row, #current_lines[1], { current_line })
                end

                -- update cursor to the end of the inserted text (only if in the original buffer)
                if vim.api.nvim_get_current_buf() == bufnr then
                    col = #current_line
                    local final_row = row + (current_line ~= '' and 1 or 0)
                    if final_row <= line_count then
                        vim.api.nvim_win_set_cursor(0, { final_row, col })
                    else
                        vim.api.nvim_win_set_cursor(0, { line_count, col })
                    end
                end
            end
        end)
    end, function(err)
        vim.schedule(function()
            vim.notify('Stream failed: ' .. err, vim.log.levels.ERROR)
            active_job_id = nil
        end)
    end)
end

function M.stop_stream()
    if active_job_id then
        vim.fn.jobstop(active_job_id)
        vim.notify('Stream stopped', vim.log.levels.INFO)
        active_job_id = nil
    else
        vim.notify('No active stream to stop', vim.log.levels.WARN)
    end
end

function M.setup(user_config)
    if user_config.providers then
        for provider_name, provider_config in pairs(user_config.providers) do
            if config.providers[provider_name] then
                config.providers[provider_name] = vim.tbl_deep_extend('force', config.providers[provider_name], provider_config)
            else
                config.providers[provider_name] = provider_config
            end
        end
    end

    config = vim.tbl_deep_extend('force', config, user_config or {})
    vim.g.llm_stream_default_provider = config.default_provider

    vim.api.nvim_create_user_command('LLMStream', function(opts)
        local provider = opts.args ~= '' and opts.args or vim.g.llm_stream_default_provider

        local selected_text = nil
        if opts.range > 0 then
            local start_line = opts.line1
            local end_line = opts.line2
            local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
            selected_text = table.concat(lines, '\n')
        end

        M.stream_to_buffer(provider, selected_text)
    end, { nargs = '?', range = true })

    vim.api.nvim_create_user_command('LLMStreamStop', function()
        M.stop_stream()
    end, {})

    local function switch_provider(provider_name)
        if config.providers[provider_name] then
            vim.g.llm_stream_default_provider = provider_name
            local model = config.providers[provider_name].model or 'default'
            vim.notify('Switched to ' .. provider_name .. ' (' .. model .. ')', vim.log.levels.INFO)
        else
            vim.notify('Provider ' .. provider_name .. ' not configured', vim.log.levels.WARN)
        end
    end

    vim.api.nvim_set_keymap('n', '<leader>cc', ':LLMStream<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', '<leader>cc', ':LLMStream<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>cs', ':LLMStreamStop<CR>', { noremap = true, silent = true })

    vim.keymap.set('n', '<leader>c1', function()
        switch_provider('ollama')
    end, { noremap = true, silent = true, desc = 'Switch to Ollama' })

    vim.keymap.set('n', '<leader>c2', function()
        switch_provider('google_gemini')
    end, { noremap = true, silent = true, desc = 'Switch to Google Gemini' })

    vim.keymap.set('n', '<leader>c?', function()
        local current = vim.g.llm_stream_default_provider
        local model = config.providers[current] and config.providers[current].model or 'unknown'
        vim.notify('Current provider: ' .. current .. ' (' .. model .. ')', vim.log.levels.INFO)
    end, { noremap = true, silent = true, desc = 'Show current LLM provider' })
end

return M

