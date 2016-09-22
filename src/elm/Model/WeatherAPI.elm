module Model.WeatherAPI exposing (..)

import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (decode, required, optional)


type alias WeatherResponse =
    { query : WeatherMetaObject }


weatherResponseDecoder : Decoder WeatherResponse
weatherResponseDecoder =
    decode WeatherResponse
        |> required "query" weatherMetaObjectDecoder


type alias WeatherMetaObject =
    { count : Int
    , created : String
    , lang : String
    , results : WeatherResult
    }


weatherMetaObjectDecoder : Decoder WeatherMetaObject
weatherMetaObjectDecoder =
    decode WeatherMetaObject
        |> required "count" int
        |> required "created" string
        |> required "lang" string
        |> required "results" weatherResultDecoder


type alias WeatherResult =
    { channel : WeatherData }


weatherResultDecoder : Decoder WeatherResult
weatherResultDecoder =
    decode WeatherResult
        |> required "channel" weatherDataDecoder


type alias WeatherData =
    { item : WeatherItem }


weatherDataDecoder : Decoder WeatherData
weatherDataDecoder =
    decode WeatherData
        |> required "item" weatherItemDecoder


type alias WeatherItem =
    { condition : Condition
    , forecast : List Forecast
    }


weatherItemDecoder : Decoder WeatherItem
weatherItemDecoder =
    decode WeatherItem
        |> required "condition" conditionDecoder
        |> required "forecast" (list foreacastDecoder)



-- |> required "forecast" list foreacastDecoder


type alias Condition =
    { temp : String
    , text : String
    }


conditionDecoder : Decoder Condition
conditionDecoder =
    decode Condition
        |> required "temp" string
        |> required "text" string


type alias Forecast =
    { code : String
    , date : String
    , day : String
    , high : String
    , low : String
    , text : String
    }


foreacastDecoder : Decoder Forecast
foreacastDecoder =
    decode Forecast
        |> required "code" string
        |> required "date" string
        |> required "day" string
        |> required "high" string
        |> required "low" string
        |> required "text" string
