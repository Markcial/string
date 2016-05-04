function setup
  set -l directory (dirname (dirname (status -f)))
  functions -e string
  source $directory/functions/string.fish
end

test "escape 1: echo \\x07 | string escape"

end


function teardown
  functions -e string
end
