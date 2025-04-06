module Theme.Page.Index exposing (view)

import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Css exposing (Style, absolute, auto, backgroundPosition, backgroundRepeat, backgroundSize, batch, before, block, borderRadius, bottom, calc, center, color, display, displayFlex, em, fontFamilies, fontSize, fontStyle, fontWeight, important, inlineBlock, int, italic, justifyContent, lineHeight, margin2, marginBottom, marginLeft, marginRight, marginTop, maxWidth, minus, noRepeat, normal, num, opacity, padding2, padding4, paddingBottom, paddingLeft, paddingRight, paddingTop, pct, position, property, px, relative, rem, sansSerif, serif, textAlign, vw, width, zIndex)
import Data.PlaceCal.Articles
import Data.PlaceCal.Events
import Data.PlaceCal.Partners
import Helpers.TransRoutes
import Html.Styled exposing (Html, a, div, h2, img, p, section, text)
import Html.Styled.Attributes exposing (alt, css, href, src)
import Skin.Global exposing (colorPrimary, primaryBackgroundStyle, primaryButtonStyle, secondaryBackgroundStyle, secondaryButtonOnDarkBackgroundStyle, smallFloatingTitleStyle, whiteButtonStyle)
import Theme.GlobalLayout
    exposing
        ( buttonFloatingWrapperStyle
        , withMediaMediumDesktopUp
        , withMediaSmallDesktopUp
        , withMediaTabletLandscapeUp
        , withMediaTabletPortraitUp
        )
import Theme.Page.Events exposing (Msg, fromRegionSelectorMsg)
import Theme.Page.News
import Theme.Paginator
import Theme.RegionSelector
import Time


view :
    { events : List Data.PlaceCal.Events.Event
    , partners : List Data.PlaceCal.Partners.Partner
    , articles : List Data.PlaceCal.Articles.Article
    , time : Time.Posix
    }
    ->
        { localModel
            | filterByRegion : Int
            , nowTime : Time.Posix
        }
    -> Html Theme.Page.Events.Msg
view sharedData localModel =
    div [ css [ pageWrapperStyle ] ]
        [ viewIntroLogo
        , viewIntro (t IndexIntroTitle) (t IndexIntroMessage) (t IndexIntroButtonText)
        , viewFeatured localModel.nowTime (Data.PlaceCal.Events.eventsWithPartners sharedData.events sharedData.partners) localModel.filterByRegion
        , viewLatestNews (List.head sharedData.articles) (t IndexNewsHeader) (t IndexNewsButtonText)
        ]


viewIntroLogo : Html msg
viewIntroLogo =
    section [ css [ sectionStyle ] ]
        [ div [ css [ logoStyle ] ]
            [ logoImage 0.5
            , logoImage 1.0
            , logoImage 0.5
            ]
        ]


logoImage : Float -> Html msg
logoImage op =
    img
        [ src "/images/logos/fsec_logo_text_pink.svg"
        , alt (t SiteTitle)
        , css [ logoImageStyle, opacity (num op) ]
        ]
        []


viewIntro : String -> String -> String -> Html msg
viewIntro introTitle introMsg eventButtonText =
    section [ css [ sectionStyle, secondaryBackgroundStyle ] ]
        [ h2 [ css [ sectionSubtitleStyle ] ] [ text introTitle ]
        , p [ css [ sectionTextStyle ] ] [ text introMsg ]
        , p [ css [ buttonFloatingWrapperStyle, width (calc (pct 100) minus (rem 2)) ] ]
            [ a
                [ href (Helpers.TransRoutes.toAbsoluteUrl Helpers.TransRoutes.Events)
                , css [ whiteButtonStyle ]
                ]
                [ text eventButtonText ]
            ]
        ]


viewFeatured : Time.Posix -> List Data.PlaceCal.Events.Event -> Int -> Html Msg
viewFeatured fromTime eventList regionId =
    section [ css [ sectionStyle, primaryBackgroundStyle, eventsSectionStyle ] ]
        [ h2 [ css [ smallFloatingTitleStyle ] ] [ text (t IndexFeaturedHeader) ]
        , if List.length Data.PlaceCal.Partners.partnershipTagList > 1 then
            Theme.RegionSelector.viewRegionSelector { filterBy = regionId } |> Html.Styled.map fromRegionSelectorMsg

          else
            text ""
        , Theme.Page.Events.viewEventsList { filterByDate = Theme.Paginator.Future, filterByRegion = regionId, nowTime = fromTime } eventList (Just 8)
        , viewAllEventsButton
        ]


viewAllEventsButton : Html msg
viewAllEventsButton =
    p [ css [ buttonFloatingWrapperStyle, width (calc (pct 100) minus (rem 2)) ] ]
        [ a
            [ href (Helpers.TransRoutes.toAbsoluteUrl Helpers.TransRoutes.Events)
            , css [ secondaryButtonOnDarkBackgroundStyle ]
            ]
            [ text (t IndexFeaturedButtonText) ]
        ]


