module Main exposing (..)

import Html
import Html.Styled.Events exposing (onInput, onClick, onSubmit)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (href, css, id, class, value, action)
import Types exposing (..)
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


view : Model -> Html Msg
view model =
    boilerplate
        (div []
            [ div [ ]
                [ showMessages model.messages
                ]
            , div [ ]
                [ form [ id "form", action "#", onSubmit Send ]
                    [ input [  id "input", value model.inputField, onInput Content ] []
                    , button [ id "send" ] []
                    ]
                ]
            ]
        )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
