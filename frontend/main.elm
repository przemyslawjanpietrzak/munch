module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Http
import Json.Decode as Decode


main =
    Html.program
        {
        view = view
        , update = update
        ,init = init
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init  =
    (
        { messages = [], inputField = "show me allegory" }
        , Cmd.none
    )



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
    | Response (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Content content ->
            ( { model | inputField = content }, Cmd.none )

        Send ->
            ( { inputField = ""
              , messages = { content = model.inputField, isBot = False } :: model.messages
              }
            , getRandomGif model.inputField
            )

        Response (Ok newUrl) ->
            ( model, Cmd.none )

        Response (Err _) ->
            ( model, Cmd.none )



-- Http


getRandomGif : String -> Cmd Msg
getRandomGif topic =
    let
        url =
            "http://munch.today/inex.html" ++ topic
    in
        Http.send Response (Http.get url decodeGifUrl)


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_url" ] Decode.string



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



-- subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
