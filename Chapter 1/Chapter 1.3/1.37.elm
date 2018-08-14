module Main exposing (main)

import Html exposing (Html)


-- iterative fibonacci requence


return1 x =
    1


contFracRecursive : (Float -> Float) -> (Float -> Float) -> Int -> Float -> Float
contFracRecursive n d k i =
    if k == 1 then
        n i / d i
    else
        n i / (d i + contFracRecursive n d (k - 1) (i + 1))


contFrac n d k =
    contFracRecursive n d k 1


contFracIter n d k answer =
    if k == 0 then
        answer
    else
        contFracIter n d (k - 1) (n k / (d k + answer))


main : Html msg
main =
    contFracIter return1 return1 11 0
        |> toString
        |> Html.text
