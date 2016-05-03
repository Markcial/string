


if type -q string
end

function str -d "manipulate strings" -a cmd
    set -e argv[1]
    set -l quiet 0

    for i in -q --quiet
        if set -l index (builtin contains -i -- $i $argv)
            set -e argv[$index]
            set quiet 1
            break
        end
    end

    switch "$cmd"
        case sub
            if not functions -q __string_sub
                function __string_sub -a start len
                    set -e argv[1..2]

                    if isatty
                        if test -z "$argv"
                            return 1
                        end

                        printf "%s\n" $argv | __string_sub "$start" "$len"
                    else
                        if test ! -z "$argv"
                            echo "string sub: Too many arguments $argv" > /dev/stderr
                            return 2
                        end

                        command awk -v start="$start" -v len="$len" '

                            {
                                real_length = length($0)

                                if (len < 0) {
                                    len = real_length
                                }

                                if (start < 0) {
                                    start = real_length + start + 1
                                }

                                print(substr($0, start, len))
                            }

                        '
                    end
                end
            end

            set -l len -1
            set -l start 1
            set -l items

            getopts $argv | while read -l k v
                switch "$k"
                    case l length
                        if test "$v" -lt 0
                            echo "string sub: Invalid length value '$v'" > /dev/stderr
                            return 2
                        end

                        set len "$v"

                    case s start
                        if test "$v" = 0 -o "$v" = -0
                            echo "string sub: Invalid start value '$v'" > /dev/stderr
                            return 2
                        end

                        set start "$v"

                    case \*
                        set items $items "$v"
                end
            end

            __string_sub "$start" "$len" $items

        case length
            # if not functions -q __string_length
                function -S __string_length
                    if set -q argv[1]
                        printf "%s\n" $argv | __string_length
                    else
                        if isatty
                            return 1
                        end

                        command awk -v quiet="$quiet" '

                            {
                                len = length($0)
                                
                                if (quiet == 0) {
                                    print(len)
                                }
                            }

                            END {
                                if (NR <= 1 && len == 0) {
                                    exit 1
                                }
                            }

                        '
                    end
                end
            # end

            __string_length $argv

        case ""
            echo "string: Expected <subcommand>" > /dev/stderr
            __string_usage > /dev/stderr
            return 2

        case \*
            printf "%s\n" "string: Unknown subcommand '$cmd'" > /dev/stderr
            __string_usage > /dev/stderr
            return 2
    end
end

function __string_usage
    echo "Usage: string [<command>] [<options>] [--quiet]"
    echo
    echo "where <command> can be one of:"
    echo "   length <str>"
    echo "   sub"
end
