#!/usr/bin/env zsh

setopt PROMPT_SUBST
. ~/.bin/git/git-prompt.zsh

NL=$'\n'

# Little breakdown:
# 1. SET Line color
LCOL="%F{blue}"
# 2. PRINT top bracket
# 3. PRINT full hline (the whole eval printf thing)
HLINE="\$(eval printf %.0s─ '{2..'\"\${COLUMNS:-\$(tput cols)}\"\}; echo)"
# 4. PRINT newline
# 5. GO back to first line, after the top bracket
L1MARK=$'%{\E[1A\E[2C%}'
# 6. PRINT ┤
# 7. SET cwd color
WCOL="%F{magenta}"
# 7. PRINT cwd
# 8. SET Line color
# 9. PRINT ├
# 10. GO right
GOR=$'%{\E[1C%G%}'
# 11. CALL git-prompt
#   11.A. PRINT ┤
#   11.B. SET git color
GCOL="%F{yellow}"
#   11.C. PRINT git
#   11.D SET Line color
#   11.E. PRINT ├
GPS1="\$(GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWUPSTREAM=1 __git_ps1 \"┤ %$GCOL%s %$LCOL├\")"
# 12. GO to the next line
# 13. PRINT bottom bracket
# 14. PRINT dollar sign
# 15. RESET color

export PS1="$LCOL╭$HLINE$NL$L1MARK┤ $WCOL%3~ $LCOL├$GOR$GPS1$NL╰─$%f "

unset LCOL
unset HLINE
unset L1MARK
unset WCOL
unset GCOL
unset GPS1
