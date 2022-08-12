# This is a script that integrates with gtimelog
if [ $# -eq 0 ]; then
    cat ~/.local/share/gtimelog/timelog.txt | grep "$(date +"^%Y-%m-%d")" | more
else
    echo "$(date +"%Y-%m-%d %H:%M"): $@" >> ~/.local/share/gtimelog/timelog.txt
fi
