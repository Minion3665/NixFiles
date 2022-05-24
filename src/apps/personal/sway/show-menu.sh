export id="$(swaymsg -t get_tree | jq -r '.nodes[].nodes[] | select(.name == "__i3_scratch").floating_nodes[] | ((.id | tostring) + "\t" + (.app_id // .window_properties.class) + "\t" + .name)' | rofi -dmenu | awk '{print $1;}')"
echo Showing $id
swaymsg "[con_id=$id]" focus
