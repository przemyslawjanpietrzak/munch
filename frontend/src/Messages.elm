module Messages exposing (showMessages)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Types exposing (..)


messageType : Bool -> String
messageType isBot =
    if isBot then
        "bot"
    else
        "user"


messageJustifyContent isBot =
    if isBot then
        flexStart
    else
        flexEnd


showMessage : Message -> Html Msg
showMessage message =
    li
        [ class "mdl-list__item"
        , css
            [ padding (px 8)
            , Css.width (pct 100)
            , displayFlex
            , justifyContent (messageJustifyContent message.isBot)
            ]
        , attribute "data-testid" "message"
        , attribute "data-test-type" (messageType message.isBot)
        ]
        [ span
            [ class "mdl-chip mdl-chip--contact"
            , css [ backgroundColor (rgb 250 250 250), justifyContent flexEnd ]
            ]
            [ span
                [ class "mdl-chip__contact mdl-color--teal mdl-color-text--white" ]
                [ text "A" ]
            , span
                [ class "mdl-chip__text"
                , css [ fontSize (px 15) ]
                , attribute "data-testid" "message-content"
                ]
                [ text message.content ]
            ]
        ]


showMessages : Messages -> Html Msg
showMessages messages =
    ul
        [ class "demo-list-item mdl-list"
        , id "content"
        , css [ Css.width (pct 100) ]
        ]
        (List.map showMessage messages)
