module App.View.Home where

import App.Events (Event(..))
import App.State (State(..), Project(..))
import Data.Array (length) as A
import Data.String (take, length, null)
import Data.Foldable (for_)
import Data.Maybe
import Prelude hiding (div)
import Pux.DOM.HTML (HTML)
import Text.Smolder.HTML (a, button, div, span, h1, h2, img, ol)
import Text.Smolder.HTML.Attributes (className, href, src)
import Text.Smolder.Markup (on, text, (!), (#!))
import Text.Smolder.SVG (path, svg)
import Text.Smolder.SVG.Attributes (d, fillRule, height, viewBox, width)
import Text.Smolder.SVG.Attributes

foreign import shorten :: String -> String
foreign import toLocaleString :: String -> String
foreign import isEmpty :: String -> Boolean

void = text ""

view :: State -> HTML Event
view (State st) =
  div $ do
    h1 $ text "Github Trends"
    h2 $ text "Trending repositories of the past 24 hours"
    div $ for_ st.projects showProject
    if (A.length st.projects) == 0 then do
      h2 $ text "loading github projects..."
      div ! className "progressBox" $
      div ! className "progress" $ div ! className "indeterminate" $ void
      else
      div ! className "more" $
        a ! className "waves-effect waves-light btn"
        #! on "onClick" (const FetchRepos) $ text "show more..."

showProject :: Project -> HTML Event
showProject (Project project) =
  when (not isEmpty project.desc) do
  div ! className "project" $ do
    div ! className "todayStars" $ text $ "+" <> project.todayStars
    div ! className "avatar" $ img ! width "100" ! src project.avatarUrl
    div ! className "name" $ a ! href ("https://www.github.com/" <> project.name) $ text project.name
    div ! className "desc" $ text (shorten project.desc)
    div ! className "misc" $  do
      span ! className "starIcon" $ img ! width "14" ! src "https://cdnjs.cloudflare.com/ajax/libs/octicons/4.4.0/svg/star.svg"
      span ! className "totalStars" $ text (toLocaleString project.totalStars)
      span ! className "legalIcon" $ if (isEmpty project.license) then void else img ! width "14" ! src "https://cdnjs.cloudflare.com/ajax/libs/octicons/4.4.0/svg/law.svg"
      span ! className "license" $ text project.license
      span ! className "langIcon" $ if (isEmpty project.language) then void else img ! width "14" ! src "https://cdnjs.cloudflare.com/ajax/libs/octicons/4.4.0/svg/code.svg"
      span ! className "language" $ text project.language
