function setup
  set -l directory (dirname (dirname (status -f)))
  functions -e string
  source $directory/functions/string.fish
end

set -l strs I am the fisherman
set -l lens 1 2 3 9

test "$TESTNAME: Exit 1 if argv == 0"
    (string length; echo $status) = 1
end

test "$TESTNAME: Exit 1 if length(s) == 0"
    0 1 = (string length ""; echo $status)
end

for i in (seq (count $strs))
    set -l s $strs[$i]

    test "$TESTNAME: $lens[$i] = (str length $s)"
        $lens[$i] = (string length $s)
    end
end

test "$TESTNAME: Sdin"
    "$lens" = (printf "%s\n" $strs | string length | xargs)
end

test "$TESTNAME: Exit non zero if length(s) > 0 in quiet mode"
    0 = (string length -q fisherman; echo $status)
end

test "$TESTNAME: Exit 1 if string is empty in quiet mode"
    1 = (string length -q ""; echo $status)
end

function teardown
    functions -e string
end
