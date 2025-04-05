module Copy.Text exposing (t)

import Constants exposing (canonicalUrl)
import Copy.Keys exposing (Key(..), Prefix(..))
import Url



-- The translate function


t : Key -> String
t key =
    case key of
        SiteTitle ->
            "Fruit Salad Events London"

        SiteStrapline ->
            "Queer events for the community"

        PartnershipDescription ->
            -- Note this is also in content/about/main.md
            -- If they should remain in sync, we should remove from there
            "Fruit Salad Events is a collective of LGBTQIA+ event organisers who bring you all sorts of events that are designed with conversation and connection in mind, and a focus on accessibility."

        SiteLogoSrc ->
            canonicalUrl ++ "images/logos/site_logo_on_primary_background.png"

        GeeksForSocialChangeHomeUrl ->
            "https://gfsc.studio/"

        PartnerOrganisationHomeUrl ->
            "https://genderedintelligence.co.uk/"

        PartnerOrganisationLogoTxt ->
            "Gendered Intelligence"

        GoogleMapSearchUrl address ->
            "https://www.google.com/maps/search/?api=1&query=" ++ Url.percentEncode address

        SeeOnGoogleMapText ->
            "See on Google map"

        MapImageAltText locationName ->
            "A map showing the location of " ++ locationName

        PageMetaTitle pageTitle ->
            String.join " | " [ pageTitle, t SiteTitle ]

        --- Header
        HeaderMobileMenuButton ->
            "Menu"

        HeaderAskButton ->
            "Donate"

        HeaderAskLink ->
            -- PHT Donorbox
            "https://donorbox.org/the-trans-dimension"

        --- Footer
        FooterSocial ->
            "Find us on social media"

        FooterInstaLink ->
            "https://www.instagram.com/genderedintelligence/"

        FooterTwitterLink ->
            "https://twitter.com/genderintell"

        FooterFacebookLink ->
            "https://www.facebook.com/GenderedIntelligence"

        FooterSignupText ->
            "Register for updates"

        FooterSignupEmailPlaceholder ->
            "Your email address"

        FooterSignupButton ->
            "Sign up"

        FooterByLine ->
            "Created by"

        FooterInfoTitle ->
            "The Trans Dimension, c/o Gendered Intelligence"

        FooterInfoCharity ->
            "Gendered Intelligence is a Registered Charity in England and Wales No. 1182558."

        FooterInfoCompany ->
            "Registered as a Company Limited by Guarantee in England and Wales No. 06617608."

        FooterInfoOffice ->
            "Registered office at VAI, 200a Pentonville Road, London N1 9JP."

        FooterCreditTitle ->
            "Credits"

        FooterCredit1Text ->
            "Illustrations by"

        FooterCredit1Name ->
            "Harry Woodgate"

        FooterCredit1Link ->
            "https://www.harrywoodgate.com/"

        FooterCredit2Text ->
            "design by"

        FooterCredit2Name ->
            "Squid"

        FooterCredit2Link ->
            "https://studiosquid.co.uk/"

        FooterCredit3Text ->
            "website by"

        FooterCredit3Name ->
            "GFSC"

        FooterCredit3Link ->
            t GeeksForSocialChangeHomeUrl

        FooterCopyright year ->
            "© " ++ year ++ " Gendered Intelligence. All rights reserved."

        FooterPlaceCal ->
            "Powered by PlaceCal"

        --- Region Selector
        AllRegionSelectorLabel ->
            "Everywhere"

        --- Index Page
        IndexTitle ->
            "Home"

        IndexMetaDescription ->
            "Fruit Salad Events is a collective of LGBTQIA+ event organisers who bring you all sorts of events that are designed with conversation and connection in mind, and a focus on accessibility."

        IndexIntroTitle ->
            "Queer events from the community"

        IndexIntroMessage ->
            t PartnershipDescription

        IndexIntroButtonText ->
            "See what's on"

        IndexFeaturedHeader ->
            "Upcoming Events"

        IndexFeaturedButtonText ->
            "View all events"

        IndexNewsHeader ->
            "Latest news"

        IndexNewsButtonText ->
            "View all news"

        --- About Page (NOTE: also comes from md)
        AboutTitle ->
            "About"

        AboutMetaDescription ->
            t PartnershipDescription

        --- Events Page
        EventsTitle ->
            "Events"

        EventsMetaDescription ->
            "Upcoming events from our collective"

        EventsSummary ->
            "Upcoming events from our collective"

        EventsSubHeading ->
            "Upcoming events"

        EventsEmptyTextAll ->
            "There are no upcoming events. Check back for updates!"

        EventsEmptyText ->
            "There are no upcoming events on this date."

        PreviousEventsEmptyTextAll ->
            "There have been no events in the recent past."

        EventsFilterLabelToday ->
            "Today"

        EventsFilterLabelTomorrow ->
            "Tomorrow"

        EventsFilterLabelAllPast ->
            "Past events"

        EventsFilterLabelAllFuture ->
            "Future events"

        GoToNextEvent ->
            "Go to next event"

        --- Event Page
        EventTitle prefix eventName ->
            case prefix of
                Prefixed ->
                    "Event - " ++ eventName

                NoPrefix ->
                    eventName

        EventMetaDescription eventDescription ->
            eventDescription

        BackToPartnerEventsLinkText partnerName ->
            "All events by " ++ Maybe.withDefault "this partner" partnerName

        BackToEventsLinkText ->
            "All events"

        EventVisitPublisherUrlText maybePartnerName ->
            "Visit " ++ Maybe.withDefault "Publisher" maybePartnerName ++ "'s site"

        --- Partners Page
        PartnersTitle ->
            "Partners"

        PartnersMetaDescription ->
            "Fruit Salad Events is a collective where LGBTQIA+ event organisers can come together for community platform and support."

        PartnersIntroSummary ->
            "Fruit Salad Events is a collective where LGBTQIA+ event organisers can come together for community platform and support."

        PartnersIntroDescription ->
            "Collective members can actively shape the collective - if you put on similar events - get in touch to join!"

        PartnersListHeading ->
            "All partners"

        PartnersListEmpty ->
            "There are currently no Fruit Salad Events partners"

        PartnersMapAltText ->
            "A map showing the locations of all partners with listed addresses"

        --- Partner Page
        PartnerTitle partnerName ->
            "PlaceCal Partner - " ++ partnerName

        PartnerMetaDescription partnerName partnerSummary ->
            partnerName ++ " - " ++ partnerSummary

        PartnerContactsHeading ->
            "Get in touch"

        PartnerContactsEmptyText ->
            "No contact details provided"

        PartnerAddressHeading ->
            "Address"

        PartnerAddressEmptyText ->
            "No address provided"

        PartnerDescriptionEmptyText partnerName ->
            "Please ask " ++ partnerName ++ " for more information"

        PartnerUpcomingEventsText partnerName ->
            "Upcoming events by " ++ partnerName

        PartnerPreviousEventsText partnerName ->
            "Previous events by " ++ partnerName

        PartnerEventsEmptyText partnerName ->
            partnerName ++ " does not have any upcoming events. Check back for updates!"

        BackToPartnersLinkText ->
            "Go to all partners"

        --- Join Us Page
        JoinUsTitle ->
            "Join us"

        JoinUsSubtitle ->
            "Want to be listed on Fruit Salad Events?"

        JoinUsMetaDescription ->
            "Want to be listed on Fruit Salad Events? Get in touch to join the collective, either as an active member, or just to benefit from cross promotion and a community of other organisers."

        JoinUsDescription ->
            "Get in touch to join the collective, either as an active member, or just to benefit from cross promotion and a community of other organisers."

        JoinUsFormInputNameLabel ->
            "Name"

        JoinUsFormInputEmailLabel ->
            "Email address"

        JoinUsFormInputPhoneLabel ->
            "Phone number"

        JoinUsFormInputJobLabel ->
            "Job title"

        JoinUsFormInputOrgLabel ->
            "Organisation name"

        JoinUsFormInputAddressLabel ->
            "Postcode"

        JoinUsFormCheckboxesLabel ->
            "I'd like:"

        JoinUsFormCheckbox1 ->
            "A ring back"

        JoinUsFormCheckbox2 ->
            "More information"

        JoinUsFormInputMessageLabel ->
            "Your message"

        JoinUsFormInputMessagePlaceholder ->
            "Enter information about your organisation and events here or any questions you may have!"

        JoinUsFormSubmitButton ->
            "Submit"

        --- News Listing Page
        NewsTitle ->
            "News"

        NewsEmptyText ->
            "There is no recent news"

        NewsItemReadMore ->
            "Read the rest"

        NewsDescription ->
            "Updates & articles from our partners."

        --- News Single Article Page
        NewsItemTitle prefix title ->
            case prefix of
                Prefixed ->
                    "News - " ++ title

                NoPrefix ->
                    title

        NewsItemMetaDescription title author ->
            title ++ " - by " ++ author

        NewsItemReturnButton ->
            "Go back to news"

        --- Privacy Page (note this also comes from markdown)
        PrivacyTitle ->
            "Privacy"

        PrivacyMetaDescription ->
            "Privacy information for the Fruit Salad Events website."

        --- 404 Page
        ErrorTitle ->
            "Error 404"

        ErrorMessage ->
            "This page could not be found."

        ErrorButtonText ->
            "Back to home"
