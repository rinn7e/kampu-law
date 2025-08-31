module Main exposing (main)

import Browser
import Data.Article exposing (Article, articles)
import Data.Emoji exposing (Subject, subjects, topics)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, stopPropagationOn)
import Json.Decode as Json
import List.Extra as List
import Ports
import Svg exposing (path, svg)
import Svg.Attributes as SvgAttr
import VitePluginHelper


type Modal
    = What
    | Search
    | About


type Msg
    = None
    | SetModal (Maybe Modal)
    | ScrollToStart
    | ToggleSubject Int


type alias Model =
    { modal : Maybe Modal
    , subjects : List Subject
    }


init : Model
init =
    { modal = Nothing, subjects = subjects }


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> ( init, Cmd.none )
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )

        SetModal val ->
            ( { model | modal = val }, Cmd.none )

        ScrollToStart ->
            ( model, Ports.scrollToId "app" )

        ToggleSubject i ->
            let
                updatedSubjects =
                    List.updateAt i (\s -> { s | selected = not s.selected }) model.subjects
            in
            ( { model | subjects = updatedSubjects }, Ports.scrollToId "app" )


logo =
    svg
        [ SvgAttr.fill "none"
        , SvgAttr.viewBox "0 0 24 24"
        , SvgAttr.strokeWidth "1.5"
        , SvgAttr.stroke "currentColor"
        , SvgAttr.class "text-black size-100"
        ]
        [ path
            [ SvgAttr.strokeLinecap "round"
            , SvgAttr.strokeLinejoin "round"
            , SvgAttr.d "M12 6.042A8.967 8.967 0 0 0 6 3.75c-1.052 0-2.062.18-3 .512v14.25A8.987 8.987 0 0 1 6 18c2.305 0 4.408.867 6 2.292m0-14.25a8.966 8.966 0 0 1 6-2.292c1.052 0 2.062.18 3 .512v14.25A8.987 8.987 0 0 0 18 18a8.967 8.967 0 0 0-6 2.292m0-14.25v14.25"
            ]
            []
        ]


logoText =
    div [ class "text-center" ]
        [ h1 []
            [ span [] [ text "KAMPU" ]
            , br [] []
            , span [] [ text "LAW" ]
            ]
        ]


view : Model -> Html Msg
view model =
    let
        filterArticles =
            articles
                |> List.filter
                    (\a ->
                        let
                            selectedSub =
                                model.subjects
                                    |> List.filter (\s -> s.selected)
                                    |> List.map .code

                            doesAHasAllTheSub =
                                selectedSub
                                    |> List.all (\code -> List.member code a.tags)
                        in
                        doesAHasAllTheSub
                    )
                |> List.indexedMap
                    (\i a ->
                        div [ class "text-center flex flex-col items-center gap-6 text-xl" ]
                            [ div [ class "flex items-center gap-10 opacity-30" ]
                                [ hr [ class "w-100" ] []
                                , p [] [ text <| String.fromInt a.index ]
                                , hr [ class "w-100" ] []
                                ]
                            , p [] [ text a.content ]
                            , div [ class "flex gap-20" ] <| List.map (\t -> p [] [ text t ]) a.tags
                            ]
                    )
    in
    div [ class "" ]
        [ div [ class "max-w-1000 mx-auto py-100 flex flex-col items-center gap-20 px-20" ]
            [ logo
            , logoText
            , div [ class "flex flex-col gap-20 " ] <|
                ifElse (List.length filterArticles /= 0) filterArticles [ text "មិនមាន" ]
            ]
        , modalContainerView model
        ]


modalContainerView model =
    let
        visibleClass =
            case model.modal of
                Just Search ->
                    "opacity-100"

                Just About ->
                    "opacity-100"

                _ ->
                    "opacity-0"
    in
    div []
        [ if model.modal == Nothing then
            text ""

          else
            div
                [ onClick <| SetModal Nothing
                , class <| "fixed z-[9] inset-0"
                ]
                [ text "" ]
        , div
            [ class "fixed z-10 bottom-0 w-full flex flex-col items-center pb-16 "
            , onClick <| ifElse (model.modal == Nothing) None (SetModal Nothing)
            ]
            [ div [ class "flex flex-col gap-20 items-center px-8", onClickStopPropagation None ]
                [ case model.modal of
                    Just Search ->
                        modal (modalContent model)

                    Just About ->
                        modal modalContent2

                    _ ->
                        text ""
                , nav model
                ]
            ]
        ]


modal content =
    div [ class <| "bg-white w-full max-w-400 max-h-500 shadow-lg rounded-[16px] overflow-auto p-16 text-center flex flex-col items-center gap-20" ]
        content


