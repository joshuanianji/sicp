module Main exposing (main)

import Html exposing (Html)

-- i have to change isEven to wok on floats
isEven : Float -> Bool
isEven x = 
    toFloat( floor (x / 2) * 2 ) == x

cube : Float -> Float
cube x = 
    x * x * x

inc x =
    x + 1

-- the type notations were such a damn headache
sum : (Float -> Float) -> Float -> (Float -> Float) -> Float -> Float
sum term a next b =
    if a > b then
        0
    else 
        (term a) + (sum term (next a) next b)

-- idk lmao
integral f a b dx =
    let
        addDx x =
            x + dx
    in
        dx * (sum f (a + dx / 2) addDx b)
            
--this is using simpson's rule
simpsonIntegral : (Float -> Float) -> Float -> Float -> Float -> Float
simpsonIntegral f a b n = 
    let
        h = (b - a) / n
        y k =
            if isEven k then
                2 * f (a + k * h)
            else 
                4 * f (a + k * h)
    in
        (h / 3) * (f a + f b + (sum y 1 inc (n - 1)))

main : Html msg
main =
    simpsonIntegral cube 0 1 1000
        |> toString
        |> Html.text
