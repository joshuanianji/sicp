module Main exposing (main)

import Html exposing (Html)


--composite functions


double procedure =
    \x -> procedure (procedure x)


inc x =
    x + 1


square x =
    x * x


compose f g =
    \x -> f (g x)


main : Html msg
main =
    compose square inc 6
        |> toString
        |> Html.text
