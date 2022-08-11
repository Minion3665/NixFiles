# This is a script that integrates with gtimelog
if [ $# -eq 0 ]; then

else
    echo "$() $@" >> ~/.local/share/gtimelog/timelog.txt
fi
