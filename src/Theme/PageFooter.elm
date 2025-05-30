module Theme.PageFooter exposing (viewPageFooter)

import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Css exposing (Style, active, after, alignItems, alignSelf, auto, backgroundColor, backgroundImage, backgroundSize, batch, block, borderBox, boxSizing, center, color, column, display, displayFlex, flexDirection, flexEnd, flexShrink, flexWrap, focus, fontFamilies, fontSize, fontStyle, fontWeight, height, hover, inherit, int, italic, justifyContent, lineHeight, margin, margin2, margin4, marginBottom, marginRight, marginTop, maxWidth, none, nthLastChild, padding, padding2, padding4, pct, property, pseudoElement, px, rem, row, serif, spaceBetween, stretch, textAlign, textDecoration, url, width, wrap)
import Css.Transitions exposing (transition)
import Helpers.TransDate exposing (humanYearFromPosix)
import Helpers.TransRoutes as TransRoutes exposing (Route(..))
import Html.Styled exposing (Html, a, button, div, footer, form, img, input, label, li, nav, p, span, text, ul)
import Html.Styled.Attributes exposing (action, alt, attribute, css, for, href, id, method, name, placeholder, src, target, type_, value)
import List exposing (append, concat)
import Skin.Global exposing (colorAccentDark, colorPrimary, colorSecondary, colorWhite, secondaryButtonOnDarkBackgroundStyle, smallInlineTitleStyle, textInputStyle)
import Theme.GlobalLayout exposing (colorTransition, withMediaCanHover, withMediaMediumDesktopUp, withMediaMobileOnly, withMediaSmallDesktopUp, withMediaTabletLandscapeUp, withMediaTabletPortraitUp)
import Theme.Logo
import Time


viewPageFooter : Time.Posix -> Html msg
viewPageFooter time =
    footer [ css [ footerStyle ] ]
        [ div [ css [ footerTopSectionStyle ] ]
            [ viewPageFooterLogo
            , viewPageFooterNavigation
            ]
        , div [ css [ footerMiddleSectionStyle ] ]
            [ viewPageFooterLogos
            , viewPageFooterSocial
            ]
        , div [ css [ footerBottomSectionStyle ] ]
            [ viewPageFooterCredit time
                (t FooterCreditTitle)
            ]
        ]


viewPageFooterLogo : Html msg
viewPageFooterLogo =
    div [ css [ footerLogoStyle ] ]
        [ img
            [ src "/images/logos/fsec_logo_long_blue.svg"
            , alt (t SiteTitle)
            , css [ footerLogoImageStyle ]
            ]
            []
        , img
            [ src "/images/logos/fsec_logo_text_blue.svg"
            , alt (t SiteTitle)
            , css [ footerLogoMobileImageStyle ]
            ]
            []
        ]


viewPageFooterNavigation : Html msg
viewPageFooterNavigation =
    nav [ css [ navStyle ] ]
        [ ul [ css [ navListStyle ] ]
            (List.map viewPageFooterNavigationItem
                [ Events, Partners, About, Privacy, JoinUs ]
            )
        ]


viewPageFooterNavigationItem : TransRoutes.Route -> Html msg
viewPageFooterNavigationItem route =
    li [ css [ navListItemStyle ] ]
        [ a [ href (TransRoutes.toAbsoluteUrl route), css [ navListItemLinkStyle ] ] [ text (TransRoutes.toPageTitle route) ]
        ]


viewPageFooterLogos : Html msg
viewPageFooterLogos =
    div [ css [ createdByStyle ] ]
        [ p [ css [ subheadStyle ] ] [ text (t FooterByLine) ]
        , ul [ css [ logoListStyle ] ]
            [ li [ css [ logoListItemStyle ] ]
                [ a [ href (t GeeksForSocialChangeHomeUrl), target "_blank", css [ Theme.Logo.logoParentStyle ] ] [ Theme.Logo.viewGFSC ] ]
            ]
        ]


