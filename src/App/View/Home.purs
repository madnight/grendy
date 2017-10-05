module App.View.Home where

import App.Events (Event)
import App.State (State(..), Project(..))
import Control.Bind (discard)
import Data.Foldable (for_)
import Data.Function (($))
import Data.Monoid ((<>))
import Control.Applicative ((<$>))
import Data.Show (show)
import Pux.DOM.HTML (HTML)
import Pux.DOM.HTML.Attributes (key)
{-- import Text.Smolder.HTML (a, div, h1, ol, li, p, img, br) --}
import Text.Smolder.HTML (a, div, h1, ol, li, p, img, br, table, thead, tr, th, tbody, td)
import Text.Smolder.SVG
import Text.Smolder.SVG.Attributes
import Text.Smolder.HTML.Attributes (href, className, src)
import Text.Smolder.Markup (Markup, text, (!))
import Data.Foldable (foldMap, sum, traverse_)
import Data.Array (cons, (..), length, zipWith)

view :: State -> HTML Event
view (State st) =
  div do
    h1 $ text "Github Trends"
    ol $ for_ st.projects showProject

svgStar :: HTML Event
svgStar =
  svg ! height "16" ! width "14" ! viewBox "0 0 14 16"
  $ path ! fillRule "evenodd"
  ! d "M14 6l-4.9-.64L7 1 4.9 5.36 0 6l3.6 3.26L2.67\
     \ 14 7 11.67 11.33 14l-.93-4.74z"
  $ text "asda"

showProject :: Project -> HTML Event
showProject (Project project) =
  div ! className "project" $ do
  p $ do
    div ! className "todayStars" $ text $ "+" <> project.todayStars
    div ! className "avatar" $ img ! width "100" ! src project.avatarUrl
    div ! className "name" $ a ! href ("https://www.github.com/" <> project.name) $ text project.name
    div ! className "desc" $ text $ project.desc
    div ! className "star" $ svgStar
    div ! className "totalStars" $ text $ project.totalStars
    div ! className "license" $ text $ project.license
    div ! className "language" $ text $ project.language
