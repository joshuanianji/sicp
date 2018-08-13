module Main exposing (main)

import Html exposing (Html)
import Tuple exposing (..)


-- area and perimeter of rectangles lol


type alias Point =
    ( Float, Float )


type alias Line =
    ( Point, Point )


type alias Rectangle =
    { width : Float
    , height : Float
    , center : Point
    }


makePoint : Float -> Float -> Point
makePoint x y =
    ( x, y )


xPoint : Point -> Float
xPoint point =
    first point


yPoint : Point -> Float
yPoint point =
    second point


makeRectangle : Point -> Float -> Float -> Rectangle
makeRectangle centerPoint width height =
    Rectangle width height centerPoint



-- calculations


rectArea : Rectangle -> Float
rectArea rect =
    rect.width * rect.height


rectPerimeter : Rectangle -> Float
rectPerimeter rect =
    (rect.width + rect.height) * 2



-- some baseline data


centerPoint =
    makePoint 5 5


dumbRectangle =
    makeRectangle centerPoint 10 10


main : Html msg
main =
    rectArea dumbRectangle
        |> toString
        |> Html.text
