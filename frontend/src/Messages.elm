module Messages exposing (showMessages)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import StyleSettings exposing (..)
import Types exposing (..)
import StyleSettings exposing (..)


contentStyle : List Style
contentStyle =
    [ padding (px 10)
    , position relative
    , marginBottom (px (navHeight / 2))
    ]


messageStyles : List Style
messageStyles =
    [ position relative
    , overflow Css.hidden
    , Css.width (pct 100)
    , padding (px paddingValue)
    , margin (px paddingValue)
    ]


botStyle : List Style
botStyle =
    [ backgroundColor mainColor
    , float left
    , color (rgb 255 255 255)
    ]


userStyle : List Style
userStyle =
    [ backgroundColor white
    , float right
    , color (rgb 0 0 0)
    ]


circleStyle : Bool -> List Style
circleStyle isBot =
    [ Css.height (px (navHeight / 1.5))
    , Css.width (px (navHeight / 1.5))
    , borderRadius (pct 50)
    ]
        ++ (if isBot then
                botStyle
            else
                userStyle
           )


textStyle : Bool -> List Style
textStyle isBot =
    [ padding (px 10)
    , minHeight (px (navHeight / 1.5))
    , Css.width (pct 60)
    , margin2 (px 0) (px paddingValue)
    , boxShadow5 (px 0) (px 1) (px 0) (px 0) (rgb 33 150 15)
    , borderRadius (px 2)
    , fontWeight normal
    , position relative
    ]
        ++ (if isBot then
                botStyle
            else
                userStyle
           )


showMessage : Message -> Html Msg
showMessage message =
    div
        [ css messageStyles
        , attribute "data-testid" "message"
        , attribute "data-test-type"
            (if message.isBot then
                "bot"
             else
                "user"
            )
        ]
        [ div [ css (circleStyle message.isBot) ] []
        , div [ css (textStyle message.isBot) ]
            [ a
                [ css ( if message.isBot then [ color white] else [] )
                , href message.content
                , Html.Styled.Attributes.target "_blank"
                , attribute "data-testid" "message-content"
                ]
                [ text message.content ]
            ]
        ]


showMessages : Messages -> Html Msg
showMessages messages =
    div [ css contentStyle, id "content" ]
        (List.map showMessage messages)
