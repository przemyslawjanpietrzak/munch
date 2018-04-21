module Stylesheet exposing (..)


import Style exposing (..)

title : List Style
title =
  [ color "#fff"
  , fontSize "24px"
  , alignItems center
  ]

--   color: $white
--   font-size: 24px
--   text-align: center
--   font-weight: 100
-- columnLayout : Styles
-- columnLayout =
--   [ display flex'
--   , flexDirection column
--   ]


-- -- we can compose specific styles with the reusable "columnLayout", above
-- container : Styles 
-- container =
--   List.concat
--         [ columnLayout
--         , [ position absolute
--           , width (pc 100)
--           , height (pc 100)
--           , fontFamily "sans-serif"
--           ]
--         ]

-- view : Html
-- view =
--   div [ style centeredLayout ] [ text "Hello, world!" ]