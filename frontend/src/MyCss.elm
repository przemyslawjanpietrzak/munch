module MyCss exposing (titleStyle, titleComponent)

import Css exposing (..)


-- import Html

import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)


titleStyle : List Style
titleStyle =
    [ display inlineBlock
    , padding (px 20)
    , border3 (px 5) solid (rgb 120 120 120)
    , hover
        [ borderRadius (px 10)
        ]
    ]


titleComponent : Html msg
titleComponent =
    div [ css titleStyle ] [ text "title" ]
