# source: grok

function __otd_unquote
    set -l t $argv[1]
    if string match -q -- '"*"' -- $t
        string replace -r -- '^"(.*)"$' '$1' $t
    else if string match -q -- "'*'" -- $t
        string replace -r -- "^'(.*)'\$" '$1' $t
    else
        printf '%s\n' $t
    end
end

function __otd_positionals -d 'Completed non-option arguments, excluding the token being typed'
    set -l raw (commandline -opc)
    set -q raw[1]
    and set -e raw[1]
    for t in $raw
        # Only the real global options. Negative numbers (-1, -0.5) are values.
        if contains -- $t -- -h --help --version '-?'
            continue
        end
        __otd_unquote $t
    end
end

function __otd_completing -a n -d 'True when the token under the cursor is positional n (1 = subcommand)'
    set -l have (count (__otd_positionals))
    test $have -eq (math "$n - 1")
end

function __otd_completing_from -a n
    set -l have (count (__otd_positionals))
    test $have -ge (math "$n - 1")
end

function __otd_cmd_at
    set -l n $argv[1]
    set -e argv[1]
    __otd_completing $n
    and __otd_saw_cmd $argv
end

function __otd_cmd_from
    set -l n $argv[1]
    set -e argv[1]
    __otd_completing_from $n
    and __otd_saw_cmd $argv
end

function __otd_saw_cmd
    set -l pos (__otd_positionals)
    set -q pos[1]
    or return 1
    contains -- $pos[1] $argv
end

function __otd_appdata -d 'OpenTabletDriver application data directory'
    if set -q OTD_APP_DATA
        and test -n "$OTD_APP_DATA"
        printf '%s\n' $OTD_APP_DATA
        return
    end

    set -l candidates
    if set -l bin (type -P otd 2>/dev/null)
        set -l real $bin
        if set -l resolved (realpath -- "$bin" 2>/dev/null)
            set real $resolved
        else if set -l resolved (readlink -f -- "$bin" 2>/dev/null)
            set real $resolved
        end
        set -a candidates (dirname -- "$real")/userdata
    end
    if set -q XDG_CONFIG_HOME
        and test -n "$XDG_CONFIG_HOME"
        set -a candidates "$XDG_CONFIG_HOME/OpenTabletDriver"
    end
    set -a candidates "$HOME/.config/OpenTabletDriver"
    set -a candidates "$HOME/Library/Application Support/OpenTabletDriver"
    if set -q LOCALAPPDATA
        and test -n "$LOCALAPPDATA"
        set -a candidates "$LOCALAPPDATA/OpenTabletDriver"
    end

    for d in $candidates
        if test -d "$d"
            printf '%s\n' $d
            return
        end
    end
    printf '%s\n' $candidates[1]
end

function __otd_query -d 'Run `otd <subcommand>` and cache useful stdout for a few seconds'
    set -l sub $argv[1]
    set -l now (date +%s)
    set -l stamp_var __otd_stamp_$sub
    set -l data_var __otd_data_$sub

    if set -q $stamp_var
        set -l age (math "$now - $$stamp_var")
        if test $age -lt 4
            if set -q $data_var
                printf '%s\n' $$data_var
                return 0
            end
            return 1
        end
    end

    set -l lines
    if type -q otd
        set lines (otd $sub 2>/dev/null)
    end

    set -l clean
    for line in $lines
        set line (string trim -- $line)
        test -n "$line"
        or continue
        string match -qr -- '^(OpenTabletDriver Daemon not running|No types found)$' -- $line
        and continue
        set -a clean $line
    end

    set -g $stamp_var $now
    if set -q clean[1]
        set -g $data_var $clean
        printf '%s\n' $clean
        return 0
    end
    set -e $data_var
    return 1
end

function __otd_format_types
    while read -l line
        set line (string trim -- $line)
        test -n "$line"
        or continue
        if string match -qr -- '^[A-Za-z_][A-Za-z0-9_.]* \[.*\]$' -- $line
            set -l path (string replace -r -- '^([A-Za-z_][A-Za-z0-9_.]*) \[(.*)\]$' '$1' $line)
            set -l desc (string replace -r -- '^([A-Za-z_][A-Za-z0-9_.]*) \[(.*)\]$' '$2' $line)
            printf '%s\t%s\n' $path $desc
        else if string match -qr -- '^[A-Za-z_][A-Za-z0-9_.]*$' -- $line
            printf '%s\n' $line
        end
    end
end

