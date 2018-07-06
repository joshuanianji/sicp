module GoodMath exposing (..)

square x =
    x * x

isEven x =
    rem x 2 == 0
    
isPrime n = 
    let
        isDivisible a b = 
            (rem a b) == 0

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