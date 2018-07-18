module Main exposing (main)

import Debug exposing (..)
import Html exposing (Html)
import List as List exposing (..)
import Maybe exposing (..)
import String.Extra exposing (replace)


prune : Maybe a -> a
prune x =
    case x of
        Just y ->
            y

        Nothing ->
            Debug.crash (toString x ++ " error: fromJust Nothing")


type NestedList a
    = Null
    | Element a
    | Nested (List (NestedList a))


toList : NestedList a -> List a
toList nested =
    let
        recur node acc =
            case node of
                Element a ->
                    a :: acc

                Nested list ->
                    List.foldr recur acc list

                Null ->
                    acc
    in
    recur nested []



-- i used curly brackets to indicate where the Nested stuff wrap around.


toStringNested : NestedList a -> String
toStringNested nestedList =
    let
        stringNested =
            toString nestedList
    in
    stringNested
        |> replace "Nested" ""
        |> replace "Element" ""
        |> replace "(" "{"
        |> replace ")" "}"
        |> replace " " ""
        |> replace "[" "[ "
        |> replace "]" " ]"
        |> replace "," ", "



-- equivalent tp [[1, 2, [3, 5]], 4]


nestedList : NestedList Int
nestedList =
    Nested
        [ Nested
            [ Element 1
            , Element 2
            , Nested
                [ Element 3
                , Element 5
                ]
            ]
        , Element 4
        ]


nestedListSimple : NestedList Int
nestedListSimple =
    Nested
        [ Nested
            [ Element 1
            , Element 2
            ]
        , Element 3
        ]


singleNestedList : NestedList Int
singleNestedList =
    Element 3


myPairList : NestedList Int
myPairList =
    Nested
        [ Element 3
        , Element 5
        ]


nullList : NestedList Int
nullList =
    Null



-- Works!!


isPair : NestedList a -> Bool
isPair x =
    case x of
        -- Whoa boy this works?? Lmao. Idk amn putting "Nested (List (NestedList a))" results in a "cannot find pattern "List". Idk man
        Nested a ->
            True

        _ ->
            -- if it is null or contains only one element then it is not a pair
            False


isNull : NestedList a -> Bool
isNull x =
    case x of
        Null ->
            True

        _ ->
            False



-- this is horrendous code but it works i guess. it basically analyses all the possibilities ew.


appendNested : NestedList a -> NestedList a -> NestedList a
appendNested x y =
    case x of
        Null ->
            case y of
                Null ->
                    Null

                _ ->
                    y

        Nested list ->
            case y of
                Null ->
                    x

                Element a ->
                    Nested
                        (prune (shave x) ++ [ y ])

                Nested list ->
                    Nested
                        (List.append
                            (prune (shave x))
                            (prune (shave y))
                        )

        Element a ->
            case y of
                Null ->
                    x

                Element a ->
                    Nested
                        [ x
                        , y
                        ]

                Nested list ->
                    Nested
                        (x :: prune (shave y))



-- removes the "Nested" from in front of the nested list.


shave : NestedList a -> Maybe (List (NestedList a))
shave x =
    case x of
        Element a ->
            Nothing

        Nested list ->
            Just list

        Null ->
            Nothing


car : NestedList a -> NestedList a
car x =
    case x of
        Nested list ->
            case head list of
                Nothing ->
                    Null

                Just a ->
                    Nested [ a ]

        _ ->
            x


cdr : NestedList a -> NestedList a
cdr x =
    case x of
        Nested list ->
            case tail list of
                Nothing ->
                    Null

                Just a ->
                    Nested a

        _ ->
            Null


reverse : NestedList a -> NestedList a
reverse list =
    if isNull list then
        Null
    else
        appendNested (reverse (cdr list))
            (car list)


deepReverse : NestedList a -> NestedList a
deepReverse list =
    case list of
        Nested a ->
            appendNested (deepReverse (cdr list))
                (deepReverse (car list))

        _ ->
            list


main : Html msg
main =
    -- appendNested nestedList singleNestedList
    deepReverse nestedListSimple
        |> toStringNested
        |> Html.text
