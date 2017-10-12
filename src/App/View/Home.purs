module App.View.Home where

import App.Events (Event(..))
import App.State (State(..), Project(..))
import Control.Bind (discard)
import Data.Foldable (for_)
import Data.Function (($), const)
import Data.Monoid ((<>))
import Control.Applicative ((<$>))
import Data.Show (show)
import Pux.DOM.HTML (HTML)
import Pux.DOM.Events (onClick, onScroll, onWheel, onKeyPress)
import Pux.DOM.HTML.Attributes (key, focused)
{-- import Text.Smolder.HTML (a, div, h1, ol, li, p, img, br) --}
import Text.Smolder.HTML (a, div, h1, h2, ol, li, p, img, br, table, thead, tr, th, tbody, td)
import Text.Smolder.SVG
import Text.Smolder.SVG.Attributes
import Text.Smolder.HTML.Attributes (href, className, src, tabindex)
import Text.Smolder.Markup (Markup, text, (#!), (!))
import Data.Foldable (foldMap, sum, traverse_)
import Data.Array (cons, (..), length, zipWith)
import Text.Smolder.Markup (EventHandler(..), EventHandlers, on)
import Signal.Time
import Prelude

import Control.Monad.Eff.Console (log)

view :: State -> HTML Event
view (State st) =
  div #! (on "onwheel") (const (Refetch))
      #! (on "ontouchmove") (const (Refetch))
      {-- #! (on "onkeydown") (const (Refetch)) --}
      $ do
    h1 $ text "Github Trends"
    ol $ for_ st.projects showProject
    if (length st.projects) == 0 then
      h2 $ text "loading github projects..."
      else
      h2 $ text "scroll to see more"

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
    div ! className "todayStars" $ text $ "+" <> project.todayStars
    div ! className "avatar" $ img ! width "100" ! src project.avatarUrl
    div ! className "name" $ a ! href ("https://www.github.com/" <> project.name) $ text project.name
    div ! className "desc" $ text $ project.desc
    div ! className "star" $ svgStar
    div ! className "totalStars" $ text $ project.totalStars
    div ! className "license" $ text $ project.license
    div ! className "language" $ text $ project.language
