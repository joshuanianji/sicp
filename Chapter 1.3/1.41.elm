module Main exposing (main)

import Html exposing (Html)

-- applying functions to themselves

double procedure = 
    \x -> procedure (procedure x)
    
inc x = 
    x + 1


main : Html msg
main =
    ((double (double double)) inc) 5
        |> toString
        |> Html.text