viewLatestNews : Maybe Data.PlaceCal.Articles.Article -> String -> String -> Html msg
viewLatestNews maybeNewsItem title buttonText =
    section [ css [ sectionStyle, primaryBackgroundStyle, newsSectionStyle ] ]
        [ h2 [ css [ smallFloatingTitleStyle ] ] [ text title ]
        , case maybeNewsItem of
            Just news ->
                Theme.Page.News.viewNewsArticle news

            Nothing ->
                text ""
        , p [ css [ buttonFloatingWrapperStyle, bottom (rem -6), width (calc (pct 100) minus (rem 2)) ] ]
            [ a
                [ href (Helpers.TransRoutes.toAbsoluteUrl Helpers.TransRoutes.News)
                , css [ primaryButtonStyle ]
                ]
                [ text buttonText ]
            ]
        ]


pageWrapperStyle : Style
pageWrapperStyle =
    batch
        [ margin2 (rem 0) (rem 0.75)
        , withMediaSmallDesktopUp [ margin2 (rem 0) (rem 6) ]
        , withMediaTabletLandscapeUp [ margin2 (rem 0) (rem 5) ]
        , withMediaTabletPortraitUp [ margin2 (rem 0) (rem 1.5) ]
        ]


logoStyle : Style
logoStyle =
    batch
        [ displayFlex
        , justifyContent center
        ]


logoImageStyle : Style
logoImageStyle =
    batch
        [ width (px 570)
        , padding2 (rem 1) (rem 1)
        , display inlineBlock
        , withMediaMediumDesktopUp [ width (px 527) ]
        , withMediaSmallDesktopUp [ width (px 381) ]
        , withMediaTabletLandscapeUp [ width (px 305) ]
        ]


sectionStyle : Style
sectionStyle =
    batch
        [ borderRadius (rem 0.3)
        , padding4 (rem 1) (rem 1) (rem 4) (rem 1)
        , marginBottom (rem 2)
        , position relative
        , before
            [ property "content" "\"\""
            , display block
            , width (vw 100)
            , backgroundSize (px 420)
            , backgroundPosition center
            , position absolute
            , zIndex (int -1)
            , backgroundRepeat noRepeat
            , margin2 (rem 0) (rem -1.75)
            , withMediaMediumDesktopUp
                [ backgroundSize (px 1920)
                , margin2 (rem 0) (calc (vw -50) minus (px -475))
                ]
            , withMediaSmallDesktopUp
                [ backgroundSize (px 1366)
                , margin2 (rem 0) (rem -14)
                ]
            , withMediaTabletLandscapeUp
                [ backgroundSize (px 1200)
                , margin2 (rem 0) (rem -6)
                ]
            , withMediaTabletPortraitUp
                [ backgroundSize (px 900)
                , margin2 (rem 0) (rem -2.5)
                ]
            ]
        , withMediaMediumDesktopUp
            [ maxWidth (px 950), marginRight auto, marginLeft auto ]
        , withMediaSmallDesktopUp
            [ padding4 (rem 3) (rem 1) (rem 3) (rem 1)
            , marginLeft (rem 7)
            , marginRight (rem 7)
            ]
        , withMediaTabletPortraitUp
            [ paddingBottom (rem 3) ]
        ]


sectionSubtitleStyle : Style
sectionSubtitleStyle =
    batch
        [ padding2 (rem 0.5) (rem 1)
        , marginBottom (rem 1)
        , textAlign center
        , fontFamilies [ "cooper-black-std", .value serif ]
        , fontStyle normal
        , fontSize (rem 2.1)
        , lineHeight (em 1.1)
        , fontWeight (int 400)
        , color colorPrimary
        , withMediaSmallDesktopUp
            [ margin2 (rem 0.5) (rem 1) ]
        , withMediaTabletPortraitUp
            [ fontSize (rem 3.2)
            , margin2 (rem 0.5) (rem 4)
            , paddingLeft (rem 0)
            , paddingRight (rem 0)
            ]
        ]


sectionTextStyle : Style
sectionTextStyle =
    batch
        [ fontFamilies [ "Satoshi", .value sansSerif ]
        , fontStyle italic
        , fontWeight (int 500)
        , textAlign center
        , color colorPrimary
        , withMediaSmallDesktopUp
            [ margin2 (rem 2) (rem 8) ]
        , withMediaTabletPortraitUp
            [ fontSize (rem 1.2)
            , margin2 (rem 1) (rem 4)
            ]
        ]


eventsSectionStyle : Style
eventsSectionStyle =
    batch
        [ marginTop (px 125) ]


newsSectionStyle : Style
newsSectionStyle =
    batch
        [ marginTop (px 240)
        , marginBottom (px 240)
        , withMediaMediumDesktopUp
            [ marginBottom (px 230), marginTop (px 220) ]
        , withMediaSmallDesktopUp
            [ marginBottom (px 200) ]
        , withMediaTabletLandscapeUp
            [ marginTop (px 150), marginBottom (px 150) ]
        , withMediaTabletPortraitUp
            [ marginTop (px 175), marginBottom (px 175), paddingTop (rem 2), important (paddingBottom (rem 4)) ]
        ]
