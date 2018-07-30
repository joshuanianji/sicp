module Main exposing (main)

import FoundationMath exposing (gcd, square)
import Html exposing (..)


-- bigger number first


isDivisible : Int -> Int -> Bool
isDivisible a b =
    rem a b == 0


findDivisor : Int -> Int -> Int
findDivisor n testDivisor =
    if square testDivisor > n then
        n
    else if isDivisible n testDivisor then
        testDivisor
    else
        findDivisor n (testDivisor + 1)


smallestDivisor : Int -> Int
smallestDivisor n =
    findDivisor n 2


isPrime : Int -> Bool
isPrime n =
    n == smallestDivisor n


main : Html msg
main =
    text (toString (isPrime 22))
