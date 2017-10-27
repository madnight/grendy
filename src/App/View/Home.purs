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

foreign import shorten :: String -> String

view :: State -> HTML Event
view (State st) =
  div $ do
    h1 $ text "Github Trends"
    h2 $ text "Trending repositories of the past 24 hours"
    div $ for_ st.projects showProject
    if (A.length st.projects) == 0 then do
      h2 $ text "loading github projects..."
      div ! className "progressBox" $
      div ! className "progress" $ div ! className "indeterminate" $ text ""
      else
      div ! className "more" $
        a ! className "waves-effect waves-light btn"
        #! on "onClick" (const FetchRepos) $ text "show more..."


svgStar :: HTML Event
svgStar =
  svg ! className "icon" ! height "16" ! width "14" ! viewBox "0 1 14 16"
  $ path ! fillRule "evenodd"
  ! d "M14 6l-4.9-.64L7 1 4.9 5.36 0 6l3.6 3.26L2.67\
     \ 14 7 11.67 11.33 14l-.93-4.74z"
  $ text ""

showProject :: Project -> HTML Event
showProject (Project project) =
  div ! className "project" $ do
    div ! className "todayStars" $ text $ "+" <> project.todayStars
    div ! className "avatar" $ img ! width "100" ! src project.avatarUrl
    div ! className "name" $ a ! href ("https://www.github.com/" <> project.name) $ text project.name
    div ! className "desc" $ text (shorten project.desc)
    div ! className "misc" $  do
      span ! className "star" $ svgStar
      span ! className "totalStars" $ text project.totalStars
      span ! className "license" $ text project.license
      span ! className "language" $ text project.language
