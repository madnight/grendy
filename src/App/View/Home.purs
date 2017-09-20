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
import Text.Smolder.HTML (div, h1, ol, li)
import Text.Smolder.HTML.Attributes (className)
import Text.Smolder.Markup (text, (!))

view :: State -> HTML Event
view (State st) =
  div do
    h1 $ text "Github Trends"
    ol $ for_ st.projects showProject

showProject :: Project -> HTML Event
showProject (Project project) =
  li ! key (show project.owner)
  ! className "todo" $ text (project.owner <> "/" <> project.name)
