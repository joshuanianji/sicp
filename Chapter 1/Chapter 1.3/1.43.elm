module Main exposing (main)

import Html exposing (Html)


-- repeated application of a function


inc x =
    x + 1


square x =
    x * x


repeated : (a -> a) -> Int -> (a -> a)
repeated f n =
    if n == 1 then
        f
    else
        \x -> f (repeated f (n - 1) x)


main : Html msg
main =
    repeated square 2 5
        |> toString
        |> Html.text
