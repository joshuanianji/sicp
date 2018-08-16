module Vectors exposing (..)

-- literally 2.46.elm lmao


type alias Vector =
    ( Float, Float )


makeVect : Float -> Float -> Vector
makeVect a b =
    ( a, b )


xVect : Vector -> Float
xVect vector =
    Tuple.first vector


yVect : Vector -> Float
yVect vector =
    Tuple.second vector


addVect : Vector -> Vector -> Vector
addVect vect1 vect2 =
    let
        ( a, b ) =
            vect1

        ( c, d ) =
            vect2
    in
    ( a + c, b + d )


subVect : Vector -> Vector -> Vector
subVect vect1 vect2 =
    let
        ( a, b ) =
            vect1

        ( c, d ) =
            vect2
    in
    ( a - c, b - d )


scaleVect : Vector -> Float -> Vector
scaleVect vector scale =
    let
        ( a, b ) =
            vector
    in
    ( scale * a, scale * b )
