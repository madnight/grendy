module App.State where

import Data.Maybe

type Projects = Array Project

newtype Project = Project
  { name :: String
  , todayStars :: String
  , avatarUrl :: String
  , date :: String
  , language :: String
  , totalStars :: String
  , todayStars :: String
  , license :: String
  , desc :: String
  }

data State = State
  { title :: String
  , loaded :: Boolean
  , projects :: Projects
  , pagination :: Int
  }

init :: String -> State
init url = State
  { title: "Grendy"
  , projects: []
  , loaded: false
  , pagination: 0
  }
