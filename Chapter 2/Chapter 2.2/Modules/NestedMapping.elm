module NestedMapping exposing (..)

import List exposing (..)


--nested mappings stuff I copied from Scheme
-- Basic functions


isPrime : Int -> Bool
isPrime n =
    let
        isDivisible a b =
            rem a b == 0

        square x =
            x * x

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


isPrimeSum : ( Int, Int ) -> Bool
isPrimeSum pair =
    let
        ( a, b ) =
            pair
    in
    isPrime (a + b)


makePairSum : ( Int, Int ) -> List Int
makePairSum pair =
    let
        ( a, b ) =
            pair
    in
    [ a, b, a + b ]



-- higher order functions


flatMap : (a -> List b) -> List a -> List b
flatMap proc seq =
    foldr
        append
        []
        (map proc seq)



--actual thing


primeSumPairs : Int -> List (List Int)
primeSumPairs n =
    map makePairSum
        (filter
            isPrimeSum
            (flatMap
                (\i ->
                    map
                        (\j ->
                            ( i, j )
                        )
                        (range 1 (i - 1))
                )
                (range 1 n)
            )
        )
