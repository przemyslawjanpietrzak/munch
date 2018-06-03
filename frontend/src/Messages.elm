module Messages exposing (showMessages)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import StyleSettings exposing (..)
import Types exposing (..)
import StyleSettings exposing (..)


showMessage : Message -> Html Msg
showMessage message =
    div
        [ attribute "data-testid" "message"
        , attribute "data-test-type"
            (if message.isBot then
                "bot"
             else
                "user"
            )
        ]
        [ div [  ] []
        , div [  ]
            [ a
                [ 
                  href message.content
                , Html.Styled.Attributes.target "_blank"
                , attribute "data-testid" "message-content"
                ]
                [ text message.content ]
            ]
        ]


showMessages : Messages -> Html Msg
showMessages messages =
    div [ id "content" ]
        (List.map showMessage messages)
