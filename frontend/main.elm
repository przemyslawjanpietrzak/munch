import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }

-- MODEL

type alias Message = String
-- type Messages = List Message
type alias Model = Message
model : Model
model =  "init"

-- UPDATE
type Msg
    = Content String
update : Msg -> Model -> Model
update msg model =
  case msg of
    Content content ->
      content

-- VIEW
-- showMessages : Model -> Html Messages
-- showMessages model =
--     div [  ] [ text model ]

view : Model -> Html Msg
view model =
  div []
    [ input [ type_ "text", placeholder "Name", onInput Content ] []
    ,div [  ] [ text model ]
      -- , showMessages model
    ]
    -- , input [ type_ "password", placeholder "Password", onInput Password ] []
    -- , input [ type_ "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
    -- , viewValidation model
    -- ]



