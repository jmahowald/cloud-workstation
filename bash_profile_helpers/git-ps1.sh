export PS1="\\w:\$(git branch --color 2>/dev/null | grep '^*' | tr -d '*'  )  \$ "
