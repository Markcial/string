function setup
  set -l directory (dirname (dirname (status -f)))
  functions -e string
  source $directory/functions/string.fish
end


function teardown
    functions -e string
end
