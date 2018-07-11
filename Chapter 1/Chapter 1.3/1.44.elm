module Main exposing (main)

import Html exposing (Html)


-- repeated application of a function


cube : Float -> Float
cube x =
    x * x * x


average a b c =
    (a + b + c) / 3



-- g is the function f is being applied to n times.


repeated : (a -> a) -> Int -> (a -> a)
repeated f n =
    if n == 1 then
        f
    else
        \x -> f (repeated f (n - 1) x)


smooth : (Float -> Float) -> (Float -> Float)
smooth f =
    let
        dx =
            0.001
    in
    \x -> average (f (x - dx)) (f x) (f (x + dx))


nFoldSmooth : (Float -> Float) -> Int -> (Float -> Float)
nFoldSmooth f n =
    -- smooth will be applied to itself n times and then f will be a parameter in the resulting function
    repeated smooth n f


main : Html msg
main =
    nFoldSmooth cube 2 4
        |> toString
        |> Html.text
