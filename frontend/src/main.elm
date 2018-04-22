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
    ( { messages = [], inputField = "show me allegory" }
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
            , getUrl model.inputField
            )

        Response (Ok response) ->
            ( model, Cmd.none )

        Response (Err _) ->
            ( { model
                | messages = { content = "not found", isBot = True } :: model.messages
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
            , ("message-wrapper", True)
            ]
        ]
        [
            div [ class "circle-wrapper animated bounceIn" ] [ ]
            , div [ class "text-wrapper animated fadeIn" ] [
                a [
                    classList [
                        ("link" , message.isBot)
                    ]
                    , href message.content
                    , target "_blank"
                    ]
                    [ text message.content ]
            ]
            
        ]

showMessages : Messages -> Html Msg
showMessages messages =
    div [  class "content" , id "content" ]
        (List.map showMessage messages)

view : Model -> Html Msg
view model =
    body []
        [ myStylesheet |> toStyleNode
        , h1 [ class selectors.title ] [ text "Painting chatbot" ]
        , div [ class "wrapper" ] [
            div [class "nav",  id "nav" ] [
                div [ class "default-nav" ] [
                    div [ class "main-nav" ] [
                        div [ class "toggle" ] []
                        , div [ class "main-nav-item" ] [
                            a [ class "main-nav-item-link", href "#"] [ text "Munch"]
                        ],
                        div [ class "options" ] []
                    ]
                ]
            ]
            , div [ class "inner" , id "inner"] [
                
                showMessages model.messages
                
            ]
            , div [ class "bottom", id "bottom" ] [
                Html.form [ id "form" , action "#" , Html.Events.onSubmit Send] [
                    input [ class "input", id "input", value model.inputField, onInput Content] []
                    , button [ class "send", id "send" ] [ text "send" ]

                ]
            ]
        ]
        ]


-- subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
