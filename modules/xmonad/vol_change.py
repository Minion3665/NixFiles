#!${{pkgs.python3}}/bin/python3

import sys
import os
import subprocess

args = sys.argv

device_argument = "--default-source" if "-i" in args else ""

control_argument = ""
control_argument += "-i" if "-u" in args else ""
control_argument += "-d" if "-d" in args else ""
control_argument += "-t" if "-m" in args else " 5"

os.system(
    f"${{pkgs.pamixer}}/bin/pamixer {device_argument} {control_argument} --set-limit 150"
)
mute_char = (
    "!"
    if subprocess.getoutput(f"${{pkgs.pamixer}}/bin/pamixer {device_argument} --get-mute")
    == "true"
    else ""
)
volume = subprocess.getoutput(f"${{pkgs.pamixer}}/bin/pamixer {device_argument} --get-volume")

socket_path = f"{os.environ['XDG_RUNTIME_DIR']}/xob.sock"

with open(socket_path, "w") as socket:
    socket.write(f"{volume}{mute_char}\n")
