function setup
  set -l directory (dirname (dirname (status -f)))
  functions -e string
  source $directory/functions/string.fish
end

test "trim 1: string trim ' abc  '"
  (string trim ' abc  ') = "abc"
end

test "trim 2: string trim --right --chars=yz xyzzy zany"
  (string trim --right --chars=yz xyzzy zany) = "x" "zan"
end

function teardown
    functions -e string
end
