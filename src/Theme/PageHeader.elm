module Theme.PageHeader exposing (viewPageHeader)

import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Css exposing (Style, backgroundColor, batch, block, bold, center, color, display, displayFlex, fontSize, fontWeight, hex, hover, justifyContent, marginRight, marginTop, none, padding, paddingBottom, paddingLeft, paddingTop, pct, rem, spaceBetween, textAlign, textDecoration, width)
import Css.Media exposing (grid)
import Helpers.TransRoutes as TransRoutes exposing (Route(..))
import Html.Styled exposing (Html, a, div, h1, header, li, nav, p, text, ul)
import Html.Styled.Attributes exposing (css, href)
import Theme.Global exposing (black, blue, darkBlue, pink, white)


viewPageHeader : Html msg
viewPageHeader =
    header [ css [ headerStyle ] ]
        [ div [ css [ barStyle ] ]
            [ viewPageHeaderNavigation ""
            , viewPageHeaderAsk (t HeaderAskButton) "http://donate.com"
            ]
        , viewPageHeaderTitle (t SiteTitle) (t SiteStrapline)
        ]


viewPageHeaderTitle : String -> String -> Html msg
viewPageHeaderTitle pageTitle strapLine =
    div []
        [ h1 [ css [ titleStyle ] ] [ text pageTitle ]
        , p [] [ text strapLine ]
        ]


viewPageHeaderNavigation : String -> Html msg
viewPageHeaderNavigation listItems =
    nav []
        [ ul [ css [ navigationListStyle ] ]
            (List.map viewHeaderNavigationItem
                [ Home, Partners, Events, NewsList, About, Resources ]
            )
        ]


viewHeaderNavigationItem : TransRoutes.Route -> Html msg
viewHeaderNavigationItem route =
    li [ css [ navigationListItemStyle ] ]
        [ a [ href (TransRoutes.toAbsoluteUrl route), css [ navigationLinkStyle ] ]
            [ text (TransRoutes.toPageTitle route)
            ]
        ]


viewPageHeaderAsk : String -> String -> Html msg
viewPageHeaderAsk copyText linkTo =
    div []
        [ a [ href linkTo, css [ askButtonStyle ] ] [ text copyText ]
        ]


headerStyle : Style
headerStyle =
    batch
        [ backgroundColor darkBlue
        , textAlign center
        , color white
        , paddingBottom (rem 1)
        ]


titleStyle : Style
titleStyle =
    batch
        [ fontSize (rem 2)
        , color pink
        , paddingTop (rem 1)
        ]


barStyle : Style
barStyle =
    batch
        [ displayFlex
        , justifyContent spaceBetween
        , backgroundColor blue
        , padding (rem 1)
        ]


navigationListStyle : Style
navigationListStyle =
    batch
        [ displayFlex
        , fontSize (rem 1.1)
        , paddingLeft (rem 1)
        ]


navigationListItemStyle : Style
navigationListItemStyle =
    batch
        [ marginRight (rem 1)
        , marginTop (rem 1)
        , color black
        ]


navigationLinkStyle : Style
navigationLinkStyle =
    batch
        [ fontWeight bold
        , color black
        , textDecoration none
        , display block
        , hover [ color pink ]
        ]


askButtonStyle : Style
askButtonStyle =
    batch
        [ display block
        , backgroundColor pink
        , color black
        , textDecoration none
        , padding (rem 1)
        , width (rem 5)
        , textAlign center
        , fontWeight bold
        ]
