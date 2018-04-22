module Styles exposing (myStylesheet, selectors)

import CssBasics exposing (CssValue(..), UnitType(..))
import Stylesheet exposing (..)
import Stylesheet.FontImport exposing (newFontFamily, withVariants, importFonts)
import Color


palette =
    { blue = Color.rgb 30 150 243
    , white = Color.rgb 0 0 0
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
    , title = "title"
    }


myStylesheet : Stylesheet
myStylesheet =
    let
        title =
            newRuleSet
                |> withSelectors
                    [ Class selectors.title ]
                |> withDeclarations
                    [ ( "color", Col palette.white )
                    , ( "font-weight", Num weight.normal )
                    , ( "font-size", Num 24 )
                    , ( "text-align", Str "center" )
                    ]
    in
        newStylesheet
            |> withRules
                [ title ]
