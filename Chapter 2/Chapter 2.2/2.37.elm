module Main exposing (main)

import Debug exposing (..)
import Html exposing (Html)
import List exposing (..)
import List.Extra exposing (..)


prune : Maybe a -> a
prune x =
    case x of
        Just y ->
            y

        Nothing ->
            Debug.crash "error: fromJust Nothing"


type alias Vector number =
    List number


type alias Matrix number =
    List (Vector number)


dotProduct : Vector number -> Vector number -> number
dotProduct v w =
    foldr (+) 0 (map2 (*) v w)


matrixVector : Matrix number -> Vector number -> Vector number
matrixVector m v =
    map (dotProduct v) m


matrixMatrix : Matrix number -> Matrix number -> Matrix number
matrixMatrix m n =
    let
        cols =
            -- lmao I used the transpose thin from List.Extra. I'm not smart enough to mkae it myself.
            transpose n
    in
    map
        (\x -> map (dotProduct x) n)
        m


v1 : Vector Float
v1 =
    [ 1, 2, 3 ]


v2 : Vector Float
v2 =
    [ 5, 6, 7 ]


v3 : Vector Float
v3 =
    [ 0, 2, 10 ]


v4 : Vector Float
v4 =
    [ 5, 2, 4 ]


m1 : Matrix Float
m1 =
    [ v1, v4, v3 ]


m2 =
    [ v4, v3 ]


main : Html msg
main =
    transpose m1
        |> toString
        |> Html.text
