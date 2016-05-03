set -l strs I am the fisherman
set -l lens 1 2 3 9

test "$TESTNAME: Exit 1 if argv == 0"
    (str length; echo $status) = 1
end

test "$TESTNAME: Exit 1 if length(s) == 0"
    0 1 = (str length ""; echo $status)
end

for i in (seq (count $strs))
    set -l s $strs[$i]

    test "$TESTNAME: $lens[$i] = (str length $s)"
        $lens[$i] = (str length $s)
    end
end

test "$TESTNAME: Sdin"
    "$lens" = (printf "%s\n" $strs | str length | xargs)
end

test "$TESTNAME: Exit non zero if length(s) > 0 in quiet mode"
    0 = (str length -q fisherman; echo $status)
end

test "$TESTNAME: Exit 1 if string is empty in quiet mode"
    1 = (str length -q ""; echo $status)
end
