module Boilerplate exposing (boilerplate, innerStyle, bottomStyle, inputStyle, sendStyle)

import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (href, id, class, css, media, value, action, attribute, target, classList)
import Css exposing (..)
import Css.Media as Media exposing (..)
import StyleSettings exposing (..)


-- navZindex : IntOrAuto
-- navZindex =
--     { value =  "100", intOrAuto = ""}


sendStyle : List Style
sendStyle =
    [ position fixed
    , Css.height (px (navHeight / 1.5))
    , Css.width (px (navHeight / 1.5))
    , borderRadius (pct 50)
    , backgroundColor (rgb 33 150 243)
    , bottom (px paddingValue)
    , right (px paddingValue)
    , backgroundImage (url "https://s3-us-west-2.amazonaws.com/s.cdpn.io/104946/ic_send_white_48dp.png")
    , backgroundSize (px (navHeight / 2))
    , backgroundRepeat noRepeat
    , backgroundSize (px 23)
    , backgroundPosition center
    ]


bottomStyle : List Style
bottomStyle =
    [ position fixed
    , bottom (px 0)
    , Css.left (px 0)
    , Css.right (px 0)
    , Css.bottom (px 0)
    , Css.height (px navHeight)
    , backgroundColor white
    ]


inputStyle : List Style
inputStyle =
    [ Css.height (px navHeight)
    , backgroundColor white

    -- , border (px 0)
    , position absolute
    , left (px 0)
    , top (px 0)
    , padding2 (px 0) (pct 5)
    , resize none
    , fontWeight normal
    , Css.width (pct 100)

    -- : focus:
    ]


titleStyle : List Style
titleStyle =
    [ Css.color white
    , fontWeight normal
    , fontSize (px 24)
    , textAlign center
    ]


wrapperStyle : List Style
wrapperStyle =
    [ Css.minHeight (px 720)
    , Css.maxWidth (px 1080)
    , Css.minWidth (px 1080)
    , overflow hidden
    , backgroundColor white
    , position fixed
    , top (px 75)
    , left (pct 50)
    , transform (translateX (pct -50))
    , boxShadow5 (px 0) (px 3) (px 3) (px 0) shadowColor
    , withMedia
        [ only screen
            [ Media.maxWidth (px 1000) ]
        ]
        [ Css.maxWidth (px 800) ]
    , withMedia
        [ only screen
            [ Media.maxWidth (px 700) ]
        ]
        [ Css.maxWidth (px 600) ]
    ]


innerStyle : List Style
innerStyle =
    [ overflow scroll
    , Css.height (px 720)
    , paddingTop (px navHeight)
    , backgroundColor (rgb 242 242 242)
    ]


nav : List Style
nav =
    [ position fixed
    , top (px 0)
    , left (px 0)
    , right (px 0)
    , Css.height (px navHeight)
    , zIndex (int 3)
    ]


defaultNav : List Style
defaultNav =
    [ Css.height (px navHeight)
    , Css.width (pct 100)
    , position absolute
    , left (px 0)
    , top (px 0)
    , backgroundColor mainColor
    , Css.color white

    -- , border2 (px 0) (px 3) (px 3)
    , borderColor borderColorValue

    -- , zIndex 110
    ]


mainNav : List Style
mainNav =
    [ position absolute
    , left (px 0)
    , Css.width (pct 100)
    , Css.height (px navHeight)
    , top (px 0)
    , margin (px 0)
    , padding (px 0)
    , listStyle none
    ]


toggleStyle : List Style
toggleStyle =
    [ Css.height (px 32)
    , Css.width (px 32)
    , backgroundImage (url "https://s3-us-west-2.amazonaws.com/s.cdpn.io/104946/ic_arrow_back_white_48dp.png")
    , backgroundSize contain
    , margin (px 16)
    , float left
    , cursor Css.pointer
    ]


mainNavItem : List Style
mainNavItem =
    [ float left
    , Css.height (px navHeight)
    , marginRight (px 50)
    , position relative
    , lineHeight (px navHeight)
    ]


linkStyle : List Style
linkStyle =
    [ display block
    , position relative
    , Css.height (px navHeight)
    , Css.width (pct 100)
    , textAlign center
    , lineHeight (px navHeight)
    , Css.color white
    , textDecoration none
    ]


-- optionsStyle : List Style
-- optionsStyle =
--     [ Css.height (px 32)
--     , Css.width (px 32)
--     , backgroundImage (url "https://s3-us-west-2.amazonaws.com/s.cdpn.io/104946/ic_more_vert_white_48dp.png")
--     , backgroundSize (px 16)
--     , position absolute
--     , right (px 0)
--     , cursor Css.pointer
--     ]


boilerplate : Html msg -> Html msg
boilerplate child =
    body []
        [ h1 [ css titleStyle ] [ text "Painting chatbot" ]
        , div [ css wrapperStyle ]
            [ div [ css nav, id "nav" ]
                [ div [ css defaultNav ]
                    [ div [ css mainNav ]
                        [ div [ css toggleStyle ] []
                        , div [ css mainNavItem ]
                            [ a [ css linkStyle, href "#" ] [ text "Munch" ]
                            ]
                        ]
                    ]
                ]
            , div [] [ child ]
            ]
        ]
