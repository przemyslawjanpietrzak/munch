module Api exposing (getUrl)

import Http
import Json.Decode as Decode
import Types exposing (Msg)


getUrl : String -> Cmd Msg
getUrl title =
    let
        url =
            "/painting/" ++ title
    in
        Http.send Types.Response (Http.get url decodeUrl)


decodeUrl : Decode.Decoder String
decodeUrl =
    Decode.at [ "url" ] Decode.string
