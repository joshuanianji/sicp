module Main exposing (main)

import Html exposing (Html)
import Maybe exposing (..)
import Tuple exposing (..)


-- Center percentage


type alias Interval =
    ( Float, Float )


type Sign
    = Pos
    | Neg
    | Zero


sign : Float -> Sign
sign x =
    if x < 0 then
        Neg
    else if x > 0 then
        Pos
    else
        Zero



-- cuz I don't want zeroes lmao


noZeroSign : Float -> Sign
noZeroSign x =
    let
        signOfx =
            sign x
    in
    case signOfx of
        Zero ->
            Pos

        _ ->
            signOfx


lower : Interval -> Float
lower x =
    first x


upper : Interval -> Float
upper x =
    second x


makeInterval : Float -> Float -> Interval
makeInterval a b =
    -- lmao Interval is not a function though...thought it would be
    ( a, b )


addInterval : Interval -> Interval -> Interval
addInterval x y =
    makeInterval
        (lower x + lower y)
        (upper x + upper y)


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
            |> min p4
        )
        (max p1 p2
            |> max p3
            |> max p4
        )


divideIntervalRaw : Interval -> Interval -> Maybe Interval
divideIntervalRaw x y =
    if width y == 0 then
        Nothing
    else
        Just
            (multInterval
                x
                (makeInterval
                    (1 / lower y)
                    (1 / upper y)
                )
            )


divideInterval : Interval -> Interval -> Interval
divideInterval a b =
    withDefault
        -- so if the second interval has a width of zero we'll just output zero
        (makeInterval 0 0)
        (divideIntervalRaw a b)


subInterval : Interval -> Interval -> Interval
subInterval x y =
    makeInterval
        (lower x - upper y)
        (upper x - lower y)


width : Interval -> Float
width x =
    (upper x - lower x) / 2



-- percentage thing


makeCenterPercent : Float -> Float -> Interval
makeCenterPercent center percent =
    let
        percentage =
            percent / 100

        lowerBound =
            center * (1 - percentage)

        upperBound =
            center * (1 + percentage)
    in
    makeInterval lowerBound upperBound


percentage : Interval -> Float
percentage x =
    let
        center =
            (upper x + lower x) / 2

        lowerBound =
            lower x
    in
    (1 - (lowerBound / center)) * 100



-- lower bound first


main : Html msg
main =
    makeCenterPercent 10 5
        |> percentage
        |> toString
        |> Html.text
