module Main exposing (main)

import Html exposing (..)

import FoundationMath  as Math exposing (isEven, square)

fib : Float -> Int
fib n = 
    fibIter 1 0 0 1 n

specialTransformA : Int -> Int -> Int -> Int -> Int
specialTransformA x y r s = 
    y * s + x * s + x * r
    
specialTransformB : Int -> Int -> Int -> Int -> Int
specialTransformB x y r s = 
    y * r + x * s

fibIter : Int -> Int -> Int -> Int -> Float -> Int
fibIter a b p q count = 
    if count == 0 then
        b
    else if Math.isEven count then
        fibIter a
                b
                ((Math.square p) + (Math.square q))
                ((Math.square q) + 2*p*q)
                (count / 2)
    else 
        fibIter (specialTransformA a b p q)
                (specialTransformB a b p q)
                p 
                q 
                (count - 1)

main : Html msg
main =
    text (toString (fib 22))