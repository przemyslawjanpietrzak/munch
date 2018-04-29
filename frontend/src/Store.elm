module Store exposing (update)

import Api exposing (getUrl)
import Types exposing (..)


addToMessages : Messages -> String -> Bool -> Messages
addToMessages messages content isBot =
    messages ++ [ { content = content, isBot = isBot } ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Content content ->
            ( { model | inputField = content }, Cmd.none )

        Send ->
            ( { inputField = ""
              , messages = addToMessages model.messages model.inputField False
              }
            , getUrl model.inputField
            )

        Response (Ok response) ->
            ( { model | messages = addToMessages model.messages response True }
            , Cmd.none
            )

        Response (Err _) ->
            ( { model
                | messages = addToMessages model.messages "Not found" True
              }
            , Cmd.none
            )
