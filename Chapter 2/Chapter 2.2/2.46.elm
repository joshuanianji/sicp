module Main exposing (..)

import Html exposing (Html)
import Vectors exposing (..)


-- just pointing to the vector library lol


main : Html msg
main =
    makeVect 3 4
        |> toString
        |> Html.text
