module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Http
import Json.Decode as Decode
import Stylesheet exposing (toStyleNode)
import Styles exposing (myStylesheet, selectors)


main =
    Html.program
        { view = view
        , update = update
        , init = init
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    ( { messages = [], inputField = "show me Allegory" }
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



-- Http


getUrl : String -> Cmd Msg
getUrl title =
    let
        url =
            "/painting/" ++ title
    in
        Http.send Response (Http.get url decodeUrl)


decodeUrl : Decode.Decoder String
decodeUrl =
    Decode.at [ "url" ] Decode.string



-- VIEW


showMessage : Message -> Html Msg
showMessage message =
    div
        [ classList
            [ ( "them", message.isBot )
            , ( "me", not message.isBot )
            , ( "message-wrapper", True )
            ]
        , attribute "data-testid" "message"
        , attribute "data-test-type"
            (if message.isBot then
                "bot"
             else
                "user"
            )
        ]
        [ div [ class "circle-wrapper animated bounceIn" ] []
        , div [ class "text-wrapper animated fadeIn" ]
            [ a
                [ classList
                    [ ( "link", message.isBot )
                    ]
                , href message.content
                , target "_blank"
                , attribute "data-testid" "message-content"
                ]
                [ text message.content ]
            ]
        ]


showMessages : Messages -> Html Msg
showMessages messages =
    div [ class "content", id "content" ]
        (List.map showMessage messages)


view : Model -> Html Msg
view model =
    body []
        [ myStylesheet |> toStyleNode
        , h1 [ class selectors.title ] [ text "Painting chatbot" ]
        , div [ class "wrapper" ]
            [ div [ class "nav", id "nav" ]
                [ div [ class "default-nav" ]
                    [ div [ class "main-nav" ]
                        [ div [ class "toggle" ] []
                        , div [ class "main-nav-item" ]
                            [ a [ class "main-nav-item-link", href "#" ] [ text "Munch" ]
                            ]
                        , div [ class "options" ] []
                        ]
                    ]
                ]
            , div [ class "inner", id "inner" ]
                [ showMessages model.messages
                ]
            , div [ class "bottom", id "bottom" ]
                [ Html.form [ id "form", action "#", Html.Events.onSubmit Send ]
                    [ input [ class "input", id "input", value model.inputField, onInput Content ] []
                    , button [ class "send", id "send" ] [ text "send" ]
                    ]
                ]
            ]
        ]



-- subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
