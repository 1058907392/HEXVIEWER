{-- A text input for reversing text. Very useful!
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/text_fields.html
--}
port module Main exposing (..)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Hex exposing (..)
import Debug
import String exposing (..)

-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


-- MODEL


type alias Model =
  { primitivedata : String 
    ,hexnumdata : String 
    ,hexdisplaydata : String
    ,hexstringdata : String
    ,hexselectioninfo : String
    ,hextypeconvert : String
  }

init : () -> ( Model, Cmd Msg )
init _ =
    ( { primitivedata = "" ,hexnumdata="",hexdisplaydata="",hexstringdata="",hexselectioninfo="",hextypeconvert=""}, Cmd.none )


-- UPDATE
 

type Msg 
  =  ReceivedDataFromJS String
  --| PrimitiveToHex String

port receiveData : (String -> msg) -> Sub msg
 

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "msg" msg of

        --PrimitiveToHex newContent ->
           --({ model | hexdisplaydata = (decimaltohexdecimal newContent), hexnumdata = newContent,hexstringdata = newContent },Cmd.none)
        ReceivedDataFromJS data ->
            ( {model | hextypeconvert = (hextoviewer data)}, Cmd.none )

-- listen to JS to get the selected hex data.
subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveData ReceivedDataFromJS

--hex parsing
hextoviewer : String -> String
hextoviewer selected_txt =
    (String.reverse  selected_txt )

--decimal transfer to hexical display
decimaltohex : Int -> String
decimaltohex decimalnum =
   (Hex.toString decimalnum)
 {--
--decimal to hexdecimal function 
decimaltohexdecimal : String-> String 
decimaltohexdecimal decimalstring = 
 
   
    if String.length decimalstring /= 0 then
        if String.left 1 decimalstring == "[" && String.right 1 decimalstring == "]" then
            String.dropRight 1 decimalstring
                |> String.dropLeft 1
                 
        else 
            "list format is incorrect" --Debug.log "info:" "list format is incorrect"
    else 
        "list format is incorrect" --Debug.log "info:" "list string is empty"    
    -}
-- VIEW


view : Model -> Html Msg 
view model =
  div [][
    div [id "inputdiv" , class "box1" ] 
        [ 
            --textarea [id "inputtextarea" ,placeholder "input the primitive data" ,onInput PrimitiveToHex ][ ]
            textarea [id "inputtextarea" ,placeholder "input the primitive data" ][ ]
        ]
    ,div [class "box2"][
        div [id "hexrowsnumber" ,class "lie1"]
            [
                   
            ]
         ,div [id "content1" ,class "lie2"]
            [
                     
            ]
          ,div [id "hexstring" ,class "lie3"]
            [
                    
            ]
        ]
       
        ,div[class "box3"][
            div [id "infodashboard" ,class "lie4"]
            [  
                input [id "start_selection"] []
                ,br[][]
                ,text "-"
                ,br[][]
                ,input [id "end_selection"] []
             ] 
            ,div [id "convert" ,class "lie5"]
             [
               table[][
                    tr[][
                        td[style "width" "5%"][ text "type"]
                        ,td[style "width" "3%"][ text "i8"]
                        ,td[style "width" "3%"][ text "i16le"]
                        ,td[style "width" "4%"][ text "i32le"]
                        ,td[style "width" "10%"][ text "i64le"]
                        ,td[style "width" "3%"][ text "i16be"]
                        ,td[style "width" "4%"][ text "i32be"]
                        ,td[style "width" "10%"][ text "i64be"]
                        ,td[style "width" "12%"][ text "float be-le"]
                        ,td[style "width" "12%"][ text "double be-le"]
                        ,td[style "width" "18%"][ text "utf-8"]
                        ,td[style "width" "18%"][ text "ascii"]
                    ]
                 
                    ,tr[][
                        td[][ text "unsigned" ]
                        ,td[id "i8_unsigned" ,class "convert_div"][ ]
                        ,td[id "i16le_unsigned",class "convert_div"][ ]
                        ,td[id "i32le_unsigned",class "convert_div"][ ]
                        ,td[id "i64le_unsigned",class "convert_div"][ ]
                        ,td[id "i16be_unsigned",class "convert_div"][ ]
                        ,td[id "i32be_unsigned",class "convert_div"][ ]
                        ,td[id "i64be_unsigned",class "convert_div"][ ]
                        ,td[id "float_be",class "convert_div"][ ]
                        ,td[id "double_be",class "convert_div"][ ]
                        ,td[id "utf",class "convert_div"][ ]
                        ,td[id "ascii",class "convert_div"][ ]
                    ]
                     
                    ,tr[][
                        td[][ text "signed"]
                        ,td[id "i8_signed" ,class "convert_div"][ ]
                        ,td[id "i16le_signed",class "convert_div"][ ]
                        ,td[id "i32le_signed",class "convert_div"][ ]
                        ,td[id "i64le_signed",class "convert_div"][ ]
                        ,td[id "i16be_signed",class "convert_div"][ ]
                        ,td[id "i32be_signed",class "convert_div"][ ]
                        ,td[id "i64be_signed",class "convert_div"][ ]
                        ,td[id "float_le" ,class "convert_div"][ ]
                        ,td[id "double_le" ,class "convert_div"][ ]
                        ,td[][ ]
                        ,td[][ ]
                    ]
                    
               ]
            ] 
        ]
      
    ]

  
   