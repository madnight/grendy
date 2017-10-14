module App.Events where

import App.Data.GrendyApi (query, NET)
import App.State (State(..), Projects)
import Control.Monad.Aff.Console (CONSOLE)
import DOM (DOM)
import DOM.HTML.Types (HISTORY)
import Data.Maybe (Maybe(..))
import Network.HTTP.Affjax (AJAX)
import Node.HTTP (HTTP)
import Prelude (bind, pure, ($), (<>))
import Pux (EffModel, noEffects)

foreign import getN :: String -> String
foreign import setN :: String -> Int

data Event = ReceiveRepos | Refetch | SetRepos Projects

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
foldp ReceiveRepos state =
  fetchPrint $ state
foldp Refetch state = consolePrint state

consolePrint :: ∀ fx. State -> EffModel State Event (AppEffects fx)
consolePrint (State st) =
  { state: State st
  , effects: [ do
                let x = getN ""
                test <- query ("https://grendy.herokuapp.com/" <> x)
                let _ = setN ""
                pure $ Just $ SetRepos test
             ]
  }

fetchPrint :: ∀ fx. State -> EffModel State Event (AppEffects fx)
fetchPrint state =
  { state: state
  , effects: [ do
             test <- query "https://grendy.herokuapp.com"
             pure $ Just $ SetRepos test ]
  }
