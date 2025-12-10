tell application "System Events"
    tell process "Dock"
        set outlookTile to first UI element of list 1 whose name is "Microsoft Outlook"
        if exists outlookTile then
            set badge to value of attribute "AXStatusLabel" of outlookTile
            if badge is missing value then
                set badge to "0"
            end if
        else
            set badge to "0"
        end if
    end tell
end tell
do shell script "echo " & badge & " > ~/.config/sketchybar/plugins/outlook_badge_count.txt"
return badge
