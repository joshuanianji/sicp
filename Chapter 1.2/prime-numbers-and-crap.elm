module Main exposing (main)

import Html exposing (..)

import FoundationMath  as Math exposing (square, gcd)
       
-- bigger number first
isDivisible a b = 
    (rem a b) == 0
    
smallestDivisor n = 
    findDivisor n 2

findDivisor n testDivisor = 
    if square testDivisor > n then
        n
    else if isDivisible n testDivisor then
        testDivisor
    else
        findDivisor n (testDivisor + 1)
    
isPrime n = 
    n == smallestDivisor n

main : Html msg
main =
    text (toString (isPrime 22))