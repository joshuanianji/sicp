module FoundationMath exposing (..)

square : number -> number
square n = 
    n * n

cube : Float -> Float
cube x =
    x * x * x

isEven : Int -> Bool
isEven n =
    rem n 2 == 0

fib : Int -> Int
fib n =
    case n of
        0 -> 0
        1 -> 1
        _ -> fib (n-1) + fib (n-2)

exp : number -> number -> number
exp a b = 
    if b == 0 then
        1
    else 
        a * (exp a (b - 1))

gcd : Int -> Int -> Int
gcd a b =
    if b == 0 then
       a
    else
        gcd b (rem a b)
        
double x = 
    x + x

half x = 
    x / 2

