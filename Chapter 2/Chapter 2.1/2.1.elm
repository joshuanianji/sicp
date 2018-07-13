module Main exposing (main)

import Html exposing (Html)
import Tuple exposing (..)



-- rational numbers


gcd : Int -> Int -> Int
gcd a b =
    if b == 0 then
        a
    else
        gcd b (rem a b)


makeRat : Int -> Int -> ( Int, Int )
makeRat n d =
    let
        g =
            gcd n d

        gg =
            abs g

        numer =
            (toFloat n * toFloat d) / toFloat (abs d)

        denom =
            abs d
    in
    -- integer division where the remainder is discarded. I don't really care since it'll be divisible anyway
    ( round numer // gg, denom // gg )


numer x =
    first x


denom x =
    second x


stringRat x =
    toString (numer x) ++ "/" ++ toString (denom x)



-- calculations


addRat x y =
    makeRat ((numer x * denom y) + (numer y * denom x))
        (denom x * denom y)


subtractRat x y =
    makeRat ((numer x * denom y) - (numer y * denom x))
        (denom x * denom y)


multRat x y =
    makeRat (numer x * numer y)
        (denom x * denom y)


divideRat x y =
    makeRat (numer x * denom y)
        (denom x * numer y)


isEqual x y =
    (numer x * denom y) == (numer y * denom x)



-- some baseline fractions


oneHalf =
    makeRat 1 2


twoThirds =
    makeRat 2 3


main : Html msg
main =
    subtractRat (makeRat 3 4) (makeRat 5 3)
        |> stringRat
        |> Html.text
