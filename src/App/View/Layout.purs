module App.View.Layout where

import App.Events (Event)
import App.State (State(..))
import App.View.Home as Homepage
import CSS (CSS, borderBottom, borderRadius, color, fontSize, fromString,
            key, px, solid, value, (?))
import CSS.Text (textDecoration, noneTextDecoration, letterSpacing)
import CSS.Text.Transform (textTransform, uppercase)
import CSS.TextAlign (center, textAlign)
import CSS.Display (display, flex, float, floatLeft, floatRight, inlineBlock)
import CSS.Geometry (margin, marginLeft, marginRight, marginTop, minHeight, minWidth, padding, paddingBottom, paddingTop)
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
    marginTop (20.0 #px)

  fromString ".name" ? do
    fontSize (28.0 #px)
    color mediumseagreen

  fromString "a" ? do
    fontSize (28.0 #px)
    hexColor "#3C7382"

  fromString ".desc" ? do
    minHeight (15.0 #px)
    fontSize (16.0 #px)

  fromString ".star" ? do
    marginRight (5.0 #px)

  fromString ".todayStars" ? do
    float floatRight
    fontSize (28.0 #px)
    minHeight (40.0 #px)
    fontWeight bold
    color mediumseagreen

  fromString ".totalStars" ? do
    minHeight (15.0 #px)
    marginRight (20.0 #px)

  fromString ".license" ? do
    marginRight (20.0 #px)
    minWidth (75.0 #px)

  fromString ".misc" ? do
    marginTop (10.0 #px)
    marginLeft (120.0 #px)
    fontSize (14.0 #px)

  fromString ".language" ? do
    marginRight (20.0 #px)

  fromString "h1" ? do
    fontSize (48.0 #px)
    textTransform uppercase
    letterSpacing (6.0 #px)
    textAlign center

  fromString "h2" ? do
    fontSize (20.0 #px)
    marginTop (30.0 #px)
    textAlign center

  fromString "button" ? do
    fontSize (25.0 #px)
    margin (30.0 #px) auto auto auto
    textAlign center
    display flex
    where
      hexColor hexstr = color $ fromMaybe white (fromHexString hexstr)
