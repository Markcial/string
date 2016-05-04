function setup
  set -l directory (dirname (dirname (status -f)))
  functions -e string
  source $directory/functions/string.fish
end

test "match 1: string match '?' a"
   (string match '?' a) = "a"
end

test "match 2: string match 'a*b' axxb"
   (string match 'a*b' axxb) = "axxb"
end

test "match 3: string match -i 'a??B' Axxb"
   (string match -i 'a??B' Axxb) = "Axxb"
end

test "match 4: echo 'ok?' | string match '*\\?'"
   (echo 'ok?' | string match '*\\?') = "ok?"
end

test "match 5: string match -r -v "c.*[12]" {cat,dog}(seq 1 4)"
   (string match -r -v "c.*[12]" {cat,dog}(seq 1 4)) = "dog1"
                                                        "dog2"
                                                        "cat3"
                                                        "dog3"
                                                        "cat4"
                                                        "dog4"
end

test "match 6: string match -r 'cat|dog|fish' 'nice dog'"
    (string match -r 'cat|dog|fish' 'nice dog') = "dog"
end

test "match 7: string match -r '(\\d\\d?):(\\d\\d):(\\d\\d)' \asis{2:34:56}"
    (string match -r '(\\d\\d?):(\\d\\d):(\\d\\d)' \asis{2:34:56}) = "2:34:56"
                                                                      "2"
                                                                      "34"
                                                                      "36"
end

test "match 8: string match -r '^(\\w{{2,4}})\\g1\$' papa mud murmur"
    (string match -r '^(\\w{{2,4}})\\g1$' papa mud murmur) = "papa"
                                                              "pa"
                                                              "murmur"
                                                              "mur"
end

test "match 9: string match -r -a -n at ratatat"
    (string match -r -a -n at ratatat) = "2 2"
                                          "4 2"
                                          "6 2"
end

test "match 10: string match -r -i '0x[0-9a-f]{{1,8}}' 'int magic = 0xBadC0de;'"
    (string match -r -i '0x[0-9a-f]{{1,8}}' 'int magic = 0xBadC0de;') = "0xBadC0de"
end

function teardown
  functions -e string
end
