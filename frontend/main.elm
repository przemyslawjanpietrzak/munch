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
type alias Messages = List Message
type alias Model = { messages : Messages }
model : Model
model =  { messages = ["a", "b"] }

-- UPDATE
type Msg
    = Content String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Content content ->
      { model | messages = content :: model.messages }

-- VIEW
showMessage : Message -> Html Msg
showMessage message = div [] [ text message ]

showMessages : Messages -> Html Msg
showMessages messages =
  ul [] (
    List.map showMessage messages
  )

view : Model -> Html Msg
view model =
  div []
    [ input [ type_ "text", placeholder "Name", onInput Content ] []
    -- , div [  ] [ text model ]
      , showMessages ( model.messages )
    ]
    -- , input [ type_ "password", placeholder "Password", onInput Password ] []
    -- , input [ type_ "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
    -- , viewValidation model
    -- ]



