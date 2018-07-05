-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/effects/random.html


module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random
import Debug exposing (..)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { number : Int
    , tests : List FermatResult
    }


type alias FermatResult =
    { testNum : Int
    , isCongruentMod : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( Model 23 [], Cmd.none )



-- UPDATE


type Msg
    = ChangeNumFromInput String
    | GenerateRandNum
    | CreateFermatResult Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeNumFromInput inputString ->
            -- this directly takes in the input from the field and changes the model. It also deletes all previous fermat tests
            ( Model (toInt inputString) [], Cmd.none )

        GenerateRandNum ->
            -- this generates a random number between 1 and the inputted number
            ( model, Random.generate CreateFermatResult (Random.int 1 (model.number - 1)) )

        CreateFermatResult randNum ->
            -- the bug juicy stuff
            ( { model | tests = FermatResult randNum (fermatTest model.number randNum) :: model.tests }, Cmd.none )



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
        , button [ onClick GenerateRandNum ] [ text "Roll" ]
        , ul [] (renderFermatResults model.tests)
        ]


renderFermatResult testResult =
    let
        children =
            if testResult.isCongruentMod then
                text
                    (toString testResult.testNum
                        ++ " has been tested and the result matches - it may be a prime number!"
                    )
            else
                text
                    (toString testResult.testNum
                        ++ " has been tested and the results say the number is not prime"
                    )
    in
    li [] [ children ]


renderFermatResults testResults =
    List.map renderFermatResult testResults



-- OTHER STUFF LMAO


toInt string =
    -- String.toInt has a type of String -> Result String Int so it will return some result thing. I just want the data, so I used Result.withDefault 0 so if there's an error then the output will be 0
    Result.withDefault 0 (String.toInt string)



-- THE ACTUAL FERMAT STUFF


square x =
    x * x


gcd a b =
    if b == 0 then
        a
    else
        gcd b (rem a b)


isEven x =
    rem x 2 == 0


fastExpIter b n a =
    if n == 0 then
        a
    else if isEven n then
        fastExpIter (square b) (n / 2) a
    else
        fastExpIter b (n - 1) (a * b)
 
--so you can see the calculatinos and whn the javascript compiler messes up (doesn't work when it's not on ellie)
fastExpWithLogs b n a =
    if n == 0 then
        a
    else if isEven n then
        log ((toString n) ++ " is even and b is is " ++ (toString (square b)) ++ " while a is " ++ (toString a)) fastExpWithLogs (square b) (n / 2) a
    else
        log ((toString n) ++ " is odd and b is " ++ (toString b) ++ " while a, " ++ (toString a) ++ ", is going to be multiplied b, " ++ (toString b) ++ ", to create " ++ (toString (a * b))) fastExpWithLogs b (n - 1) (a * b)



exponent b n =
    fastExpIter b n 1


expMod base exp modulus =
    if exp == 0 then
        1
    else 
        log ("The remainder for " ++ (toString base) ++ "^" ++ (toString exp) ++ " mod " ++(toString modulus) ++ " is ")
        (rem (exponent base exp) modulus)


fermatTest n randNum =
    let
        -- use one instance of the fermat test
        -- is this is true the number may be a prime
        tryIt a =
            expMod a n n == a
    in
        tryIt randNum