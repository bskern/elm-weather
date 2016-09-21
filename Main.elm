module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Http
import Task
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (decode, required, optional)


type alias Weather =
    { currentTemp : String
    , desc : String
    , high : String
    , low : String
    }


weatherDecoder : Decoder Weather
weatherDecoder =
    decode Weather
        |> Json.Decode.Pipeline.required "currentTemp" string
        |> Json.Decode.Pipeline.required "desc" string
        |> Json.Decode.Pipeline.required "high" string
        |> Json.Decode.Pipeline.required "low" string


getWeather : Cmd Msg
getWeather =
    let
        url =
            "http://localhost:9000/weather"

        task =
            Http.get weatherDecoder url

        cmd =
            Task.perform Fail Forecast task
    in
        cmd


type alias Model =
    Weather


initModel : Model
initModel =
    { currentTemp = "na"
    , desc = "fetching"
    , high = "99"
    , low = "99"
    }


init : ( Model, Cmd Msg )
init =
    ( initModel, getWeather )



--update


type Msg
    = Forecast Weather
    | Fail Http.Error


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Forecast weather ->
            ( weather, Cmd.none )

        Fail error ->
            ( initModel, Cmd.none )


view : Model -> Html Msg
view model =
    div [ class "navbar navbar-inverse" ]
        [ div [ class "container-fluid" ]
            [ div [ class "navbar-header" ]
                [ span [ class "navbar-brand" ] [ text ("Minneapolis " ++ model.currentTemp ++ " " ++ model.desc) ]
                ]
            , ul [ class "nav navbar-nav navbar-right" ]
                [ li [] [ a [] [ text ("High: " ++ model.high) ] ]
                , li [] [ a [] [ text ("Low: " ++ model.low) ] ]
                ]
            ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never
main =
    App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
