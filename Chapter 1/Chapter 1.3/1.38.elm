module Main exposing (main)

import Html exposing (Html)

return1 x =
    1

returnDaddyEuler n =
    if rem (n + 1) 3 == 0 then
        (toFloat (n + 1)) * 2 / 3
    else
        1

contFracRecursive : (Float -> Float) -> (Float -> Float) -> Int -> Float -> Float
contFracRecursive n d k i = 
    if k == 1 then
        (n i) / (d i)
    else 
        (n i) / ((d i) + (contFracRecursive n d (k - 1) (i + 1)))
    
contFrac n d k =
    contFracRecursive n d k 1
    
contFracIter n d k answer =
    if k == 0 then
        answer
    else
        contFracIter n d (k - 1) ( (n k) / ( (d k) + answer) )
    
main : Html msg
main =
    contFracIter return1 returnDaddyEuler 100000 0
        |> (+) 2
        |> toString
        |> Html.text

