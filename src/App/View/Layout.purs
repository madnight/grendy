module App.View.Layout where

import App.Events (Event)
import App.State (State(..))
import App.View.Home as Homepage
import CSS (CSS, borderBottom, borderRadius, color, fontSize, fromString,
            key, px, em, solid, value, (?))
import CSS.Text (textDecoration, noneTextDecoration, letterSpacing)
import CSS.Text.Transform (textTransform, uppercase)
import CSS.TextAlign (center, textAlign)
import CSS.Display
import CSS.Overflow (overflow, hidden)
import CSS.Geometry
import CSS.Common (auto)
import CSS.Color
import CSS.Font
import CSS.Stylesheet (query)
import Control.Bind (discard)
import Data.Function (($), (#))
import Data.Maybe (fromMaybe)
import Pux.DOM.HTML (HTML, style)
import Text.Smolder.HTML (div)
import Text.Smolder.HTML.Attributes (className)
import Text.Smolder.Markup ((!))
import CSS.VerticalAlign
import CSS.Media as M
import Data.NonEmpty
import Prelude ((<>))

view :: State -> HTML Event
view (State st) =
  div ! className "app" $ do
    style css
    Homepage.view (State st)

textOverflow = key $ fromString "text-overflow"
noWarp = key (fromString "white-space") "nowrap"
smallScreen = query M.screen $ singleton $ M.maxWidth $ 768.0 #px

css :: CSS
css = do
  fromString "body" ? do
    key (fromString "font-family") (value "-apple-system,BlinkMacSystemFont,\"Segoe UI\",Roboto,Oxygen-Sans,Ubuntu,Cantarell,\"Helvetica Neue\",sans-serif")

  fromString ".project" ? do
    minHeight $ 120.0 #px
    marginRight $ 50.0 #px
    marginLeft $ 50.0 #px
    borderBottom solid (1.0 #px) lightgrey
    smallScreen do
      marginRight $ 5.0 #px
      marginLeft $ 5.0 #px

  fromString ".progressBox" ? do
    marginRight $ 120.0 #px
    marginLeft $ 120.0 #px
    smallScreen do
      marginRight $ 50.0 #px
      marginLeft $ 50.0 #px

  fromString ".avatar" ? do
    float floatLeft
    marginRight $ 20.0 #px
    smallScreen do
      marginRight $ 10.0 #px

  fromString "a" ? do
    paddingTop $ 10.0 #px
    fontSize $ 24.0 #px
    hexColor "#4285F4"
    smallScreen do
      fontSize $ 20.0 #px

  fromString "img" ? do
    borderRadius (0.3 #em) (0.3 #em) (0.3 #em) (0.3 #em)

  fromString ".material-icons" ? do
    marginRight $ 3.0 #px
    verticalAlign TextBottom
    bottom $ 1.0 #px
    position relative

  fromString ".legalIcon" ? do
    marginRight $ 4.0 #px
    verticalAlign TextTop
    noWarp
    position relative

  fromString ".starIcon" ? do
    marginRight $ 3.0 #px
    verticalAlign TextTop
    noWarp
    position relative

  fromString ".langIcon" ? do
    marginRight $ 5.0 #px
    verticalAlign TextTop
    noWarp
    position relative

  fromString ".name" ? do
    marginTop $ 20.0 #px
    textOverflow "ellipsis"
    overflow hidden
    noWarp

  fromString ".desc" ? do
    minHeight $ 15.0 #px
    fontSize $ 16.0 #px
    marginLeft $ 120.0 #px
    smallScreen do
      fontSize $ 14.0 #px
      marginLeft $ 110.0 #px


  fromString ".star" ? do
    marginRight $ 3.0 #px

  fromString ".todayStars" ? do
    float floatRight
    fontSize $ 28.0 #px
    minHeight $ 40.0 #px
    fontWeight bold
    color mediumseagreen
    smallScreen do
      fontSize $ 24.0 #px

  fromString ".totalStars" ? do
    minHeight $ 15.0 #px
    marginRight $ 20.0 #px

  fromString ".license" ? do
    marginRight $ 20.0 #px
    minWidth $ 75.0 #px
    hexColor "#4c4c4c"

  fromString ".license:empty" ? do
    marginRight $ 0.0 #px

  fromString ".misc" ? do
    marginTop $ 10.0 #px
    marginLeft $ 120.0 #px
    marginBottom $ 20.0 #px
    smallScreen do
      fontSize $ 12.0 #px
      marginLeft $ 110.0 #px

  fromString ".icon" ? do
    verticalAlign TextBottom
    hexColor "#FFF6FF"

  fromString ".language" ? do
    marginRight (20.0 #px)

  fromString "h1" ? do
    fontSize $ 40.0 #px
    textTransform uppercase
    letterSpacing $ 6.0 #px
    textAlign center

  fromString "h2" ? do
    fontSize $ 20.0 #px
    marginTop $ 30.0 #px
    marginBottom $ 50.0 #px
    textAlign center

  fromString ".more" ? do
    fontSize $ 25.0 #px
    margin (50.0 #px) auto (50.0 #px) auto
    textAlign center
    where
      hexColor hexstr = color $ fromMaybe white (fromHexString hexstr)
