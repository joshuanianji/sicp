module Main exposing (main)

import Html exposing (Html)


-- i have to change isEven to wok on floats


square x =
    x * x

identity x = 
    x


inc x =
    x + 1


returnTrue x =
    True


gcd a b =
    if b == 0 then
        a
    else
        gcd b (rem a b)

isRelativelyPrime a b =
    gcd a b == 1

accumulateIter combiner nullValue term a next b =
    let
        iter a result =
            if a > b then
                result
            else
                iter (next a) (combiner result (term a))
    in
    iter a nullValue


filteredAccumulate filter combiner nullValue term a next b =
    let
        iter a result =
            if a > b then
                result
            else
            -- so if the element satisfies the filter
            if
                filter a
            then
                iter (next a) (combiner result (term a))
            else
                iter (next a) (combiner result nullValue)
    in
    iter a nullValue


sum term a next b =
    filteredAccumulate returnTrue (+) 0 term a next b


product term a next b =
    filteredAccumulate returnTrue (*) 1 term a next b


isPrime n =
    let
        isDivisible a b =
            rem a b == 0

        findDivisor n testDivisor =
            if square testDivisor > n then
                n
            else if isDivisible n testDivisor then
                testDivisor
            else
                findDivisor n (testDivisor + 1)

        smallestDivisor n =
            findDivisor n 2
    in
    n == smallestDivisor n


sumSquaresPrime a b =
    filteredAccumulate isPrime (+) 0 square a inc b
    
productRelPrime n =
    filteredAccumulate (isRelativelyPrime n) (*) 1 identity 0 inc n


main : Html msg
main =
    productRelPrime 10
        |> toString
        |> Html.text
