module Messages exposing (showMessages)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Types exposing (..)


navHeight : Float
navHeight =
    64


paddingValue : Float
paddingValue =
    (navHeight - (navHeight / 1.5) / 2)


contentStyle : List Style
contentStyle =
    [ padding (px paddingValue)
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


circleStyle : List Style
circleStyle =
    [ Css.height (px (navHeight / 1.5))
    , Css.width (px (navHeight / 1.5))
    , borderRadius (pct 50)
    ]


textStyle : List Style
textStyle =
    [ padding (px paddingValue)
    , minHeight (px (navHeight / 1.5))
    , Css.width (pct 60)
    , margin2 (px 0) (px paddingValue)
    , boxShadow5 (px 0) (px 1) (px 0) (px 0) (rgb 33 150 15)
    , borderRadius (px 2)
    , fontWeight normal
    , position relative
    ]


showMessage : Message -> Html Msg
showMessage message =
    div
        [ classList
            [ ( "them", message.isBot )
            , ( "me", not message.isBot )
            ]
        , css messageStyles
        , attribute "data-testid" "message"
        , attribute "data-test-type"
            (if message.isBot then
                "bot"
             else
                "user"
            )
        ]
        [ div [ css circleStyle, class "animated bounceIn" ] []
        , div [ css textStyle, class "animated fadeIn" ]
            [ a
                [ classList
                    [ ( "link", message.isBot )
                    ]
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
