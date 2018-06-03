module Boilerplate exposing (boilerplate, innerStyle, bottomStyle, inputStyle, sendStyle)

import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (href, id, class, css, media, value, action, attribute, target, classList)
import Css exposing (..)
import Css.Media as Media exposing (..)
import StyleSettings exposing (..)


boilerplate : Html msg -> Html msg
boilerplate child =
    body []
        [ div [ class "demo-layout-transparent mdl-layout mdl-js-layout" ] [ 
            header [ class "mdl-layout__header mdl-layout__header--transparent" ] [
                div [ lass "mdl-layout__header-row" ] [
                    span [ class "mdl-layout-title" ] [ text "Munch - painting chatbot" ]
                    div [ class "mdl-layout-spacer" ] []
                    nav [ class "mdl-navigation" ] [
                        a [class "navigation__link", href "" ] [ text ""]
                        , a [class "navigation__link", href "" ] [ text ""]
                        , a [class "navigation__link", href "" ] [ text ""]
                    ]
                ]
            ]
            , main [ class "mdl-layout__content" ] [
                div [ class "munch__container demo-card-event mdl-card mdl-shadow--2dp" ] [
                    div [ class "munch__messages mdl-card__title mdl-card--expand" ] [
                        child
                    ]
                ]
            ]
            
         ]
    ]
