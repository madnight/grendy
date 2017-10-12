module App.Events where

import App.Data.GrendyApi (query, isBottom, NET)
import App.State (State(..), Projects)
import Control.Monad.Aff.Console (CONSOLE, log)
import DOM (DOM)
import DOM.HTML.Types (HISTORY)
import Data.Maybe
import Network.HTTP.Affjax (AJAX)
import Node.HTTP (HTTP)
import Prelude
import Pux (EffModel, noEffects)
import Data.Maybe (maybe)
import Data.Int
import Data.Generic (gShow)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)

foreign import now :: String -> Int
foreign import getTime :: String -> Int
foreign import setTime :: String -> Int

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
             {-- _ <- log "event" --}
             if isBottom "" then do
                if (getTime "") + 2 < (now "") then do
                  let _ = setTime ""
                  let x = getN ""
                  test <- query ("https://grendy.herokuapp.com/" <> x)
                  let _ = setN ""
                  pure $ Just $ SetRepos test
                  else
                  pure Nothing
                else
                pure Nothing
             ]
  }

fetchPrint :: ∀ fx. State -> EffModel State Event (AppEffects fx)
fetchPrint state =
  { state: state
  , effects: [ do
             test <- query "https://grendy.herokuapp.com"
             {-- test <- query "http://localhost:3000" --}
             pure $ Just $ SetRepos test ]
  }
