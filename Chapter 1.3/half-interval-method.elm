module Main exposing (main)

import Html exposing (Html)
import Result exposing (..)

square x =
    x * x

isEven x =
    rem x 2 == 0

exponent b n =
    let
        fastExpIter b n a =
            if n == 0 then
                a
            else if isEven n then
                fastExpIter (square b) (n / 2) a
            else
                fastExpIter b (n - 1) (a * b)
    in
        fastExpIter b n 1

average a b = 
    (a + b) / 2

closeEnough a b =
    abs (a - b) < 0.001
    
squareShift y x = x * x + y

search f negPoint posPoint = 
    let
        midPoint = average negPoint posPoint
    in
        if closeEnough negPoint posPoint then
            midPoint
        else
            let
                testValue = f midPoint
            in
                if testValue > 0 then
                    search f negPoint midPoint
                else if testValue < 0 then
                    search f midPoint posPoint
                else
                    -- if the midpoint is where the function is actually at a zero
                    midPoint

halfIntervalMethod : (Float -> Float) -> Float -> Float -> Maybe Float
halfIntervalMethod f a b =
    let
        aValue = f a
        bValue = f b
    in
        if aValue < 0 && bValue > 0 then
            Just (search f a b)
        else if aValue > 0 && bValue < 0 then
            Just (search f b a)
        else if aValue == 0 then
            Just a
        else if bValue == 0 then
            Just b
        else
            Nothing
            
cubic x = 
    (exponent x 3) - (2 * x) - 3

main : Html msg
main =
    if halfIntervalMethod cubic 1 2 == Nothing then
        Html.text "There are no real roots to this equation"
    else
        halfIntervalMethod cubic 1 2
            |> toString
            |> Html.text
