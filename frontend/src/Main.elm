module Main exposing (..)

import Html
import Html.Styled.Events exposing (onInput, onClick, onSubmit)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (href, css, id, class, value, action)
import Css exposing (..)
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
        (div [ class "demo-card-event mdl-card mdl-shadow--2dp", css [ width (pct 50) ] ]
            [ div
                [ class "munch__messages mdl-card__title mdl-card--expand"
                , css
                    [ borderBottom3 (px 1) solid (rgb 222 222 222)
                    , overflowY scroll
                    , alignItems flexStart
                    , height (calc (vh 100) minus (px 250))
                    ]
                ]
                [ showMessages model.messages ]
            , form
                [ class "mdl-card__actions mdl-card--border"
                , id "form"
                , css
                    [ padding2 (px 10) (px 20)
                    , borderColor (rgb 255 255 255)
                    , displayFlex
                    , alignItems center
                    ]
                , action "#"
                , onSubmit Send
                ]
                [ div [ class "mdl-textfield mdl-js-textfield", css [ width (pct 90) ] ]
                    [ input
                        [ class "mdl-textfield__input"
                        , id "input"
                        , css [ color (rgb 0 0 0) ]
                        , value model.inputField
                        , onInput Content
                        ]
                        []
                    , label [ class "mdl-textfield__label" ] [ text "Text ..." ]
                    ]
                , div [ class "mdl-layout-spacer" ] []
                , button
                    [ class "material-icons"
                    , css
                        [ paddingRight (px 10)
                        , border (px 0)
                        , backgroundColor (rgb 255 255 255)
                        ]
                    , id "send"
                    ]
                    [ text "send" ]
                ]
            ]
        )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
