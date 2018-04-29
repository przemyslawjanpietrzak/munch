module Main exposing (..)

import Html exposing (..)


-- import Html.Attributes exposing (href, id, class, value, action, attribute, target, classList)

import Html.Styled.Events exposing (onInput, onClick)
import Http
import Json.Decode as Decode
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (href, id, class, value, action, attribute, target, classList)
import MyCss exposing (titleStyle, titleComponent)
import Boilerplate exposing (boilerplate)


main =
    Html.program
        { view = view >> toUnstyled
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


showMessage : Message -> Html.Styled.Html Msg
showMessage message =
    Html.Styled.div
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
        [ Html.Styled.div [ class "circle-wrapper animated bounceIn" ] []
        , Html.Styled.div [ class "text-wrapper animated fadeIn" ]
            [ Html.Styled.a
                [ classList
                    [ ( "link", message.isBot )
                    ]
                , href message.content
                , target "_blank"
                , attribute "data-testid" "message-content"
                ]
                [ Html.Styled.text message.content ]
            ]
        ]


showMessages : Messages -> Html.Styled.Html Msg
showMessages messages =
    Html.Styled.div [ class "content", id "content" ]
        (List.map showMessage messages)


view : Model -> Html.Styled.Html Msg
view model =
    Html.Styled.body []
        [ boilerplate
            (Html.Styled.div []
                [ Html.Styled.div [ class "inner", id "inner" ]
                    [ showMessages model.messages
                    ]
                , Html.Styled.div [ class "bottom", id "bottom" ]
                    [ Html.Styled.form [ id "form", action "#", Html.Styled.Events.onSubmit Send ]
                        [ Html.Styled.input [ class "input", id "input", value model.inputField, onInput Content ] []
                        , Html.Styled.button [ class "send", id "send" ] [ Html.Styled.text "send" ]
                        ]
                    ]
                ]
            )
        ]



-- subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
