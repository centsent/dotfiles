# aliases

# python
alias python python3

# git
if type -q git
    alias ga "git add"
    alias gc "git commit"
    alias gd "git diff"
    alias gl "git pull"
    alias gp "git push"
    alias gst "git status"
end

# exa
if type -q exa
    alias l "exa -a -l -g --icons"
    alias ls exa
end

if type -q z
    alias cd z
end

if type -q btm
    alias top btm
end

if type -q procs
    alias ps procs
end

if type -q rip
    alias rm rip
end

if type -q bat
    alias cat bat
end

if type -q xcp
    alias cp xcp
end

if type -q topgrade
    alias tg "topgrade --disable containers --disable vim"
end

