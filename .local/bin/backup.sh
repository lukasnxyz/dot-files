#!/usr/bin/env bash

#DISK="/Volumes/Samsung T7"
#DISK="/run/media/ln/Samsung T7"
DISK="/mnt/external_drive"
GH_USERNAME="lukasnxyz"

BACKUP_FOLDERS=(
    "/home/ln/dev/"
    "/home/ln/rsrch/"
    "/home/ln/Documents/"
    "/home/ln/Downloads/"
    "/home/ln/Pictures/"
    "/home/ln/Videos/"
    "/home/ln/Uni/"

    "/home/ln/.local/"
    "/home/ln/.cache/zsh/"
    "/home/ln/.config/"
    "/home/ln/.vim/"
    "/home/ln/.vimrc"
    "/home/ln/.gnupg/"
    "/home/ln/.ssh/"
    "/home/ln/.password_store/"
    "/home/ln/.zshenv"
    "/home/ln/.zshrc"
    "/home/ln/.gitconfig"
    "/home/ln/.xinitrc"
    "/home/ln/.zprofile"
    "/home/ln/.profile"
)

backup_storage() {
    echo "--- Starting Local Storage Backup (storage) ---"
    if [ ! -d "$DISK/backup" ]; then
        echo "Error: Backup disk $DISK/backup not found! Aborting local storage backup."
        return 1
    fi

    for folder in "${BACKUP_FOLDERS[@]}"; do
        if [ -d "$folder" ] || [ -f "$folder" ]; then
            echo "Backing up $folder to $DISK/backup..."

            rsync --no-g --no-o --archive --verbose --progress --delete \
                --exclude ".venv/" \
                --exclude "target/" \
                --exclude "notebook_venv/" \
                "$folder" "$DISK/backup"

            if [ $? -eq 0 ]; then
                echo "Backup of $folder completed successfully"
            else
                echo "Error occurred while backing up $folder"
            fi
        else
            echo "Warning: Source path $folder does not exist"
        fi
    done

    echo "--- Local Storage Backup completed ---"
}

backup_github() {
    echo "--- Starting GitHub Backup (github) ---"

    if ! command -v gh &> /dev/null; then
        echo "Error: 'gh' (GitHub CLI) command not found. Please install it to use the GitHub backup feature."
        return 1
    fi

    if [ -z "$GH_USERNAME" ]; then
        echo "Error: GitHub username cannot be empty. Aborting GitHub backup."
        return 1
    fi

    local github_dir="$DISK/github_repos/$GH_USERNAME"
    mkdir -p "$github_dir"

    if [ ! -d "$github_dir" ]; then
        echo "Error: Could not create GitHub backup directory $github_dir. Aborting GitHub backup."
        return 1
    fi

    cd "$github_dir" || { echo "Error: Failed to change directory to $github_dir"; return 1; }

    echo "Cloning all repositories for $GH_USERNAME into $github_dir..."

    set -euo pipefail

    gh repo list "$GH_USERNAME" --limit 1000 --json name --jq '.[].name' | \
        while read -r repo; do
            if [ -d "$repo" ]; then
                if [ -d "$repo/.git" ]; then
                    echo "Updating existing repo: $repo"
                    git -C "$repo" pull --ff-only
                else
                    echo "Skipping existing non-git directory: $repo"
                fi
            else
                echo "Cloning: $repo"
                gh repo clone "$GH_USERNAME/$repo" "$repo"
            fi
        done

        echo "Done! Synced repos into $github_dir (cloned new repos and pulled existing ones)."
        cd - > /dev/null
        echo "--- GitHub Backup completed ---"
}

if [ $# -eq 0 ]; then
    backup_storage
    backup_github
else
    case "$1" in
        storage)
            backup_storage
            ;;
        github)
            backup_github
            ;;
        both)
            backup_storage
            backup_github
            ;;
        *)
            echo "Usage: $0 [storage|github|both]"
            echo "  storage: Backs up local files to $DISK"
            echo "  github: Clones all GitHub repositories for a given username"
            echo "  (no argument or 'both'): Runs both local storage and GitHub backup"
            exit 1
            ;;
    esac
fi

echo "--- Overall Backup Process Completed ---"
