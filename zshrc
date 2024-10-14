# Load plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/billyhopkinson-wood/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/path/to/fsh/fast-syntax-highlighting.plugin.zsh

# Override default config variables
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=grey'

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Lazy load NVM using custom script
source ~/lazy_nvm.sh

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
# compctl -K _pip_completion pip3
# eval "`pip completion --zsh`"


# History settings
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Completion settings
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Load Powerlevel10k theme
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="$HOME/.local/bin:$PATH"
export PATH="/home/billyhopkinson-wood/.nvm/versions/node/v21.6.2/bin:$PATH"

#go path
export PATH=$PATH:/usr/local/go/bin


# Aliases
alias ls="colorls --sd"
alias reload='source ~/.zshrc'
alias zsconfig="subl ~/.zshrc"
alias myip="curl http://ipecho.net/plain; echo"
alias ppwd="export PYTHONPATH=$(pwd)"

alias pynewenv='python -m venv venv'
alias pystart='source venv/bin/activate'



# Functions
ffs() {
    sudo $(fc -ln -1)
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH"



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
