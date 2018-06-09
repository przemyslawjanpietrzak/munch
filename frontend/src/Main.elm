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
        (
             div [ class "munch__container demo-card-event mdl-card mdl-shadow--2dp" ] [
                div [ class "munch__messages mdl-card__title mdl-card--expand" ] [ showMessages model.messages ]
                , form [ class "munch__form mdl-card__actions mdl-card--border", id "form", action "#", onSubmit Send ] [
                    div [ class "munch__input mdl-textfield mdl-js-textfield" ] [
                         input [ class "mdl-textfield__input", id "input", value model.inputField, onInput Content ] []
                            , label [ class "mdl-textfield__label" ] [ text "Text ..."]
                        ]
                    , div [ class "mdl-layout-spacer" ] []
                    , div [ class "material-icons" ] [ text "send"]
                    ]
                ]
                    
        )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
