module Main exposing (main)

import Html exposing (Html)
import Maybe exposing (..)
import Tuple exposing (..)


-- this is about Ben's dumbass comment, as well as the center interval width thing


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
        signX1 =
            noZeroSign (upper x)

        signX2 =
            noZeroSign (lower x)

        signY1 =
            noZeroSign (upper y)

        signY2 =
            noZeroSign (lower y)

        signintervalX =
            ( signX1, signX2 )

        signIntervalY =
            ( signY1, signY2 )

        xlow =
            lower x

        ylow =
            lower y

        xhigh =
            upper x

        yhigh =
            upper y
    in
    case signintervalX of
        -- the _ -> possibilities are just for the (Neg, Neg)
        ( Pos, Pos ) ->
            case signIntervalY of
                ( Pos, Pos ) ->
                    makeInterval (xlow * ylow) (xhigh * yhigh)

                ( Neg, Pos ) ->
                    makeInterval (xlow * yhigh) (xhigh * yhigh)

                _ ->
                    makeInterval (xhigh * yhigh) (xlow * ylow)

        ( Neg, Pos ) ->
            case signIntervalY of
                ( Pos, Pos ) ->
                    makeInterval (xlow * yhigh) (xhigh * yhigh)

                ( Neg, Pos ) ->
                    makeInterval
                        (min (xlow * yhigh)
                            (xhigh * ylow)
                        )
                        (max (xhigh * yhigh)
                            (xlow * ylow)
                        )

                _ ->
                    makeInterval (xhigh * yhigh) (xhigh * ylow)

        _ ->
            case signIntervalY of
                ( Pos, Pos ) ->
                    makeInterval (xlow * yhigh) (xhigh * ylow)

                ( Neg, Pos ) ->
                    makeInterval (xlow * yhigh) (xlow * ylow)

                _ ->
                    makeInterval (xhigh * ylow) (xlow * yhigh)


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



-- center width thing


makeCenterWidth : Float -> Float -> Interval
makeCenterWidth c w =
    makeInterval (c - w) (c + w)


center : Interval -> Float
center x =
    (upper x + lower x) / 2



-- lower bound first


main : Html msg
main =
    multInterval (makeInterval -4 2) (makeInterval -6 6)
        |> toString
        |> Html.text
