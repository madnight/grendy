module App.Events where

import App.Data.GrendyApi (query, NET)
import App.State (State(..), Projects)
import Control.Monad.Aff.Console (CONSOLE)
import DOM (DOM)
import DOM.HTML.Types (HISTORY)
import Data.Maybe (Maybe(..))
import Network.HTTP.Affjax (AJAX)
import Node.HTTP (HTTP)
import Prelude (bind, pure, ($), (<>), (+), show, (==))
import Data.Monoid (mempty)
import Pux (EffModel, noEffects)

data Event = IncrementPagination | FetchRepos | SetRepos Projects

type AppEffects fx =
  ( history :: HISTORY
  , dom :: DOM
  , console :: CONSOLE
  , net :: NET
  , http :: HTTP
  , ajax :: AJAX | fx
  )

foldp :: ∀ fx. Event -> State -> EffModel State Event (AppEffects fx)

foldp (SetRepos p) (State st) =
  noEffects $ State st { projects = st.projects <> p }

foldp IncrementPagination (State st) =
  noEffects $ State st { pagination = st.pagination + 1 }

foldp FetchRepos state = fetchRepos state

fetchRepos :: ∀ fx. State -> EffModel State Event (AppEffects fx)
fetchRepos (State st) =
  { state: State st
  , effects: [ do
                let page = if st.pagination == 0 then mempty
                           else (show st.pagination)
                repos <- query ("https://grendy.herokuapp.com/" <> page)
                pure $ Just $ SetRepos repos
                ,
                pure $ Just $ IncrementPagination
             ]
  }
