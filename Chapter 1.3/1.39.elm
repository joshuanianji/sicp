module Main exposing (main)

import Html exposing (Html)


square x =
    x * x


odd x =
    2 * x - 1


tanContFracIter x k answer =
    if k == 1 then
        x / (1 - answer)
    else
        tanContFracIter x (k - 1) (square x / (odd k - answer))


tanContFrac x k =
    tanContFracIter x k 0


main : Html msg
main =
    tanContFrac (pi / 3) 500
        |> toString
        |> Html.text