qrIcon =
    svg
        [ SvgAttr.fill "none"
        , SvgAttr.viewBox "0 0 24 24"
        , SvgAttr.strokeWidth "1.5"
        , SvgAttr.stroke "currentColor"
        , SvgAttr.class "text-black size-26"
        ]
        [ path
            [ SvgAttr.strokeLinecap "round"
            , SvgAttr.strokeLinejoin "round"
            , SvgAttr.d "M3.75 4.875c0-.621.504-1.125 1.125-1.125h4.5c.621 0 1.125.504 1.125 1.125v4.5c0 .621-.504 1.125-1.125 1.125h-4.5A1.125 1.125 0 0 1 3.75 9.375v-4.5ZM3.75 14.625c0-.621.504-1.125 1.125-1.125h4.5c.621 0 1.125.504 1.125 1.125v4.5c0 .621-.504 1.125-1.125 1.125h-4.5a1.125 1.125 0 0 1-1.125-1.125v-4.5ZM13.5 4.875c0-.621.504-1.125 1.125-1.125h4.5c.621 0 1.125.504 1.125 1.125v4.5c0 .621-.504 1.125-1.125 1.125h-4.5A1.125 1.125 0 0 1 13.5 9.375v-4.5Z"
            ]
            []
        , path
            [ SvgAttr.strokeLinecap "round"
            , SvgAttr.strokeLinejoin "round"
            , SvgAttr.d "M6.75 6.75h.75v.75h-.75v-.75ZM6.75 16.5h.75v.75h-.75v-.75ZM16.5 6.75h.75v.75h-.75v-.75ZM13.5 13.5h.75v.75h-.75v-.75ZM13.5 19.5h.75v.75h-.75v-.75ZM19.5 13.5h.75v.75h-.75v-.75ZM19.5 19.5h.75v.75h-.75v-.75ZM16.5 16.5h.75v.75h-.75v-.75Z"
            ]
            []
        ]


searchIcon =
    svg
        [ SvgAttr.fill "none"
        , SvgAttr.viewBox "0 0 24 24"
        , SvgAttr.strokeWidth "1.5"
        , SvgAttr.stroke "currentColor"
        , SvgAttr.class "text-black size-26"
        ]
        [ path
            [ SvgAttr.strokeLinecap "round"
            , SvgAttr.strokeLinejoin "round"
            , SvgAttr.d "m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z"
            ]
            []
        ]


chevronUpIcon =
    svg
        [ SvgAttr.fill "none"
        , SvgAttr.viewBox "0 0 24 24"
        , SvgAttr.strokeWidth "1.5"
        , SvgAttr.stroke "currentColor"
        , SvgAttr.class "text-black size-26"
        ]
        [ path
            [ SvgAttr.strokeLinecap "round"
            , SvgAttr.strokeLinejoin "round"
            , SvgAttr.d "m4.5 15.75 7.5-7.5 7.5 7.5"
            ]
            []
        ]


nav model =
    div [ class "flex gap-40" ]
        [ button
            [ onClick <| ifElse (model.modal == Just About) (SetModal Nothing) (SetModal (Just About))
            , class "cursor-pointer w-60 h-60 rounded-full shadow-lg bg-white hover:bg-gray-200 flex items-center justify-center"
            ]
            [ qrIcon ]
        , button
            [ onClick <| ifElse (model.modal == Just Search) (SetModal Nothing) (SetModal (Just Search))
            , class "cursor-pointer w-60 h-60 rounded-full shadow-lg bg-white hover:bg-gray-200 flex items-center justify-center"
            ]
            [ searchIcon ]
        , button
            [ onClick <| ScrollToStart
            , class "cursor-pointer w-60 h-60 rounded-full shadow-lg bg-white hover:bg-gray-200 flex items-center justify-center"
            ]
            [ chevronUpIcon ]
        ]


modalContent : Model -> List (Html Msg)
modalContent model =
    [ p [ class "font-semibold" ] [ text "ប្រធានបទ" ]
    , div [ class "flex justify-center text-lg flex-wrap" ]
        (model.subjects
            |> List.indexedMap
                (\i s ->
                    div [ class "w-[20%] p-[2px]" ]
                        [ button
                            [ class <| ifElse s.selected "bg-gray-200" "bg-white" ++ " hover:bg-gray-200 h-full rounded-[8px] p-8 cursor-pointer"
                            , onClick <| ToggleSubject i
                            ]
                            [ p [] [ text s.code ]
                            , p [ class "text-xs" ] [ text s.label ]
                            ]
                        ]
                )
        )

    -- , p [] [ text "Topics" ]
    -- , div [ class "flex justify-center gap-10 text-lg" ] (topics |> List.map (\s -> div [] [ text s ]))
    ]


modalContent2 =
    [ p [ class "font-semibold" ] [ text "ទិញកាហ្វេអោយ១ទៅហី..." ]
    , div [ class "flex flex-col items-center gap-8" ]
        [ img [ src "./src/assets/qr.jpg", class "w-180" ] []
        , p [ class "text-sm flex flex-col" ]
            [ span [] [ text "បង្កើតដោយ" ]
            , span [] [ text "rinn7e" ]
            ]
        ]
    ]


ifElse : Bool -> a -> a -> a
ifElse condition whenTrue whenFalse =
    if condition then
        whenTrue

    else
        whenFalse


onClickStopPropagation : msg -> Attribute msg
onClickStopPropagation msg =
    stopPropagationOn "click" <| Json.succeed ( msg, True )
