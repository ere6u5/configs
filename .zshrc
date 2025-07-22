# Change work directory
cd ""

# Nickname color
NICKNAME_COLOR="%F{135}"

# Viewed name
PROMPT="${NICKNAME_COLOR}%n %#%f "

# Last command for run parralel terminals
tmux new-session -A -s local
