module App.View.Layout where

import App.Events (Event)
import App.State (State(..))
import App.View.Home as Homepage
import CSS (CSS, fromString, (?), fontSize, color, display, inlineBlock, marginBottom, marginTop, marginRight, px, value, key, padding, borderRadius, minHeight, paddingTop, paddingBottom, borderBottom, solid)
import CSS.Text (textDecoration, noneTextDecoration, letterSpacing)
import CSS.Text.Transform (textTransform, uppercase)
import CSS.TextAlign (center, textAlign)
import CSS.Display
import Color (rgb)
import CSS.Color
import Control.Bind (discard)
import Data.Function (($), (#))
import Pux.DOM.HTML (HTML, style)
import Text.Smolder.HTML (div)
import Text.Smolder.HTML.Attributes (className)
import Text.Smolder.Markup ((!))

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
    paddingTop (25.0 #px)
    paddingBottom (50.0 #px)
    minHeight (70.0 #px)
    borderBottom solid (1.0 #px) lightgrey

  fromString ".avatar" ? do
    float floatLeft
    marginRight (20.0 #px)

  fromString ".name" ? do
    fontSize (28.0 #px)

  fromString ".desc" ? do
    fontSize (15.0 #px)
    minHeight (15.0 #px)

  fromString ".star" ? do
    float floatLeft
    marginRight (5.0 #px)

  fromString ".todayStars" ? do
    float floatRight
    fontSize (40.0 #px)
    minHeight (40.0 #px)
    color mediumseagreen

  fromString ".totalStars" ? do
    float floatLeft
    fontSize (15.0 #px)
    marginRight (20.0 #px)
    {-- marginTop (5.0 #px) --}

  fromString ".license" ? do
    float floatLeft
    fontSize (15.0 #px)
    marginRight (20.0 #px)

  fromString ".language" ? do
    float floatLeft
    fontSize (15.0 #px)
    marginRight (20.0 #px)

  fromString "h1" ? do
    fontSize (48.0 #px)
    textTransform uppercase
    letterSpacing (6.0 #px)
    textAlign center

  fromString "a" ? do
    display inlineBlock
    borderRadius (2.0 #px) (2.0 #px) (2.0 #px) (2.0 #px)
    padding (6.0 #px) (6.0 #px) (6.0 #px) (6.0 #px)
    textDecoration noneTextDecoration
