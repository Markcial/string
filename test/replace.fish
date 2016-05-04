function setup
  set -l directory (dirname (dirname (status -f)))
  functions -e string
  source $directory/functions/string.fish
end

test "replace 1: string replace is was 'blue is my favorite'"
  (string replace is was 'blue is my favorite') = "blue was my favorite"
end

test "replace 2: string replace 3rd last 1st 2nd 3rd"
  (string replace 3rd last 1st 2nd 3rd) = "1st"
                                          "2nd"
                                          "last"
end

test "replace 3: string replace -a ' ' _ 'spaces to underscores'"
  (string replace -a ' ' _ 'spaces to underscores') = "spaces_to_underscores"
end

test "replace 4: string replace -r -a '[^\\d.]+' ' ' '0 one two 3.14 four 5x'"
  (string replace -r -a '[^\\d.]+' ' ' '0 one two 3.14 four 5x') = "0 3.14 5"
end

test "replace 5: string replace -r '(\\w+)\\s+(\\w+)' '\$2 \$1 \$\$' 'left right'"
  (string replace -r '(\\w+)\\s+(\\w+)' '$2 $1 $$' 'left right') = 'right left $'
end

test "replace 6: string replace -r '\\s*newline\\s*' '\\n' 'put a newline here'"
  (string replace -r '\\s*newline\\s*' '\\n' 'put a newline here') = "put a"
                                                                      "here"
end

function teardown
  functions -e string
end
