tell application "System Events"
    tell process "Dock"
        set teamsTile to first UI element of list 1 whose name is "Microsoft Teams"
        if exists teamsTile then
            set badge to value of attribute "AXStatusLabel" of teamsTile
            if badge is missing value then
                set badge to "0"
            end if
        else
            set badge to "0"
        end if
    end tell
end tell
do shell script "echo " & badge & " > ~/.config/sketchybar/plugins/teams_badge_count.txt"
return badge