viewPageFooterSignup : Html msg
viewPageFooterSignup =
    -- Ideally we'd implement an ajax form and handle the result within elm
    -- Code supplied for the embed is plain html, using that for now.
    form
        [ css
            [ formStyle
            ]
        , action "https://news.gfsc.studio/subscription/form"
        , attribute "data-code" "g2r6z4"
        , method "post"
        , target "_blank"
        ]
        [ label [ for "signup", css [ subheadStyle ] ] [ text (t FooterSignupText) ]
        , div [ css [ innerFormStyle ] ]
            [ input
                [ placeholder (t FooterSignupEmailPlaceholder)
                , type_ "email"
                , name "email"
                , css [ formInputStyle ]
                , id "signup"
                ]
                []
            , input [ type_ "hidden", id "6735a", name "l", value "6735a059-52dd-4843-b76c-4d2b210462d3" ] []
            , button
                [ type_ "submit"
                , css [ secondaryButtonOnDarkBackgroundStyle, signupButtonStyle ]
                ]
                [ text (t FooterSignupButton) ]
            ]
        ]


viewPageFooterInfo : String -> List String -> Html msg
viewPageFooterInfo title info =
    div [ css [ secondaryBlockStyle ] ]
        (append
            [ p [ css [ infoParagraphStyle, fontWeight (int 700) ] ]
                [ text title
                ]
            ]
            (List.map
                (\paragraph -> p [ css [ infoParagraphStyle, marginTop (rem 0), marginBottom (rem 0) ] ] [ text paragraph ])
                info
            )
        )


viewPageFooterSocial : Html msg
viewPageFooterSocial =
    div [ css [ socialStyle ] ]
        [ p [ css [ subheadStyle ] ] [ text (t FooterSocial) ]
        , ul
            [ css [ socialListStyle ] ]
            [ li [ css [ socialListItemStyle ] ] [ a [ href (t FooterInstaLink), target "_blank", css [ Theme.Logo.logoParentStyle ] ] [ Theme.Logo.viewInsta ] ]
            ]
        ]


viewPageFooterCredit : Time.Posix -> String -> Html msg
viewPageFooterCredit time creditTitle =
    div [ css [ secondaryBlockStyle ] ]
        [ p [ css [ creditTitleStyle, marginTop (rem 0) ] ]
            [ text creditTitle ]
        , p
            [ css [ infoParagraphStyle ] ]
            [ viewPageFooterCreditText ]
        , p [ css [ infoParagraphStyle ] ] [ text (t (FooterCopyright (humanYearFromPosix time))) ]
        , a [ href "https://placecal.org" ]
            [ img
                [ src "/images/logos/footer_placecal.svg"
                , alt (t FooterPlaceCal)
                , css [ poweredByPlaceCalStyle ]
                ]
                []
            ]
        ]


viewPageFooterCreditItem : { name : String, link : String, text : String } -> Html msg
viewPageFooterCreditItem creditItem =
    span []
        [ text creditItem.text
        , text " "
        , a [ href creditItem.link, target "_blank", css [ creditLinkStyle ] ] [ text creditItem.name ]
        ]


viewPageFooterCreditText : Html msg
viewPageFooterCreditText =
    span []
        [ text (t FooterCreditText)
        , text " "
        , a [ href (t FooterCredit3Link), target "_blank", css [ creditLinkStyle ] ] [ text (t FooterCredit3Name) ]
        , text " & "
        , text (t SiteTitle)
        , text "."
        ]


footerStyle : Style
footerStyle =
    batch
        [ backgroundColor colorPrimary
        , marginTop (rem 2)
        , displayFlex
        , flexDirection column
        ]


footerTopSectionStyle : Style
footerTopSectionStyle =
    batch
        [ withMediaMediumDesktopUp [ padding4 (rem 1) (rem 20) (rem 2) (rem 20) ]
        , withMediaTabletPortraitUp
            [ displayFlex
            , alignItems stretch
            , padding4 (rem 1) (rem 1) (rem 1) (rem 1)
            , boxSizing borderBox
            , justifyContent spaceBetween
            , alignItems center
            ]
        , backgroundColor colorSecondary
        ]


