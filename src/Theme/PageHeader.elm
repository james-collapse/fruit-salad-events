module Theme.PageHeader exposing (viewPageHeader)

import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Css exposing (Style, alignItems, alignSelf, auto, backgroundColor, batch, block, border, borderBottomColor, borderBottomStyle, borderBottomWidth, borderBox, boxSizing, center, color, column, columnReverse, cursor, display, displayFlex, flexDirection, flexGrow, flexWrap, fontFamilies, fontSize, fontStyle, fontWeight, hover, int, italic, justifyContent, margin, margin2, marginLeft, marginRight, none, padding, padding2, paddingBottom, paddingLeft, pointer, rem, row, serif, solid, spaceBetween, textAlign, textDecoration, transparent, unset, wrap, zero)
import Css.Transitions exposing (transition)
import Helpers.TransRoutes as TransRoutes exposing (..)
import Html.Styled exposing (Html, a, button, div, h1, header, li, nav, span, text, ul)
import Html.Styled.Attributes exposing (attribute, css, href)
import Html.Styled.Events exposing (onClick)
import Messages exposing (Msg(..))
import Route exposing (Route)
import Skin.Global exposing (colorPrimary, colorSecondary, colorWhite, whiteButtonStyle)
import Theme.GlobalLayout exposing (screenReaderOnly, withMediaCanHover, withMediaTabletPortraitUp)
import UrlPath exposing (UrlPath)


headerNavigationItems : List TransRoutes.Route
headerNavigationItems =
    [ Home, Events, Partners, About ]


viewPageHeader :
    { path : UrlPath, route : Maybe Route }
    -> { showMobileMenu : Bool }
    -> Html Msg
viewPageHeader currentPath viewOptions =
    header [ css [ headerStyle ] ]
        [ div [ css [ barStyle ] ]
            [ viewPageHeaderNavigation viewOptions.showMobileMenu headerNavigationItems currentPath.path
            ]
        , div [ css [ titleBarStyle ] ]
            [ viewPageHeaderTitle
            , viewPageHeaderMenuButton (t HeaderMobileMenuButton)
            ]
        ]


viewPageHeaderTitle : Html Msg
viewPageHeaderTitle =
    div [ css [ titleStyle ] ]
        [ h1 []
            [ span [ css [ screenReaderOnly ] ] [ text (t SiteTitle) ]
            , span [ css [ acronymStyle ], attribute "aria-hidden" "true" ] [ text (t SiteAcronym) ]
            ]
        ]


viewPageHeaderNavigation : Bool -> List TransRoutes.Route -> UrlPath -> Html Msg
viewPageHeaderNavigation showMobileMenu listItems currentPath =
    nav []
        [ ul
            [ css
                (navigationListStyle
                    :: (if showMobileMenu then
                            []

                        else
                            [ display none, withMediaTabletPortraitUp [ displayFlex ] ]
                       )
                )
            ]
            (List.map
                (\item ->
                    if TransRoutes.toAbsoluteUrl item == "/" then
                        viewHeaderNavigationItem item

                    else if TransRoutes.toAbsoluteUrl item == UrlPath.toAbsolute currentPath then
                        viewHeaderNavigationItemCurrent item

                    else if String.contains (TransRoutes.toAbsoluteUrl item) (UrlPath.toAbsolute currentPath) then
                        viewHeaderNavigationItemCurrentCategory item

                    else if TransRoutes.toAbsoluteUrl item == "/donate" then
                        viewPageHeaderAsk (t HeaderAskButton) (t HeaderAskLink)

                    else
                        viewHeaderNavigationItem item
                )
                listItems
            )
        ]


viewHeaderNavigationItem : TransRoutes.Route -> Html Msg
viewHeaderNavigationItem route =
    li [ css [ navigationListItemStyle ] ]
        [ a [ href (TransRoutes.toAbsoluteUrl route), css [ navigationLinkStyle ] ]
            [ text (TransRoutes.toPageTitle route)
            ]
        ]


viewHeaderNavigationItemCurrent : TransRoutes.Route -> Html Msg
viewHeaderNavigationItemCurrent route =
    li [ css [ navigationListItemStyle ] ]
        [ span [ css [ navigationCurrentStyle ] ]
            [ text (TransRoutes.toPageTitle route)
            ]
        ]


viewHeaderNavigationItemCurrentCategory : TransRoutes.Route -> Html Msg
viewHeaderNavigationItemCurrentCategory route =
    li [ css [ navigationListItemStyle ] ]
        [ a [ href (TransRoutes.toAbsoluteUrl route), css [ navigationLinkCurrentCategoryStyle ] ]
            [ text (TransRoutes.toPageTitle route)
            ]
        ]


