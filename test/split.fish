function setup
  set -l directory (dirname (dirname (status -f)))
  functions -e string
  source $directory/functions/string.fish
end

test "split 1: string split . example.com"
  (string split . example.com) = "example" "com"
end

test "split 2: string split -r -m1 / /usr/local/bin/fish"
  (string split -r -m1 / /usr/local/bin/fish) = "/usr/local/bin" "fish"
end

test "split 3: split '' abc"
  (string split '' abc) = "a" "b" "c"
end

function teardown
    functions -e string
end
