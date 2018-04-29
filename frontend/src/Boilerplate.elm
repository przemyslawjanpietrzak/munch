module Boilerplate exposing (boilerplate, innerStyle, bottomStyle, inputStyle, sendStyle)

import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (href, id, class, css, value, action, attribute, target, classList)
import Css exposing (..)


navHeight : Float
navHeight =
    64


paddingValue : Float
paddingValue =
    (navHeight - (navHeight / 1.5) / 2)



-- navZindex : IntOrAuto
-- navZindex =
--     { value =  "100", intOrAuto = ""}


sendStyle : List Style
sendStyle =
    [ position fixed
    , height (px (navHeight / 1.5))
    , width (px (navHeight / 1.5))
    , borderRadius (pct -50)
    , border (px 0)
    , backgroundColor (rgb 33 150 15)
    , bottom (px paddingValue)
    , right (px paddingValue)
    ]


bottomStyle : List Style
bottomStyle =
    [ position fixed
    , bottom (px 0)
    , Css.left (px 0)
    , Css.right (px 0)
    , Css.bottom (px 0)
    , height (px navHeight)
    , backgroundColor (rgb 255 255 255)
    ]


inputStyle : List Style
inputStyle =
    [ Css.height (px navHeight)
    , backgroundColor (rgb 255 255 255)
    , border (px 0)
    , position absolute
    , left (px 0)
    , top (px 0)
    , padding2 (px 0) (pct 5)
    , resize none
    , fontWeight normal
    , width (pct 100)

    -- : focus:
    ]


titleStyle : List Style
titleStyle =
    [ color (rgb 255 255 255)
    , fontWeight normal
    , fontSize (px 24)
    , textAlign center
    ]


wrapperStyle : List Style
wrapperStyle =
    [ minHeight (px 720)
    , maxWidth (px 1080)
    , minWidth (px 1080)
    , overflow hidden
    , backgroundColor (rgb 255 255 255)
    , position fixed
    , top (px 100)
    , left (pct 50)
    , transform (translateX (pct -50))
    , boxShadow5 (px 0) (px 3) (px 3) (px 0) (rgb 50 50 50)
    ]


innerStyle : List Style
innerStyle =
    [ overflow scroll
    , height (px 720)
    , paddingTop (px navHeight)
    , backgroundColor (rgb 255 255 255)
    ]


nav : List Style
nav =
    [ position fixed
    , top (px 0)
    , left (px 0)
    , right (px 0)
    , height (px navHeight)

    -- , zIndex (int 5), "5"
    ]


defaultNav : List Style
defaultNav =
    [ height (px navHeight)
    , width (pct 100)
    , position absolute
    , left (px 0)
    , top (px 0)

    -- , zIndex 110
    ]


mainNav : List Style
mainNav =
    [ position absolute
    , left (px 0)
    , width (pct 100)
    , height (px navHeight)
    , top (px 0)
    , margin (px 0)
    , padding (px 0)
    , listStyle none
    ]


toggleStyle : List Style
toggleStyle =
    [ height (px 32)
    , width (px 32)
    , backgroundImage (url "https://s3-us-west-2.amazonaws.com/s.cdpn.io/104946/ic_arrow_back_white_48dp.png")
    , backgroundSize contain
    , margin (px 16)
    , float left
    , cursor pointer
    ]


mainNavItem : List Style
mainNavItem =
    [ float left
    , height (px navHeight)
    , marginRight (px 50)
    , position relative
    , lineHeight (px navHeight)
    ]


linkStyle : List Style
linkStyle =
    [ display block
    , position relative
    , height (px navHeight)
    , width (pct 100)
    , textAlign center
    , lineHeight (px navHeight)
    ]


optionsStyle : List Style
optionsStyle =
    [ height (px 32)
    , width (px 32)
    , backgroundImage (url "https://s3-us-west-2.amazonaws.com/s.cdpn.io/104946/ic_more_vert_white_48dp.png")
    , backgroundSize (px 16)
    , position absolute
    , right (px 0)
    , cursor pointer
    ]


boilerplate : Html msg -> Html msg
boilerplate child =
    body []
        [ div [ css titleStyle ] [ text "title" ]
        , h1 [ css titleStyle ] [ text "Painting chatbot" ]
        , div [ css wrapperStyle ]
            [ div [ css nav, id "nav" ]
                [ div [ css defaultNav ]
                    [ div [ css mainNav ]
                        [ div [ css toggleStyle ] []
                        , div [ css mainNavItem ]
                            [ a [ css linkStyle, href "#" ] [ text "Munch" ]
                            ]
                        , div [ css optionsStyle ] []
                        ]
                    ]
                ]
            , div []
                [ child
                ]
            ]
        ]
