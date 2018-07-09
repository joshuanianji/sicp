-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/effects/random.html


module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- finding and showing the steps to the solution of x^x = 1000


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { number : Float
    , tests : List FixedPointResult
    , currentNum : Float
    , iterCount : Int
    }


type alias FixedPointResult =
    { testNum : Float
    , answer : Float
    , isCloseEnough : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( Model 23 [] 23 0, Cmd.none )



-- UPDATE


type Msg
    = ChangeNumFromInput String
    | ExecuteFixedPoint


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeNumFromInput inputString ->
            -- this directly takes in the input from the field and changes the model. It also deletes all previous fermat tests
            ( Model (toFloat inputString) [] (toFloat inputString) 0, Cmd.none )

        ExecuteFixedPoint ->
            -- so if the closeEnough is true it will stop. Else it will recursively call the update fucntion
            if closeEnough model.currentNum (fixedPointSingleIteration function model.currentNum) then
                ( Model model.number
                    (FixedPointResult
                        model.currentNum
                        (fixedPointSingleIteration function model.currentNum)
                        (closeEnough model.currentNum (fixedPointSingleIteration function model.currentNum))
                        :: model.tests
                    )
                    (fixedPointSingleIteration function model.currentNum)
                    (model.iterCount + 1)
                , Cmd.none
                )
            else
                update
                    ExecuteFixedPoint
                    (Model model.number
                        (FixedPointResult
                            model.currentNum
                            (fixedPointSingleIteration function model.currentNum)
                            (closeEnough model.currentNum (fixedPointSingleIteration function model.currentNum))
                            :: model.tests
                        )
                        (fixedPointSingleIteration function model.currentNum)
                        (model.iterCount + 1)
                    )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text (toString model.number) ]
        , input [ type_ "number", placeholder "Number", onInput ChangeNumFromInput ] []
        , button [ onClick ExecuteFixedPoint ] [ text "Calculate" ]
        , h3 [] [ text (toString model.iterCount) ]
        , ul [] (renderFixedPointResults model.tests)
        ]


renderFixedPointResult testResult =
    let
        children =
            if testResult.isCloseEnough then
                text
                    (toString testResult.testNum
                        ++ " has been tested and the answer, "
                        ++ toString testResult.answer
                        ++ ", is close enough!"
                    )
            else
                text
                    (toString testResult.testNum
                        ++ " has been tested and the answer, "
                        ++ toString testResult.answer
                        ++ ", is not close enough."
                    )
    in
    li [] [ children ]


renderFixedPointResults testResults =
    List.map renderFixedPointResult testResults



-- some other important stuff


toFloat string =
    -- String.toInt has a type of String -> Result String Int so it will return some result thing. I just want the data, so I used Result.withDefault 0 so if there's an error then the output will be 0
    Result.withDefault 0 (String.toFloat string)



-- ACTUAL MATH LMAO


average a b =
    (a + b) / 2


function x =
    nLog 1000 / nLog x


nLog x =
    logBase e x


closeEnough v1 v2 =
    let
        tolerance =
            0.0001
    in
    abs (v1 - v2) < tolerance


ifDampening f guess hasDampening =
    if hasDampening then
        average (f guess) guess
    else
        f guess


fixedPointSingleIteration f guess =
    ifDampening f guess True
