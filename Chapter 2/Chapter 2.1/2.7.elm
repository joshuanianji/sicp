module Main exposing (main)

import Html exposing (Html)
import Tuple exposing (..)


-- making an interval (basically the List.range function)


type alias Interval =
    ( Float, Float )


lower : Interval -> Float
lower x =
    second x


upper : Interval -> Float
upper x =
    first x


makeInterval : Float -> Float -> Interval
makeInterval a b =
    -- lmao Interval is not a function though...thought it would be
    ( a, b )


main : Html msg
main =
    makeInterval 4 5
        |> toString
        |> Html.text
