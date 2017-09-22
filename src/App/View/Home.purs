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
import Text.Smolder.HTML (a, div, h1, ol, li, p)
import Text.Smolder.SVG
import Text.Smolder.SVG.Attributes
import Text.Smolder.HTML.Attributes (href, className)
import Text.Smolder.Markup (text, (!))

view :: State -> HTML Event
view (State st) =
  div do
    h1 $ text "Github Trends"
    ol $ for_ st.projects showProject

showProject :: Project -> HTML Event
showProject (Project project) =
  p $ do
    a ! href ("https://www.github.com/" <> project.repo) $ text project.repo
    svg ! height "16" ! width "14" ! viewBox "0 0 14 16" $ path ! fillRule "evenodd" ! d "M14 6l-4.9-.64L7 1 4.9 5.36 0 6l3.6 3.26L2.67 14 7 11.67 11.33 14l-.93-4.74z" $ text ""
    text $ "  " <> project.stars


{-- <svg aria-label="star" class="octicon octicon-star" height="16" role="img" version="1.1" viewBox="0 0 14 16" width="14"><path fill-rule="evenodd" d="M14 6l-4.9-.64L7 1 4.9 5.36 0 6l3.6 3.26L2.67 14 7 11.67 11.33 14l-.93-4.74z"></path></svg> --}

  {-- ! className "todo" $ text (project.repo <> " Stars " <> project.stars) --}
