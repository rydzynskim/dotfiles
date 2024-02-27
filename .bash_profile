# add necessary paths
export PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:${PATH}"
export PATH="${PATH}:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# export API keys
if [ -f ~/.secrets ]; then
  export $(grep 'FINNHUB_API_KEY' ~/.secrets | xargs)
  export $(grep 'FINNHUB_WEBHOOK' ~/.secrets | xargs)
  export $(grep 'MYSQL_PASSWORD' ~/.secrets | xargs)
  export $(grep 'OPENAI_API_KEY' ~/.secrets | xargs)
  export $(grep 'EODHD_API_KEY' ~/.secrets | xargs)
else
  echo 'Unable to export API keys because the ~/.secrets file does not exist.'
fi

# set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

# disable bash deprecation warnings
export BASH_SILENCE_DEPRECATION_WARNING=1

# nvm setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# cargo
. "$HOME/.cargo/env"

# cd into any dir in repos with tab completion and automatically switch node versions
function r() {
  cd ~/repos/"$1"
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  fi
}
r_completion() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local repos_dir=~/repos
  # Change to the repos directory to get the list of directories
  pushd "$repos_dir" > /dev/null
  # Generate completion suggestions based on the contents of the repos directory
  COMPREPLY=($(compgen -d -- "$cur"))
  # Return to the original directory
  popd > /dev/null
}
complete -o nospace -F r_completion r

# enables metal gpu support for tensorflow
alias gpu='source ~/venv-metal/bin/activate'

# deactivates metal gpu
alias dgpu='deactivate'
