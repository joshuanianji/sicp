module Main exposing (main)

import Html exposing (Html, li, text, ul)
import List exposing (..)


--uusing Elm's foldl way


myList : List Int
myList =
    [ 1, 2, 3, 4, 5 ]


reverseRight : List a -> List a
reverseRight sequence =
    foldr
        (\element acc -> append acc [ element ])
        []
        sequence


reverseLeft : List a -> List a
reverseLeft sequence =
    foldl
        (::)
        []
        sequence


toHtml : a -> Html msg
toHtml a =
    a
        |> toString
        |> Html.text


main : Html msg
main =
    ul []
        [ li [] [ toHtml (reverseLeft myList) ]
        , li [] [ toHtml (reverseRight myList) ]
        ]