footerMiddleSectionStyle : Style
footerMiddleSectionStyle =
    batch
        [ backgroundColor colorPrimary
        , padding2 (rem 1) (rem 0)
        , property "display" "grid"
        , property "grid-template-columns" "1fr"
        , property "grid-template-rows" "auto"
        , withMediaMediumDesktopUp [ padding2 (rem 1) (rem 12) ]
        , withMediaSmallDesktopUp
            [ property "grid-template-columns" "4fr 4fr"
            , property "grid-template-rows" "1fr"
            , padding2 (rem 1) (rem 2)
            ]
        , withMediaTabletLandscapeUp
            [ padding2 (rem 1) (rem 3)
            ]
        , withMediaTabletPortraitUp
            [ property "grid-template-columns" "1fr 1fr"
            , property "grid-template-rows" "1fr"
            , padding (rem 1)
            ]
        , withMediaMobileOnly
            [ property "grid-template-columns" "1fr"
            , property "grid-template-rows" "1fr 1fr"
            ]
        ]


footerBottomSectionStyle : Style
footerBottomSectionStyle =
    batch
        [ backgroundColor colorSecondary ]


footerLogoStyle : Style
footerLogoStyle =
    batch
        [ padding (rem 1)
        , backgroundColor colorSecondary
        , textAlign center
        , withMediaMobileOnly [ padding4 (rem 1) (rem 1) (rem 0) (rem 1) ]
        ]


footerLogoImageStyle : Style
footerLogoImageStyle =
    batch
        [ width (pct 100)
        , display block
        , margin2 (rem 1) auto
        , withMediaTabletPortraitUp [ margin (rem 0) ]
        , withMediaMobileOnly [ display none ]
        ]


footerLogoMobileImageStyle : Style
footerLogoMobileImageStyle =
    batch
        [ width (pct 40)
        , display block
        , margin2 (rem 1) auto
        , withMediaTabletPortraitUp [ margin (rem 0) ]
        , withMediaSmallDesktopUp [ display none ]
        , withMediaMediumDesktopUp [ display none ]
        , withMediaTabletLandscapeUp [ display none ]
        , withMediaTabletPortraitUp [ display none ]
        ]


createdByStyle : Style
createdByStyle =
    batch
        [ color colorSecondary
        , padding (rem 1)
        , boxSizing borderBox
        , withMediaSmallDesktopUp
            [ property "grid-column" "1 / 2"
            , property "grid-row" "1 / 2"
            ]
        , withMediaTabletPortraitUp
            [ property "grid-column" "1 / 2"
            , property "grid-row" "1 / 2"
            ]
        ]


socialStyle : Style
socialStyle =
    batch
        [ color colorSecondary
        , padding (rem 1)
        , boxSizing borderBox
        ]


secondaryBlockStyle : Style
secondaryBlockStyle =
    batch
        [ color colorPrimary
        , backgroundColor colorSecondary
        , padding (rem 1)
        , boxSizing borderBox
        ]


subheadStyle : Style
subheadStyle =
    batch
        [ smallInlineTitleStyle
        , color colorWhite
        , display block
        , margin4 (rem 0.5) (rem 0) (rem 1) (rem 0)
        , fontSize (rem 1.2)
        , withMediaTabletPortraitUp [ margin2 (rem 1) auto ]
        ]


navStyle : Style
navStyle =
    batch
        [ backgroundColor colorSecondary
        , padding4 (rem 1) (rem 1) (rem 1) (rem 1)
        , marginBottom (rem 1)
        , withMediaTabletPortraitUp [ marginBottom (rem 0), padding (rem 1), maxWidth (pct 55) ]
        ]


navListStyle : Style
navListStyle =
    batch
        [ withMediaTabletPortraitUp [ displayFlex, flexWrap wrap, justifyContent flexEnd ] ]


navListItemStyle : Style
navListItemStyle =
    batch
        [ textAlign center
        , fontFamilies [ "cooper-black-std", .value serif ]
        , fontWeight (int 600)
        , margin (rem 0.5)
        , fontSize (rem 1.1)
        , withMediaTabletPortraitUp [ marginRight (rem 1), margin2 (rem 0) (rem 0.5) ]
        ]


