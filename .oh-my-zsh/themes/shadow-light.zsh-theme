# shadow-light.zsh-theme - mostly a copy of the kphoen theme

if [[ "$TERM" != "dumb" ]] && [[ "$DISABLE_LS_COLORS" != "true" ]]; then
    PROMPT='[%{$fg[yellow]%}%n%{$reset_color%}@%{$fg[magenta]%}%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}]
%(1j.[%j] .)%(!.#.\$) '

    ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[yellow]%}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
    ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[yellow]%}✘"
    ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg_bold[green]%}✔"

    # display exitcode on the right when >0
    return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

    RPROMPT='${return_code}$(git_prompt_status)$(git_prompt_info)%{$reset_color%}'

    ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} "
    ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} "
    ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} "
    ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} "
    ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} "
    ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%} "
else
    PROMPT='[%n@%m:%~]
\$ '

    ZSH_THEME_GIT_PROMPT_PREFIX=" "
    ZSH_THEME_GIT_PROMPT_SUFFIX=""
    ZSH_THEME_GIT_PROMPT_DIRTY="✘"
    ZSH_THEME_GIT_PROMPT_CLEAN="✔"

    # display exitcode on the right when >0
    return_code="%(?..%? ↵)"

    RPROMPT='${return_code}$(git_prompt_status)$(git_prompt_info)'

    ZSH_THEME_GIT_PROMPT_ADDED=" ✲"
    ZSH_THEME_GIT_PROMPT_MODIFIED=" ✎"
    ZSH_THEME_GIT_PROMPT_DELETED=" ✖"
    ZSH_THEME_GIT_PROMPT_RENAMED=" ➜"
    ZSH_THEME_GIT_PROMPT_UNMERGED=" ☇"
    ZSH_THEME_GIT_PROMPT_UNTRACKED=" ≉"
fi
