# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH. export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will load a random theme each time Oh My Zsh is loaded, in which case, to know which specific one was loaded, run: echo $RANDOM_THEME See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes ZSH_THEME="robbyrussell"
# ZSH_THEME="essembeh-cst"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load? Standard plugins can be found in $ZSH/plugins/ Custom plugins may be added to $ZSH_CUSTOM/plugins/ Example format: plugins=(rails git textmate ruby lighthouse) Add wisely, as too many plugins slow down shell startup.

if [-f $ZSH/oh-my-zsh.sh ]; then
  plugins=(git zsh-autosuggestions)
  ZSH_AUTOSUGGEST_USE_ASYNC=1
  source $ZSH/oh-my-zsh.sh
else
  echo "Oh My Zsh not found at $ZSH. Please check your installation."
fi

export WORKSPACE=$HOME
export JX_DEFAULT_CONTAINER="captain"
# Justfile alias
if [ -d "$WORKSPACE/containers/$JX_DEFAULT_CONTAINER" ] && \
   [ -f "$WORKSPACE/containers/$JX_DEFAULT_CONTAINER/$JX_DEFAULT_CONTAINER.sif" ]; then
   JUSTFILE_PATH="$WORKSPACE/containers/$JX_DEFAULT_CONTAINER/justfile"
    alias jx="just --justfile $JUSTFILE_PATH"
fi

# Define datasets directory
if [ -d "$WORKSPACE/datasets" ]; then
   export JUST_DATASET_DIR="$WORKSPACE/datasets"
fi

# Link npm-global directory in from $WORKSPACE manually to $HOME/.npm-global
if { [ -d "$HOME/.npm-global" ] || [ -L "$HOME/.npm-global" ]; } \
   && [ -d "$HOME/.npm-global/bin" ]; then
   module load nodejs
   npm config set prefix '~/.npm-global'
   export PATH=~/.npm-global/bin:$PATH
else
   echo "Warning: ~/.npm-global/bin not found. Please install it on $WORKSPACE and link it to $HOME/.npm-global."
fi

# Load Powerlevel10k for ghostty, otherwise fallback to p10k-fallback
export COLORTERM=truecolor
if [[ "$TERM" == "xterm-ghostty" ]]; then
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
  # For compatibility!
  export TERM=xterm-256color
else
  [[ ! -f ~/.p10k-fallback.zsh ]] || source ~/.p10k-fallback.zsh
fi