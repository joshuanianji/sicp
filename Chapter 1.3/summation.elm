module Summation exposing (main)

import Html exposing (Html)

square x =
    x * x
 
identity x =
    x

cube x =
    x * x * x

inc x =
    x + 1

sum term a next b =
    if a > b then
        0
    else 
        (term a) + (sum term (next a) next b)
        
sumCubes a b =
    sum cube a inc b
    
sumIntegers a b =
    sum identity a inc b
    
piSum a b =
    let 
        piTerm x = 
            1.0 / (x * (x + 2))
        piNext x =
            x + 4
    in
        8 * sum piTerm a piNext b

main : Html msg
main =
    piSum 1 1000
        |> toString
        |> Html.text