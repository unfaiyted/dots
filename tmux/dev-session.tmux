#!/bin/bash
# Tmux session configuration - Development Environment

# Session name
SESSION="dev"

# Check if session exists, if not create it
tmux has-session -t $SESSION 2>/dev/null

if [ $? != 0 ]; then
    # Create new session with first window
    tmux new-session -d -s $SESSION -n editor

    # Window 1: Editor
    tmux send-keys -t $SESSION:editor "cd ~/projects" C-m
    tmux send-keys -t $SESSION:editor "nvim ." C-m

    # Window 2: Terminal
    tmux new-window -t $SESSION -n terminal
    tmux send-keys -t $SESSION:terminal "cd ~/projects" C-m

    # Window 3: Server/Logs
    tmux new-window -t $SESSION -n server
    tmux split-window -h -t $SESSION:server
    tmux send-keys -t $SESSION:server.0 "cd ~/projects" C-m
    tmux send-keys -t $SESSION:server.0 "# npm run dev" C-m
    tmux send-keys -t $SESSION:server.1 "cd ~/projects" C-m
    tmux send-keys -t $SESSION:server.1 "# tail -f logs/app.log" C-m

    # Window 4: Git
    tmux new-window -t $SESSION -n git
    tmux send-keys -t $SESSION:git "cd ~/projects" C-m
    tmux send-keys -t $SESSION:git "git status" C-m

    # Window 5: Database
    tmux new-window -t $SESSION -n database
    tmux split-window -v -t $SESSION:database -p 30
    tmux send-keys -t $SESSION:database.0 "# psql -U username -d dbname" C-m
    tmux send-keys -t $SESSION:database.1 "# redis-cli" C-m

    # Select default window
    tmux select-window -t $SESSION:editor
fi

# Attach to session
tmux attach-session -t $SESSION