navListItemLinkStyle : Style
navListItemLinkStyle =
    batch
        [ color colorPrimary
        , textDecoration none
        , transition [ Css.Transitions.color 300 ]
        , withMediaCanHover [ hover [ color colorWhite ] ]
        ]


logoListStyle : Style
logoListStyle =
    batch
        [ displayFlex
        , flexDirection column
        , justifyContent center
        , margin2 (rem 2) (rem 0)
        , withMediaTabletPortraitUp [ flexDirection row ]
        ]


logoListItemStyle : Style
logoListItemStyle =
    batch
        [ displayFlex
        , flexDirection column
        , textAlign center
        , after
            [ color colorWhite
            , property "content" "\"+\""
            , display block
            , fontSize (rem 2)
            , margin2 (rem 1) (rem 1.5)
            , withMediaTabletPortraitUp [ margin2 (rem 0) (rem 1.5) ]
            , textAlign center
            ]
        , nthLastChild "1"
            [ after [ display none ] ]
        , withMediaTabletPortraitUp [ flexDirection row, alignItems center ]
        ]


partnershipLogoStyle : Style
partnershipLogoStyle =
    batch
        [ width (px 138.184)
        , height (px 48)
        , backgroundImage (url "/images/logos/partnership_secondary.svg")
        , backgroundSize (px 138.184)
        , withMediaCanHover [ hover [ backgroundImage (url "/images/logos/partnership_secondary_rollover.svg") ] ]
        , focus [ backgroundImage (url "/images/logos/partnership_white.svg") ]
        , active [ backgroundImage (url "/images/logos/partnership_white.svg") ]
        , alignSelf center
        ]


socialListStyle : Style
socialListStyle =
    batch
        [ displayFlex
        , justifyContent center
        , alignItems center
        , margin2 (rem 2) (rem 0)
        ]


socialListItemStyle : Style
socialListItemStyle =
    batch
        [ margin2 (rem 0) (rem 1)
        ]


formStyle : Style
formStyle =
    batch
        [ padding (rem 1)
        , boxSizing borderBox
        , color colorWhite
        , marginBottom (rem 1)
        ]


innerFormStyle : Style
innerFormStyle =
    batch
        [ withMediaTabletPortraitUp
            [ displayFlex
            , justifyContent center
            , alignItems center
            , margin2 (rem 1.5) (rem 0)
            ]
        ]


formInputStyle : Style
formInputStyle =
    batch
        [ textInputStyle
        , boxSizing borderBox
        , margin2 (rem 1) auto
        , textAlign center
        , width (pct 100)
        , fontFamilies [ "cooper-black-std", .value serif ]
        , fontSize (rem 1.2)
        , pseudoElement "placeholder" [ color colorWhite ]
        , withMediaTabletPortraitUp [ margin4 (rem 0) (rem 1) (rem 0) (rem 0) ]
        ]


signupButtonStyle : Style
signupButtonStyle =
    batch
        [ padding2 (rem 0.25) (rem 1.25)
        , maxWidth none
        , width (pct 100)
        , withMediaTabletPortraitUp
            [ flexShrink (int 0)
            , maxWidth inherit
            , width auto
            ]
        ]


creditTitleStyle : Style
creditTitleStyle =
    batch
        [ fontFamilies [ "cooper-black-std", .value serif ]
        , textAlign center
        , fontSize (rem 0.8777)
        , margin2 (rem 1) (rem 2)
        , lineHeight (rem 1.13)
        ]


infoParagraphStyle : Style
infoParagraphStyle =
    batch
        [ textAlign center
        , fontStyle italic
        , fontWeight (int 500)
        , fontSize (rem 0.8777)
        , margin2 (rem 1) (rem 2)
        , lineHeight (rem 1.13)
        ]


creditLinkStyle : Style
creditLinkStyle =
    batch
        [ color colorPrimary
        , withMediaCanHover [ hover [ color colorAccentDark ] ]
        , focus [ color colorWhite ]
        , active [ color colorWhite ]
        , transition [ colorTransition ]
        ]


poweredByPlaceCalStyle : Style
poweredByPlaceCalStyle =
    batch
        [ margin4 (rem 3) auto (rem 1) auto
        , width (px 180)
        ]
