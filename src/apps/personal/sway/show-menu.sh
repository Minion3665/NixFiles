export id="$(swaymsg -t get_tree | jq -r '.nodes[].nodes[] | select(.name == "__i3_scratch").floating_nodes | reverse[] | ((.id | tostring) + "\t" + (.app_id // .window_properties.class) + "\t" + .name)' | rofi -dmenu -i | awk '{print $1;}')"
echo Showing $id
swaymsg "[con_id=$id]" focus
