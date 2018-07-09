module Main exposing (main)

import Html exposing (Html)


-- repeated application of a function (doesn't work yet)


cube x =
    x * x * x


average a b c =
    (a + b + c) / 3



-- g is the function f is being applied to n times.


repeatedlyApply : (Float -> Float) -> (Float -> Float) -> Int -> (Float -> Float)
repeatedlyApply f g n =
    if n == 0 then
        g
    else
        \x -> f (repeatedlyApply f g (n - 1) x)


smooth : (Float -> Float) -> (Float -> Float)
smooth f =
    let
        dx =
            0.001
    in
    \x -> average (f (x - dx)) (f x) (f (x + dx))


nFoldSmooth : (Float -> Float) -> Int -> (Float -> Float)
nFoldSmooth function iterationCount =
    \x -> (repeatedlyApply smooth function iterationCount) x


main : Html msg
main =
    nFoldSmooth cube 2 3
        |> toString
        |> Html.text
