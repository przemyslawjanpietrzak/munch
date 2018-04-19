module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)


main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }



-- MODEL


type alias Message =
    { content : String, isBot : Bool }


type alias Messages =
    List Message


type alias Model =
    { messages : Messages, inputField : String }


model : Model
model =
    { messages = [], inputField = "" }



-- UPDATE


type Msg
    = Content String
    | Send


update : Msg -> Model -> Model
update msg model =
    case msg of
        Content content ->
            { model | inputField = content }

        Send ->
            { inputField = ""
            , messages = { content = model.inputField, isBot = False } :: model.messages
            }



-- VIEW


showMessage : Message -> Html Msg
showMessage message =
    div
        [ classList
            [ ( "bot", message.isBot )
            , ( "user", not message.isBot )
            ]
        ]
        [ text message.content ]


showMessages : Messages -> Html Msg
showMessages messages =
    ul []
        (List.map showMessage messages)


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", placeholder "Name", value model.inputField, onInput Content ] []
        , showMessages (model.messages)
        , button [ onClick Send ] [ text "send" ]
        ]
