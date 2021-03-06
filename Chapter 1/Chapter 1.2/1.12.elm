module Main exposing (main)

import Html exposing (..)


factorial : Int -> Int
factorial n =
    if n == 0 then
        1
    else if n == 1 then
        1
    else
        n * factorial (n - 1)


combination : Int -> Int -> Int
combination n r =
    factorial n // (factorial r * factorial (n - r))



-- pascalMatrix 1 1 i the apex of the triangle


pascalMatrix : Int -> Int -> Int
pascalMatrix row column =
    combination (row - 1) (column - 1)


main : Html msg
main =
    ul []
        [ li [] [ text (toString (pascalMatrix 2 2)) ]
        ]
