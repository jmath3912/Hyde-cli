_Hyde () {
    local -a literals=("binds" "game" "::=" "version" "all" "update" "wallpaper" "shell" "0" "Link" "reload" "--blur" "restore" "revert" "cache" "list" "prev" "3" "control" "next" "--opacity" "monitors" "save" "unset" "power" "next" "1" "2" "Config" "systeminfo" "--borderangle" "BackUp" "mode" "theme" "branch" "wallbash" "prev" "backup" "reset" "events" "select" "toggle" "--opacity" "glyph" "set" "patch" "--borderangle" "emoji" "pastebin" "set" "clean" "rebuild" "--animations" "inject" "screencap" "select" "screencap" "reload" "sddm" "Clone" "theme" "show" "select" "waybar" "--animations" "upgrade" "run" "chaotic" "--blur" "man")

    local -A descriptions
    descriptions[1]="Keybind hints"
    descriptions[2]="Toggle game mode"
    descriptions[4]="Hyde-cli version"
    descriptions[5]="Backs up the current configuration"
    descriptions[6]="Pull Updates From Hyde repository"
    descriptions[7]="Wallpaper Commands"
    descriptions[8]="Shell commands"
    descriptions[10]="Links a clone directory. Useful if you want to change your CloneDir"
    descriptions[11]="Just Reload"
    descriptions[12]="Disable blur"
    descriptions[13]="Restore dots"
    descriptions[14]="Revert to a previous backup run by 'Hyde backup all'"
    descriptions[15]="Manages Hyde's cache"
    descriptions[16]="List the backup"
    descriptions[17]="Previous wallpaper"
    descriptions[20]="Next theme"
    descriptions[21]="Disable opacity"
    descriptions[22]="Manages Monitors using nwg-displays"
    descriptions[25]="Power options"
    descriptions[26]="Next wallpaper"
    descriptions[29]="Only restores dots from default"
    descriptions[30]="System information"
    descriptions[31]="Default border angle animation"
    descriptions[32]="Restores dots from previous backup"
    descriptions[33]="Set wallbash mode. [0] [1] [2] [3] "
    descriptions[35]="Set pref Hyde branch"
    descriptions[36]="Toggle to use wallpaper accent themes"
    descriptions[37]="Previous theme"
    descriptions[38]="Backing up commands"
    descriptions[39]="Reset changes"
    descriptions[40]="Watches hyprland events and executes actions"
    descriptions[42]="Cycles wallbash [0] off [1] auto [2] dark [3] light"
    descriptions[43]="Default opacity"
    descriptions[44]="Glyph selector"
    descriptions[45]="Set theme"
    descriptions[46]="Patch a theme from different repository"
    descriptions[47]="Disable border angle animation"
    descriptions[48]="Emoji selector "
    descriptions[49]="Pastebin manager"
    descriptions[50]="Set /Path/to/Wallpapers as new wallpaper directory"
    descriptions[51]="Clear some storage by deleting old backups"
    descriptions[52]="Force rebuild cache"
    descriptions[53]="Default animations"
    descriptions[54]="User/Device specific scripts that might be useful"
    descriptions[55]="Use rofi to select screenshot options"
    descriptions[56]="Theme selector"
    descriptions[57]="Screenshot and screenrecord tool"
    descriptions[58]="Wallpaper Cache"
    descriptions[59]="Sddm commands"
    descriptions[60]="Restores dots from a clone repository"
    descriptions[61]="Theme commands"
    descriptions[62]="Some Hypr GUI you might want to use"
    descriptions[63]="Wallpaper selector"
    descriptions[64]="Waybar commands"
    descriptions[65]="Disable animations"
    descriptions[66]="Upgrades dots from the repository "
    descriptions[67]="Executables"
    descriptions[69]="Default blur"
    descriptions[70]="Show manual"

    local -A literal_transitions
    literal_transitions[1]="([54]=2 [4]=4 [25]=5 [59]=6 [6]=4 [61]=7 [7]=8 [30]=4 [62]=9 [8]=10 [64]=11 [66]=4 [11]=4 [35]=4 [67]=12 [36]=13 [13]=14 [38]=15 [15]=16)"
    literal_transitions[2]="([68]=4)"
    literal_transitions[5]="([24]=21 [39]=4 [2]=4 [23]=19)"
    literal_transitions[6]="([34]=4)"
    literal_transitions[7]="([56]=4 [20]=4 [37]=4 [45]=4 [46]=4)"
    literal_transitions[8]="([50]=4 [63]=4 [26]=4 [17]=4)"
    literal_transitions[9]="([22]=4 [44]=4 [1]=4 [55]=4 [48]=4 [49]=4)"
    literal_transitions[10]="([41]=4)"
    literal_transitions[11]="([19]=4)"
    literal_transitions[12]="([40]=4 [57]=4)"
    literal_transitions[13]="([42]=4 [33]=20)"
    literal_transitions[14]="([10]=4 [29]=4 [60]=4 [32]=4)"
    literal_transitions[15]="([16]=4 [51]=4 [5]=4 [14]=4)"
    literal_transitions[16]="([58]=4 [52]=4)"
    literal_transitions[17]="([3]=18)"
    literal_transitions[18]="([70]=4)"
    literal_transitions[19]="([21]=4 [12]=4 [47]=4 [65]=4)"
    literal_transitions[20]="([18]=4 [28]=4 [27]=4 [9]=4)"
    literal_transitions[21]="([43]=4 [31]=4 [53]=4 [69]=4)"

    local -A match_anything_transitions
    match_anything_transitions=([1]=3 [3]=17)

    declare -A subword_transitions

    local state=1
    local word_index=2
    while [[ $word_index -lt $CURRENT ]]; do
        if [[ -v "literal_transitions[$state]" ]]; then
            local -A state_transitions
            eval "state_transitions=${literal_transitions[$state]}"

            local word=${words[$word_index]}
            local word_matched=0
            for ((literal_id = 1; literal_id <= $#literals; literal_id++)); do
                if [[ ${literals[$literal_id]} = "$word" ]]; then
                    if [[ -v "state_transitions[$literal_id]" ]]; then
                        state=${state_transitions[$literal_id]}
                        word_index=$((word_index + 1))
                        word_matched=1
                        break
                    fi
                fi
            done
            if [[ $word_matched -ne 0 ]]; then
                continue
            fi
        fi

        if [[ -v "match_anything_transitions[$state]" ]]; then
            state=${match_anything_transitions[$state]}
            word_index=$((word_index + 1))
            continue
        fi

        return 1
    done

    completions_no_description_trailing_space=()
    completions_no_description_no_trailing_space=()
    completions_trailing_space=()
    suffixes_trailing_space=()
    descriptions_trailing_space=()
    completions_no_trailing_space=()
    suffixes_no_trailing_space=()
    descriptions_no_trailing_space=()

    if [[ -v "literal_transitions[$state]" ]]; then
        local -A state_transitions
        eval "state_transitions=${literal_transitions[$state]}"

        for literal_id in ${(k)state_transitions}; do
            if [[ -v "descriptions[$literal_id]" ]]; then
                completions_trailing_space+=("${literals[$literal_id]}")
                suffixes_trailing_space+=("${literals[$literal_id]}")
                descriptions_trailing_space+=("${descriptions[$literal_id]}")
            else
                completions_no_description_trailing_space+=("${literals[$literal_id]}")
            fi
        done
    fi

    local maxlen=0
    for suffix in ${suffixes_trailing_space[@]}; do
        if [[ ${#suffix} -gt $maxlen ]]; then
            maxlen=${#suffix}
        fi
    done
    for suffix in ${suffixes_no_trailing_space[@]}; do
        if [[ ${#suffix} -gt $maxlen ]]; then
            maxlen=${#suffix}
        fi
    done

    for ((i = 1; i <= $#suffixes_trailing_space; i++)); do
        if [[ -z ${descriptions_trailing_space[$i]} ]]; then
            descriptions_trailing_space[$i]="${(r($maxlen)( ))${suffixes_trailing_space[$i]}}"
        else
            descriptions_trailing_space[$i]="${(r($maxlen)( ))${suffixes_trailing_space[$i]}} -- ${descriptions_trailing_space[$i]}"
        fi
    done

    for ((i = 1; i <= $#suffixes_no_trailing_space; i++)); do
        if [[ -z ${descriptions_no_trailing_space[$i]} ]]; then
            descriptions_no_trailing_space[$i]="${(r($maxlen)( ))${suffixes_no_trailing_space[$i]}}"
        else
            descriptions_no_trailing_space[$i]="${(r($maxlen)( ))${suffixes_no_trailing_space[$i]}} -- ${descriptions_no_trailing_space[$i]}"
        fi
    done

    compadd -Q -a completions_no_description_trailing_space
    compadd -Q -S ' ' -a completions_no_description_no_trailing_space
    compadd -l -Q -a -d descriptions_trailing_space completions_trailing_space
    compadd -l -Q -S '' -a -d descriptions_no_trailing_space completions_no_trailing_space
    return 0
}

compdef _Hyde Hyde
