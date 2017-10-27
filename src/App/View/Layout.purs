module App.View.Layout where

import App.Events (Event)
import App.State (State(..))
import App.View.Home as Homepage
import CSS (CSS, borderBottom, borderRadius, color, fontSize, fromString,
            key, px, solid, value, (?))
import CSS.Text (textDecoration, noneTextDecoration, letterSpacing)
import CSS.Text.Transform (textTransform, uppercase)
import CSS.TextAlign (center, textAlign)
import CSS.Display
import CSS.Geometry
import CSS.Common (auto)
import CSS.Color
import CSS.Font
import Control.Bind (discard)
import Data.Function (($), (#))
import Data.Maybe (fromMaybe)
import Pux.DOM.HTML (HTML, style)
import Text.Smolder.HTML (div)
import Text.Smolder.HTML.Attributes (className)
import Text.Smolder.Markup ((!))
import CSS.VerticalAlign
import Prelude ((<>))

view :: State -> HTML Event
view (State st) =
  div ! className "app" $ do
    style css
    Homepage.view (State st)

css :: CSS
css = do
  fromString "body" ? do
    key (fromString "font-family") (value "-apple-system,BlinkMacSystemFont,\"Segoe UI\",Roboto,Oxygen-Sans,Ubuntu,Cantarell,\"Helvetica Neue\",sans-serif")

  fromString ".project" ? do
    minHeight (120.0 #px)
    marginRight (30.0 #px)
    marginLeft (30.0 #px)
    borderBottom solid (1.0 #px) lightgrey

  fromString ".progressBox" ? do
    marginRight (150.0 #px)
    marginLeft (150.0 #px)

  fromString ".avatar" ? do
    float floatLeft
    marginRight (20.0 #px)

  fromString "a" ? do
    paddingTop (10.0 #px)
    fontSize (24.0 #px)
    hexColor "#4285F4"

  fromString ".material-icons" ? do
    marginRight (3.0 #px)
    verticalAlign TextBottom
    bottom (1.0 #px)
    position relative

  fromString ".legalIcon" ? do
    marginRight (4.0 #px)
    verticalAlign TextTop
    position relative

  fromString ".starIcon" ? do
    marginRight (3.0 #px)
    verticalAlign TextTop
    position relative

  fromString ".langIcon" ? do
    marginRight (5.0 #px)
    verticalAlign TextTop
    position relative

  fromString ".name" ? do
    marginTop (20.0 #px)

  fromString ".desc" ? do
    minHeight (15.0 #px)
    fontSize (16.0 #px)

  fromString ".star" ? do
    marginRight (3.0 #px)

  fromString ".todayStars" ? do
    float floatRight
    marginTop (10.0 #px)
    fontSize (28.0 #px)
    minHeight (40.0 #px)
    fontWeight bold
    color mediumseagreen

  fromString ".totalStars" ? do
    minHeight (15.0 #px)
    fontSize (14.0 #px)
    marginRight (20.0 #px)

  fromString ".license" ? do
    marginRight (20.0 #px)
    minWidth (75.0 #px)
    hexColor "#4c4c4c"

  fromString ".license:empty" ? do
    marginRight (0.0 #px)

  fromString ".misc" ? do
    marginTop (10.0 #px)
    marginLeft (120.0 #px)
    fontSize (14.0 #px)
    marginBottom (20.0 #px)

  fromString ".icon" ? do
    verticalAlign TextBottom
    hexColor "#FFF6FF"

  fromString ".language" ? do
    marginRight (20.0 #px)

  fromString "h1" ? do
    fontSize (40.0 #px)
    textTransform uppercase
    letterSpacing (6.0 #px)
    textAlign center

  fromString "h2" ? do
    fontSize (20.0 #px)
    marginTop (30.0 #px)
    marginBottom (50.0 #px)
    textAlign center

  fromString ".more" ? do
    fontSize (25.0 #px)
    margin (50.0 #px) auto (50.0 #px) auto
    textAlign center
    where
      hexColor hexstr = color $ fromMaybe white (fromHexString hexstr)
