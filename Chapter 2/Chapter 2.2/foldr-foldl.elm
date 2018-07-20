module Main exposing (main)

import Html exposing (Html, li, ul)
import List exposing (..)


-- basically Elm's foldl is different than Scheme's or Haskell's


myList : List Float
myList =
    [ 1, 2, 3 ]


main : Html msg
main =
    ul []
        [ li []
            [ foldr (/) 1 myList
                |> toString
                |> Html.text
            ]
        , li []
            [ foldl (/) 2 myList
                |> toString
                |> Html.text
            ]
        , li []
            [ foldr (::) [] myList
                |> toString
                |> Html.text
            ]
        , li []
            [ foldl (::) [] myList
                |> toString
                |> Html.text
            ]
        ]
