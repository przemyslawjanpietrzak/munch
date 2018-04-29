module Main exposing (..)

import Html exposing (..)


-- import Html.Attributes exposing (href, id, class, value, action, attribute, target, classList)

import Html.Styled.Events exposing (onInput, onClick)


-- import Http
-- import Json.Decode as Decode

import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (href, id, class, value, action, attribute, target, classList)
import Types exposing (..)


-- import MyCss exposing (titleStyle, titleComponent)

import Boilerplate exposing (boilerplate)
import Store exposing (..)
import Messages exposing (showMessages)


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
