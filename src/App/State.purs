module App.State where

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

newtype State = State
  { title :: String
  , loaded :: Boolean
  , projects :: Projects
  }

init :: String -> State
init url = State
  { title: "Grendy"
  , projects: []
  , loaded: false
  }
