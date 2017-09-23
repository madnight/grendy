module App.View.Home where

import App.Events (Event)
import App.State (State(..), Project(..))
import Control.Bind (discard)
import Data.Foldable (for_)
import Data.Function (($))
import Data.Monoid ((<>))
import Data.Show (show)
import Pux.DOM.HTML (HTML)
import Pux.DOM.HTML.Attributes (key)
import Text.Smolder.HTML (a, div, h1, ol, li, p, img, br)
import Text.Smolder.SVG
import Text.Smolder.SVG.Attributes
import Text.Smolder.HTML.Attributes (href, className, src)
import Text.Smolder.Markup (text, (!))

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
  $ text ""

showProject :: Project -> HTML Event
showProject (Project project) =
  p $ do
    a ! href ("https://www.github.com/" <> project.repo) $ text project.repo
    svgStar
    text $ " +" <> project.stars
    br
    img ! src "https://avatars.githubusercontent.com/HVF?v=3&amp;s=160"

{-- <img src="https://avatars.githubusercontent.com/HVF?v=3&amp;s=160" class="thumb animated fadeIn" data-reactid=".0.1.1:$0.1:$HVF/franchise.1.0"> --}