viewPageHeaderAsk : String -> String -> Html Msg
viewPageHeaderAsk copyText linkTo =
    li [ css [ navigationListItemStyle, askStyle ] ]
        [ a
            [ href linkTo
            , css
                [ whiteButtonStyle
                ]
            ]
            [ text copyText ]
        ]


viewPageHeaderMenuButton : String -> Html Msg
viewPageHeaderMenuButton buttonText =
    div [ css [ menuButtonStyle ] ]
        [ button
            [ onClick ToggleMenu
            , css [ menuButtonButtonStyle ]
            ]
            [ span [ css [ buttonTextStyle ] ] [ text buttonText ]
            , span [ css [ buttonCrossStyle ] ] [ text "+" ]
            ]
        ]


headerStyle : Style
headerStyle =
    batch
        [ displayFlex
        , flexDirection columnReverse
        , textAlign center
        , color colorWhite
        , paddingBottom (rem 1)
        ]


titleBarStyle : Style
titleBarStyle =
    batch
        [ displayFlex
        , justifyContent spaceBetween
        , alignItems center
        , withMediaTabletPortraitUp [ display none ]
        ]


titleStyle : Style
titleStyle =
    batch
        [ margin (rem 1)
        ]


barStyle : Style
barStyle =
    batch
        [ fontFamilies [ "cooper-black-std", .value serif ]
        , fontWeight (int 400)
        , withMediaTabletPortraitUp
            [ backgroundColor colorSecondary
            , alignItems center
            ]
        ]


menuButtonStyle : Style
menuButtonStyle =
    batch
        [ withMediaTabletPortraitUp
            [ display none
            ]
        ]


menuButtonButtonStyle : Style
menuButtonButtonStyle =
    batch
        [ alignItems center
        , backgroundColor transparent
        , border zero
        , cursor pointer
        , displayFlex
        , margin2 (rem 2) (rem 1)
        ]


buttonTextStyle : Style
buttonTextStyle =
    batch
        [ color colorWhite
        , fontStyle italic
        , marginRight (rem 0.5)
        ]


buttonCrossStyle : Style
buttonCrossStyle =
    batch
        [ color colorSecondary
        , fontSize (rem 4)
        , fontStyle italic
        , display block
        , margin2 (rem -1.75) (rem 0)
        ]


navigationListStyle : Style
navigationListStyle =
    batch
        [ displayFlex
        , flexDirection column
        , flexGrow (int 2)
        , withMediaTabletPortraitUp
            [ flexDirection row
            , fontSize (rem 1.1)
            , paddingLeft (rem 0.5)
            , flexWrap wrap
            ]
        ]


navigationListItemStyle : Style
navigationListItemStyle =
    batch
        [ backgroundColor colorSecondary
        , display block
        , padding (rem 1)
        , boxSizing borderBox
        , margin2 (rem 0.1) (rem 0)
        , fontSize (rem 1.2)
        , withMediaTabletPortraitUp
            [ padding2 (rem 1) (rem 0.75)
            , alignSelf center
            ]
        ]


navigationLinkStyle : Style
navigationLinkStyle =
    batch
        [ fontWeight (int 600)
        , color colorPrimary
        , textDecoration none
        , display block
        , borderBottomWidth (rem 0.2)
        , borderBottomStyle solid
        , borderBottomColor colorSecondary
        , withMediaCanHover [ hover [ color colorWhite ] ]
        , transition [ Css.Transitions.border 300, Css.Transitions.color 300 ]
        , withMediaTabletPortraitUp [ withMediaCanHover [ hover [ borderBottomColor colorPrimary ] ] ]
        ]


navigationCurrentStyle : Style
navigationCurrentStyle =
    batch
        [ fontWeight (int 600)
        , color colorPrimary
        , textDecoration none
        , display block
        , withMediaTabletPortraitUp
            [ borderBottomColor colorPrimary
            , borderBottomWidth (rem 0.2)
            , borderBottomStyle solid
            ]
        ]


navigationLinkCurrentCategoryStyle : Style
navigationLinkCurrentCategoryStyle =
    batch
        [ fontWeight (int 600)
        , color colorPrimary
        , textDecoration none
        , display block
        , withMediaCanHover [ hover [ color colorWhite ] ]
        , transition [ Css.Transitions.border 300, Css.Transitions.color 300 ]
        , withMediaTabletPortraitUp
            [ borderBottomColor colorPrimary
            , borderBottomWidth (rem 0.2)
            , borderBottomStyle solid
            ]
        ]


askStyle : Style
askStyle =
    batch
        [ padding (rem 0)
        , withMediaTabletPortraitUp
            [ marginLeft auto
            , display unset
            ]
        ]


acronymStyle : Style
acronymStyle =
    batch
        [ fontFamilies [ "cooper-black-std", .value serif ]
        , color colorSecondary
        , margin2 (rem 2) (rem 1)
        ]
