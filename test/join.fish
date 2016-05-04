function setup
  set -l directory (dirname (dirname (status -f)))
  functions -e string
  source $directory/functions/string.fish
end

test "join 1: seq 3 | string join ..."
  (seq 3 | string join ...) = "1...2...3"
end


test "join 1: seq 3 | string join @ foo bar bacon"
  (string join @ foo bar bacon) = "foo@bar@bacon"
end

function teardown
    functions -e string
end
