module MyCss exposing (titleStyle)

import Css exposing (..)


titleStyle : List Style
titleStyle =
    [ display inlineBlock
    , padding (px 20)
    , border3 (px 5) solid (rgb 120 120 120)
    , hover
        [
            borderRadius (px 10)
        ]
    ]
    
