module Main exposing (main)

import Html exposing (Html, li, text, ul)
import Maybe exposing (..)
import String.Extra exposing (replace)



-- Binary mobiles


type BinaryMobile
    = Weight Float
    | Branches ( Branch, Branch )


type alias Branch =
    { length : Float
    , structure : BinaryMobile
    }



-- constructors


makeWeight : Float -> BinaryMobile
makeWeight weight =
    Weight weight


makeMobile : Branch -> Branch -> BinaryMobile
makeMobile left right =
    Branches ( left, right )


makeBranch : Float -> BinaryMobile -> Branch
makeBranch length structure =
    Branch length structure



--deconstructors


leftBranch : BinaryMobile -> Maybe Branch
leftBranch mobile =
    case mobile of
        Weight float ->
            Nothing

        Branches ( left, right ) ->
            Just left


rightBranch : BinaryMobile -> Maybe Branch
rightBranch mobile =
    case mobile of
        Weight float ->
            Nothing

        Branches ( left, right ) ->
            Just right


branchLength : Branch -> Float
branchLength branch =
    branch.length


branchStructure : Branch -> BinaryMobile
branchStructure branch =
    branch.structure


totalWeight : BinaryMobile -> Float
totalWeight mobile =
    case mobile of
        Weight weight ->
            weight

        Branches ( left, right ) ->
            totalWeight left.structure + totalWeight right.structure



-- other functions


branchTorque : Branch -> Float
branchTorque branch =
    let
        -- basically recursively going through the higher branaches.
        upperTorque =
            case branch.structure of
                Weight weight ->
                    weight

                Branches ( right, left ) ->
                    branchLength right * branchLength left * branchTorque right * branchTorque left
    in
        branchLength branch * upperTorque


isBalanced : BinaryMobile -> Bool
isBalanced mobile =
    case mobile of
        Weight weight ->
            True

        Branches ( right, left ) ->
            branchTorque left == branchTorque right


-- my binary mobile functions


binaryTest : BinaryMobile
binaryTest =
    makeMobile
        (makeBranch 10 (makeWeight 20))
        (makeBranch 20 (makeWeight 10))


layeredBinary : BinaryMobile
layeredBinary =
    makeMobile
        (makeBranch 40 binaryTest)
        (makeBranch 10
            (makeMobile
                (makeBranch 1 (makeWeight 1))
                (makeBranch 4 binaryTest)
            )
        )


balancedBinary : BinaryMobile
balancedBinary = 
    makeMobile
        (makeBranch 40 binaryTest)
        (makeBranch 40 binaryTest)


-- misc functions to deal with random stuff


binaryToString : BinaryMobile -> String
binaryToString nestedList =
    let
        stringNested =
            toString nestedList
    in
    stringNested
        |> replace "Nested" ""
        |> replace "Element" ""
        |> replace "(" "( "
        |> replace ")" " )"
        |> replace "," ", "


main : Html msg
main =
    ul []
        [ li []
            [ balancedBinary
                |> isBalanced
                |> toString
                |> text
            ]
        ]
