module Boilerplate exposing (boilerplate)

import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (href, id, class, css, media, value, action, attribute, target, classList)
import Css exposing (..)
import Css.Media as Media exposing (..)


boilerplate : Html msg -> Html msg
boilerplate child =
         div [ class "demo-layout-transparent mdl-layout mdl-js-layout" ] [ 
            header [ class "mdl-layout__header mdl-layout__header--transparent" ] [
                div [ class "mdl-layout__header-row" ] [
                    span [ class "mdl-layout-title" ] [ text "Munch - painting chatbot" ]
                    , div [ class "mdl-layout-spacer" ] []
                    , nav [ class "mdl-navigation" ] [
                        a [class "mdl-navigation__link", href "" ] [ text "Author"]
                        , a [class "mdl-navigation__link", href "" ] [ text "Source code" ]
                        , a [class "mdl-navigation__link", href "" ] [ text "Issuess" ]
                    ]
                ]
            ]
            , div [ class "munch mdl-layout__content" ] [ child ]
            
         ]
    
