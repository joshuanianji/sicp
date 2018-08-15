module Main exposing (main)

import Html exposing (Html)
import List


-- The n-queens problems. Returns a list of the queen positions
{-
   For example, queens 4 == [[2,4,1,3],[3,1,4,2]] which means the queens are in positions (1, 2), (2, 4), (3, 1), (4, 3) for the first board, and (1, 3), (2, 1), (3, 4),(4, 2) in the second board.
-}


queens : Int -> List (List Int)
queens boardSize =
    let
        queenCols k =
            if k == 1 then
                List.map
                    (\x -> [ x ])
                    (List.range 1 boardSize)
            else
                List.concatMap
                    (\restOfQueens ->
                        List.filterMap
                            -- we check the validity of the solutions here
                            (\newRow ->
                                adjoinPosition
                                    newRow
                                    k
                                    restOfQueens
                            )
                            (List.range 1 boardSize)
                    )
                    (queenCols (k - 1))
    in
    queenCols boardSize


allTrue : List Bool -> Bool
allTrue list =
    List.foldr
        (&&)
        True
        list


adjoinPosition : Int -> Int -> List Int -> Maybe (List Int)
adjoinPosition newQueen rowSize restOfQueens =
    let
        -- a list of tuples containing the old queen position and its index
        newList =
            List.map2
                (,)
                restOfQueens
                (List.range 1 rowSize)

        -- a list of booleans
        safeList =
            let
                queenX =
                    rowSize

                queenY =
                    newQueen
            in
            -- iterates through the list of old queens and their indexes.
            List.map
                (\( oldQueenY, oldQueenX ) ->
                    isSafe queenX queenY oldQueenX oldQueenY
                )
                newList
    in
    if allTrue safeList then
        Just (List.append restOfQueens [ newQueen ])
    else
        Nothing



-- looks at one queen and one old queen at a time


isSafe : Int -> Int -> Int -> Int -> Bool
isSafe queenX queenY oldQueenX oldQueenY =
    if queenY == oldQueenY then
        False
    else if abs (oldQueenX - queenX) == abs (oldQueenY - queenY) then
        False
    else
        True


main : Html msg
main =
    List.length (queens 10)
        |> toString
        |> Html.text
