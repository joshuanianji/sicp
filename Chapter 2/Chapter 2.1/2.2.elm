module Main exposing (main)

import Html exposing (Html)
import Tuple exposing (..)


type alias Point =
    ( Float, Float )


type alias Line =
    ( Point, Point )


average : Float -> Float -> Float
average a b =
    (a + b) / 2


makePoint : Float -> Float -> Point
makePoint x y =
    ( x, y )


xPoint : Point -> Float
xPoint point =
    first point


yPoint : Point -> Float
yPoint point =
    second point


stringPoint : Point -> String
stringPoint point =
    --cuz it's basically a tuple lmao
    toString point


makeSegment : Point -> Point -> Line
makeSegment startPoint endPoint =
    ( startPoint, endPoint )


startSegment : Line -> Point
startSegment line =
    first line


endSegment : Line -> Point
endSegment line =
    second line



-- calculations


midPoint : Line -> Point
midPoint lineSegment =
    ( average (xPoint (startSegment lineSegment)) (xPoint (endSegment lineSegment))
    , average (yPoint (startSegment lineSegment)) (yPoint (endSegment lineSegment))
    )



-- some baseline data


point1 =
    makePoint 4 5


point2 =
    makePoint 3 6


segment1 =
    makeSegment point1 point2


pointMid =
    midPoint segment1


main : Html msg
main =
    pointMid
        |> stringPoint
        |> Html.text
