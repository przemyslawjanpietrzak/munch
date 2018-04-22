module Styles exposing (myStylesheet)

import CssBasics exposing (CssValue(..), UnitType(..))
import Stylesheet exposing (..)
import Stylesheet.FontImport exposing (newFontFamily, withVariants, importFonts)

import Color


palette =
  { blue = Color.rgb 0 102 255
  , purple = Color.rgb 153 51 153
  }


fonts =
  [ "Orbitron"
  , "Roboto"
  , "sans-serif"
  ]


weight =
  { normal = 400
  , bold = 700
  }


selectors =
  { myClass = "myClass"
  , myId = "myId"
  }

myStylesheet : Stylesheet
myStylesheet =
  let
    myClassStyles =
      newRuleSet
        |> withSelectors
          [ Class "myClass" ]
        |> withDeclarations
          [ ("font-family", FontStack fonts)
          , ("font-weight", Num weight.normal)
          , ("font-size", Unit 2 Em)
          , ("color", Col palette.blue)
          , ("text-align", Str "center")
          ]


    orbitronFont =
      newFontFamily "Orbitron"
        |> withVariants
          [ weight.normal |> toString
          , weight.bold |> toString
          ]

  in
    newStylesheet
      |> withRules
        [ myClassStyles ]
      |> importFonts
        [ orbitronFont ]
