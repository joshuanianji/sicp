module Main exposing (main)

import Html exposing (Html)
import Tuple exposing (..)


-- We explore all 4 rudimentary mathematical operations on intervals


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


addInterval : Interval -> Interval -> Interval
addInterval x y =
    makeInterval
        (upper x + upper y)
        (lower x + lower y)


multInterval : Interval -> Interval -> Interval
multInterval x y =
    let
        p1 =
            lower x * lower y

        p2 =
            lower x * upper y

        p3 =
            upper x * lower y

        p4 =
            upper x * upper y
    in
    makeInterval
        -- because max and min only accept two parameters
        (min p1 p2 
            |> min p3 
            |> min p4)
        (max p1 p2 
            |> max p3
            |> max p4)



divideInterval : Interval -> Interval -> Interval
divideInterval x y =
    multInterval
        x
        (makeInterval
            (1 / upper y)
            (1 / lower y)
        )


--The entire point of the exercise
subInterval : Interval -> Interval -> Interval
subInterval x y =
    makeInterval
        (lower x - upper y)
        (upper x - lower y)


main : Html msg
main =
    makeInterval 4 5
        |> toString
        |> Html.text
