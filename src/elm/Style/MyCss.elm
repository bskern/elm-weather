module Style.MyCss exposing (..)

import Css exposing (..)
import Css.Elements exposing (body)
import Css.Namespace exposing (namespace)


type CssClasses
    = App


css =
    (stylesheet << namespace "myweather")
        [ body
            [ margin zero
            , padding zero
            , fontSize (px 14)
            , fontFamilies [ "Helvetica Neue", "Helvetica", "Arial", "sans-serif" ]
            ]
        , (.) App
            [ textAlign center ]
        ]
