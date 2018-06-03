module Messages exposing (showMessages)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
-- import StyleSettings exposing (..)
import Types exposing (..)
-- import StyleSettings exposing (..)


showMessage : Message -> Html Msg
showMessage message =
    li
        [ class "munch__message mdl-list__item"
        , attribute "data-testid" "message"
        , attribute "data-test-type"
            (if message.isBot then
                "bot"
             else
                "user"
            )
        ]   [
          span [ class "mdl-chip mdl-chip--contact" ] [ text "A" ]
          , span [ class "mdl-chip__text", attribute "data-testid" "message-content" ] [ text message.content ]  
        ]


showMessages : Messages -> Html Msg
showMessages messages =
    ul [ class "demo-list-item mdl-list", id "content" ]
        (List.map showMessage messages)