function __otd_builtin_types -a kind
    switch $kind
        case listoutputmodes
            printf '%s\t%s\n' \
                OpenTabletDriver.Desktop.Output.AbsoluteMode 'Absolute Mode' \
                OpenTabletDriver.Desktop.Output.RelativeMode 'Relative Mode' \
                OpenTabletDriver.Desktop.Output.LinuxArtistMode 'Artist Mode'
        case listbindings
            printf '%s\t%s\n' \
                OpenTabletDriver.Desktop.Binding.KeyBinding 'Key Binding' \
                OpenTabletDriver.Desktop.Binding.MouseBinding 'Mouse Button Binding' \
                OpenTabletDriver.Desktop.Binding.MouseScrollBinding 'Mouse Scroll Binding' \
                OpenTabletDriver.Desktop.Binding.MultiKeyBinding 'Multi-Key Binding' \
                OpenTabletDriver.Desktop.Binding.PresetBinding 'Preset Binding' \
                OpenTabletDriver.Desktop.Binding.AdaptiveBinding 'Adaptive Binding'
    end
end

function __otd_types -a subcmd
    set -l lines (__otd_query $subcmd | __otd_format_types)
    if not set -q lines[1]
        set lines (__otd_builtin_types $subcmd)
    end
    printf '%s\n' $lines
end

function __otd_types_remaining -a subcmd skip
    set -l pos (__otd_positionals)
    set -l used
    if test (count $pos) -ge $skip
        set used $pos[$skip..-1]
    end
    __otd_types $subcmd | while read -l line
        set -l val (string split \t -f 1 -- $line)
        if set -q used[1]
            and contains -- $val $used
            continue
        end
        printf '%s\n' $line
    end
end

function __otd_tablets
    set -l names
    set -l lines (__otd_query getallsettings)
    for line in $lines
        string match -qr -- "^--- Profile for '.*' ---\$" -- $line
        or continue
        set -a names (string replace -r -- "^--- Profile for '(.*)' ---\$" '$1' $line)
    end
    if not set -q names[1]
        set -l file (__otd_appdata)/settings.json
        if test -f "$file"
            while read -l line
                set -l hits (string match -a -r -- '"Tablet"[[:space:]]*:[[:space:]]*"[^"]*"' -- $line)
                for hit in $hits
                    set -a names (string replace -r -- '.*"([^"]*)".*' '$1' $hit)
                end
            end <"$file"
        end
    end

    set -l seen
    for n in $names
        test -n "$n"
        or continue
        contains -- $n $seen
        and continue
        set -a seen $n
        printf '%s\n' $n
    end
end

function __otd_presets
    set -l lines (__otd_query listpresets)
    if set -q lines[1]
        printf '%s\n' $lines
        return
    end
    set -l dir (__otd_appdata)/Presets
    test -d "$dir"
    or return
    for f in "$dir"/*.json
        test -f "$f"
        or continue
        basename -- "$f" .json
    end
end

function __otd_plugins
    set -l lines (__otd_query listplugins)
    if set -q lines[1]
        printf '%s\n' $lines
        return
    end
    set -l dir (__otd_appdata)/Plugins
    test -d "$dir"
    or return
    for d in "$dir"/*/
        test -d "$d"
        or continue
        set -l name (string replace -r -- '/+$' '' $d)
        set name (string split / -- $name)[-1]
        string match -q -- '*[*]*' -- $name
        and continue
        printf '%s\n' $name
    end
end

function __otd_displays
    __otd_query listdisplays | while read -l line
        string match -qr -- '^[0-9]+:' -- $line
        or continue
        set -l idx (string replace -r -- ':.*$' '' $line)
        set -l desc (string replace -r -- '^[0-9]+:[[:space:]]*' '' $line)
        printf '%s\t%s\n' $idx $desc
    end
end

function __otd_indexes
    for i in 0 1 2 3 4 5 6 7
        printf '%s\tbutton index\n' $i
    end
end

function __otd_files
    # Fish 3 takes `suffix` / `token suffix description`.
    # Fish 4 takes bare suffixes via argparse. Support both.
    functions -q __fish_complete_suffix
    or return 1
    if functions __fish_complete_suffix | string match -q -- '*argparse*'
        __fish_complete_suffix $argv
        return
    end
    __fish_complete_suffix (commandline -ct) $argv[1]
end

