module Types exposing (..)

import Http


type alias Message =
    { content : String, isBot : Bool }


type alias Messages =
    List Message


type alias Model =
    { messages : Messages, inputField : String }


type Msg
    = Content String
    | Send
    | Response (Result Http.Error String)
