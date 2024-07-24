if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    alias vim=nvim

    fish_add_path /home/bvor/.local/bin

    # Run ssh-agent
    if not pgrep -u "$USER" ssh-agent > /dev/null
        ssh-agent -t 4h > "$XDG_RUNTIME_DIR/ssh-agent.env"
    end
    if not test -f "$SSH_AUTH_SOCK"
        . (sed 's/^/export /' "$XDG_RUNTIME_DIR/ssh-agent.env" | psub)
    end
end