function __otd_register -a cmd
    complete -c $cmd -e
    complete -c $cmd -f

    complete -c $cmd -f -s h -l help -d 'Show help and usage information'
    complete -c $cmd -f -s '?' -d 'Show help and usage information'
    complete -c $cmd -f -l version -d 'Show version information'

    set -l subs \
        loadsettings 'Load settings from a file' \
        savesettings 'Save settings to a file' \
        savedefaultsettings 'Save settings to the default settings file' \
        save-defaults 'Save settings to the default settings file' \
        applypreset 'Apply a preset from the Presets directory' \
        savepreset 'Save the current settings to the Presets directory' \
        detect 'Detects tablets' \
        installplugin 'Install plugin from specified file path' \
        uninstallplugin 'Uninstall plugin with specified folder name' \
        getstring 'Requests a device string' \
        setoutputmode 'Sets the output mode' \
        enabletabletfilters 'Enables the specified filters on the specified tablet' \
        disabletabletfilters 'Disables the specified filters on the specified tablet' \
        resettabletfilters 'Resets the specified filters to a default state on the specified tablet' \
        enabletools 'Enables the specified tools' \
        disabletools 'Disables the specified tools' \
        setdisplayarea 'Sets the display area' \
        maptodisplayindex 'Map tablet to display index' \
        settabletarea 'Sets the tablet area' \
        setsensitivity 'Sets the relative sensitivity' \
        settipbinding 'Sets the current tip binding' \
        setpenbinding 'Sets the current pen button bindings' \
        setauxbinding 'Sets the current express key bindings' \
        setresettime 'Sets the reset time in milliseconds' \
        setenableclipping 'Sets whether inputs should be limited to the specified areas' \
        setenablearealimiting 'Sets whether inputs outside of the tablet area should be ignored' \
        setlockaspectratio 'Sets whether to lock tablet width/height to display width/height ratio' \
        getcurrentlog 'Gets the current log' \
        getallsettings 'Gets all current settings' \
        getoutputmode 'Gets the current output mode' \
        getareas 'Gets the current display and tablet area' \
        getsensitivity 'Gets the current relative sensitivity' \
        getbindings 'Gets all current bindings' \
        getmiscsettings 'Gets other uncategorized settings' \
        getfilters 'Gets the currently enabled filters' \
        gettools 'Gets the currently enabled tools' \
        listplugins 'Gets the folder names of installed plugins for use in uninstallplugin' \
        hasupdate 'Check for any updates' \
        installupdate 'Install update' \
        listoutputmodes 'Lists all available output modes' \
        listfilters 'Lists all available filters' \
        listtools 'Lists all available tools' \
        listbindings 'Lists all available binding types' \
        listpresets 'Lists all available presets' \
        listdisplays 'Lists all available displays' \
        getdiagnostics 'Gets diagnostic information' \
        stdio 'Open with standard input and output' \
        editsettings 'Opens the settings file with the editor defined in the EDITOR environment variable'

    while set -q subs[1]
        complete -c $cmd -f -n '__otd_completing 1' -a $subs[1] -d $subs[2]
        set -e subs[1]
        set -e subs[1]
    end

    # Files
    complete -c $cmd -f -k -n '__otd_cmd_at 2 loadsettings load savesettings save' -a '(__otd_files .json)'
    complete -c $cmd -f -k -n '__otd_cmd_at 2 installplugin' -a '(__otd_files .zip)'

    # Names
    complete -c $cmd -f -n '__otd_cmd_at 2 applypreset preset savepreset' -a '(__otd_presets)'
    complete -c $cmd -f -n '__otd_cmd_at 2 uninstallplugin' -a '(__otd_plugins)'

    # Tablet profile, first argument of every per-tablet command.
    set -l tablet_cmds \
        setoutputmode enabletabletfilters disabletabletfilters resettabletfilters \
        setdisplayarea maptodisplayindex settabletarea setsensitivity \
        settipbinding setpenbinding setauxbinding setresettime \
        setenableclipping setenablearealimiting setlockaspectratio \
        getoutputmode getareas getsensitivity getbindings getmiscsettings getfilters
    complete -c $cmd -f -n "__otd_cmd_at 2 $tablet_cmds" -a '(__otd_tablets)'

    # Second argument.
    complete -c $cmd -f -n '__otd_cmd_at 3 setoutputmode' -a '(__otd_types listoutputmodes)'
    complete -c $cmd -f -n '__otd_cmd_at 3 maptodisplayindex' -a '(__otd_displays)'
    complete -c $cmd -f -n '__otd_cmd_at 3 settipbinding setpenbinding setauxbinding' -a '(__otd_types listbindings)'
    complete -c $cmd -f -n '__otd_cmd_at 3 setenableclipping setenablearealimiting setlockaspectratio' -a 'true\tenabled false\tdisabled'

    # Variadic plugin paths. Already-entered paths are skipped.
    complete -c $cmd -f -n '__otd_cmd_from 3 enabletabletfilters disabletabletfilters resettabletfilters' -a '(__otd_types_remaining listfilters 3)'
    complete -c $cmd -f -n '__otd_cmd_from 2 enabletools disabletools' -a '(__otd_types_remaining listtools 2)'

    # Pen / express-key slot. Other integers still work; these are hints.
    complete -c $cmd -f -n '__otd_cmd_at 4 setpenbinding setauxbinding' -a '(__otd_indexes)'
end

__otd_register otd
__otd_register OpenTabletDriver
__otd_register OpenTabletDriver.Console
