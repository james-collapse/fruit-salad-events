module Route.Partners.Partner_ exposing (Model, Msg, RouteParams, route, Data, ActionData)

{-|

@docs Model, Msg, RouteParams, route, Data, ActionData

-}

import BackendTask
import BackendTask.Custom
import Browser.Dom
import Constants
import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Data.PlaceCal.Events
import Data.PlaceCal.Partners
import Effect
import FatalError
import Head
import Helpers.TransRoutes exposing (Route(..))
import Html.Styled
import Json.Encode
import PagesMsg
import RouteBuilder
import Shared
import Task
import Theme.Global
import Theme.PageTemplate
import Theme.Paginator exposing (Msg(..))
import Theme.PartnerPage
import Time
import UrlPath
import View


type alias Model =
    { filterBy : Theme.Paginator.Filter
    , visibleEvents : List Data.PlaceCal.Events.Event
    , nowTime : Time.Posix
    , viewportWidth : Float
    , urlFragment : Maybe String
    }


type alias Msg =
    Theme.Paginator.Msg


type alias RouteParams =
    { partner : String }


route : RouteBuilder.StatefulRoute RouteParams Data ActionData Model Msg
route =
    RouteBuilder.preRender
        { data = data
        , pages = pages
        , head = head
        }
        |> RouteBuilder.buildWithLocalState
            { view = view
            , init = init
            , update = update
            , subscriptions = subscriptions
            }


init :
    RouteBuilder.App Data ActionData RouteParams
    -> Shared.Model
    -> ( Model, Effect.Effect Msg )
init app shared =
    let
        urlFragment : Maybe String
        urlFragment =
            Maybe.andThen .fragment app.url

        tasks : List (Effect.Effect Msg)
        tasks =
            [ Task.perform GetTime Time.now
                |> Effect.fromCmd
            , Task.perform GotViewport Browser.Dom.getViewport
                |> Effect.fromCmd
            ]
    in
    ( { filterBy = Theme.Paginator.None
      , visibleEvents = app.sharedData.events
      , nowTime = Time.millisToPosix 0
      , viewportWidth = 320
      , urlFragment = urlFragment
      }
    , Effect.batch
        (case urlFragment of
            Just fragment ->
                tasks
                    ++ [ Browser.Dom.getElement fragment
                            |> Task.andThen (\element -> Browser.Dom.setViewport 0 element.element.y)
                            |> Task.attempt (\_ -> NoOp)
                            |> Effect.fromCmd
                       ]

            Nothing ->
                tasks
        )
    )


update :
    RouteBuilder.App Data ActionData RouteParams
    -> Shared.Model
    -> Msg
    -> Model
    -> ( Model, Effect.Effect Msg )
update app shared msg model =
    case msg of
        ClickedDay posix ->
            ( { model
                | filterBy = Theme.Paginator.Day posix
                , visibleEvents =
                    Data.PlaceCal.Events.eventsFromDate app.sharedData.events posix
              }
            , Effect.none
            )

        ClickedAllPastEvents ->
            ( { model
                | filterBy = Theme.Paginator.Past
                , visibleEvents = List.reverse (Data.PlaceCal.Events.onOrBeforeDate app.sharedData.events model.nowTime)
              }
            , Effect.none
            )

        ClickedAllFutureEvents ->
            ( { model
                | filterBy = Theme.Paginator.Future
                , visibleEvents = Data.PlaceCal.Events.afterDate app.sharedData.events model.nowTime
              }
            , Effect.none
            )

        GetTime newTime ->
            ( { model
                | filterBy = Theme.Paginator.Day newTime
                , nowTime = newTime
                , visibleEvents =
                    Data.PlaceCal.Events.eventsFromDate app.sharedData.events newTime
              }
            , Effect.none
            )

        ScrollRight ->
            ( model
            , Task.attempt (\_ -> NoOp)
                (Theme.Paginator.scrollPagination Theme.Paginator.Right model.viewportWidth)
                |> Effect.fromCmd
            )

        ScrollLeft ->
            ( model
            , Task.attempt (\_ -> NoOp)
                (Theme.Paginator.scrollPagination Theme.Paginator.Left model.viewportWidth)
                |> Effect.fromCmd
            )

        GotViewport viewport ->
            ( { model | viewportWidth = Maybe.withDefault model.viewportWidth (Just viewport.scene.width) }, Effect.none )

        NoOp ->
            ( model, Effect.none )


subscriptions : RouteParams -> UrlPath.UrlPath -> Shared.Model -> Model -> Sub Msg
subscriptions routeParams path shared model =
    Sub.none


type alias Data =
    ()


type alias ActionData =
    BackendTask.BackendTask FatalError.FatalError (List RouteParams)


data : RouteParams -> BackendTask.BackendTask FatalError.FatalError Data
data routeParams =
    BackendTask.succeed ()


head : RouteBuilder.App Data ActionData RouteParams -> List Head.Tag
head app =
    let
        partner =
            Data.PlaceCal.Partners.partnerFromSlug app.sharedData.partners app.routeParams.partner
    in
    Theme.PageTemplate.pageMetaTags
        { title = PartnerTitle partner.name
        , description = PartnerMetaDescription partner.name partner.summary
        , imageSrc = Nothing
        }


view :
    RouteBuilder.App Data ActionData RouteParams
    -> Shared.Model
    -> Model
    -> View.View (PagesMsg.PagesMsg Msg)
view app shared model =
    let
        aPartner =
            Data.PlaceCal.Partners.partnerFromSlug app.sharedData.partners app.routeParams.partner
    in
    { title = t (PageMetaTitle aPartner.name)
    , body =
        [ Theme.PageTemplate.view
            { headerType = Just "pink"
            , title = t PartnersTitle
            , bigText = { text = aPartner.name, node = "h3" }
            , smallText = Nothing
            , innerContent =
                Just
                    (Theme.PartnerPage.viewInfo model
                        { partner = aPartner, events = app.sharedData.events }
                    )
            , outerContent = Just (Theme.Global.viewBackButton (Helpers.TransRoutes.toAbsoluteUrl Partners) (t BackToPartnersLinkText))
            }
        ]
    }


pages : BackendTask.BackendTask FatalError.FatalError (List RouteParams)
pages =
    BackendTask.map
        (\partnerData ->
            partnerData.allPartners
                |> List.map (\partner -> { partner = partner.id })
        )
        (BackendTask.Custom.run "fetchAndCachePlaceCalData"
            (Json.Encode.object
                [ ( "collection", Json.Encode.string "partners" )
                , ( "url", Json.Encode.string Constants.placecalApi )
                , ( "query", Data.PlaceCal.Partners.allPartnersQuery )
                ]
            )
            Data.PlaceCal.Partners.partnersDecoder
        )
        |> BackendTask.allowFatal
