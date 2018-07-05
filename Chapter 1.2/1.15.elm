module Main exposing (main)

import Html exposing (Html)
import FoundationMath exposing (cube)

linearTrig : Float -> Float
linearTrig x =
    (3 * x) - (4 * cube x)

--returns a tuple
sine : Float -> Int -> (Float, Int)
sine angle counter =
    if abs angle < 0.01 then
        -- only happens when the angle is sufficiently small
        (angle, counter)
    else
        let 
            -- the sine function will recursively divide the angle by 3 and increase the counter by 1 until the angle is small enough. Once it is, the sine function will just return the angle and counter into the tuple (f, i). The "in" function will then execute
            (f, i) = sine (angle / 3.0) (counter + 1)
        in
            -- we pass the the first part of the tuple into the linear trig function.
            (linearTrig f, i)

main : Html msg
main =
    Html.text (toString (sine (3.14159265358/2) 0))
