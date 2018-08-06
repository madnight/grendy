module App.View.Home where

import App.Events                   (Event( ..))
import App.State                    (State( ..), Project ( ..))
import Data.Array                   (last)
import Data.Array                   (length) as A
import Data.Foldable                (for_)
import Data.Maybe                   (fromMaybe)
import Data.Monoid                  (mempty)
import Data.String                  (split, Pattern( ..))
import Prelude                      (const, discard, not, when, ($), (<>), (==))
import Pux.DOM.HTML                 (HTML)
import Text.Smolder.HTML            (a, div, span, h1, h2, img)
import Text.Smolder.HTML.Attributes (className, href, src, target)
import Text.Smolder.Markup          (on, text, ( !), ( #!))
import Text.Smolder.SVG.Attributes  (width)

foreign import shorten        :: String -> String
foreign import toLocaleString :: String -> String
foreign import isEmpty        :: String -> Boolean

view :: State -> HTML Event
view (State st) =
  div $ do

    h1 $ text "Github Trends"
    h2 $ text "Trending repositories of the past 24 hours"
    div $ for_ st.projects showProject

    if (A.length st.projects) == 0 then do
      h2 $ text "loading github projects..."
      div ! className "progressBox" $
      div ! className "progress" $ div ! className "indeterminate" $ text mempty
      else
      div ! className "more" $
        a ! className "waves-effect waves-light btn"
        #! on "onClick" (const FetchRepos) $ text "show more..."

showProject :: Project -> HTML Event
showProject (Project project) =

  when (not isEmpty project.desc) do

  class' "project" $ do

    class' "todayStars" $ text $ "+" <> project.todayStars
    class' "avatar" $ img ! width "100" ! src project.avatarUrl
    class' "name" $ url $ text project.name
    class' "smallName" $
      url $ text $ fromMaybe "" $ last $ split (Pattern "/") project.name
    class' "desc" $ text (shorten project.desc)

    class' "misc" $ do

      span' "starIcon" $ img ! width "14" !  src (cdn <> "star.svg")
      span' "totalStars" $ text (toLocaleString project.totalStars)

      span' "legalIcon" $
        if (isEmpty project.license) then text mempty
        else img ! width "14" !
        src (cdn <> "law.svg")

      span' "license" $ text project.license

      span' "langIcon" $
        if (isEmpty project.language) then text mempty
        else img ! width "14" !
        src (cdn <> "code.svg")

      span ! className "language" $ text project.language

  where url = a ! href ("https://www.github.com/" <> project.name) ! target "_blank"
        class' name = div ! className name
        span' name = span ! className name
        cdn = "https://cdnjs.cloudflare.com/ajax/libs/octicons/4.4.0/svg/"
