<p align="center">
    <h1 align="center">Github Trending Repositories<br></h1>
</p>

<p align=center>
<a href="https://www.gnu.org/licenses/agpl-3.0.en.html"><img src="https://img.shields.io/badge/license-AGPL--3.0-brightgreen.svg" alt="License (AGPL-3.0)"></a>
<a href="https://codeclimate.com/github/madnight/grendy"><img src="https://codeclimate.com/github/madnight/grendy/badges/gpa.svg" alt="Code Climate"></a>
<a href="https://codeclimate.com/github/madnight/grendy"><img src="https://codeclimate.com/github/madnight/grendy/badges/issue_count.svg" alt="Issue Count"></a>
<a href="https://david-dm.org/madnight/grendy"><img src="https://david-dm.org/madnight/grendy/status.svg" alt="dependencies Status"></a>
<a href="https://snyk.io/test/github/madnight/grendy"><img src="https://snyk.io/test/github/madnight/grendy/badge.svg" alt="Known Vulnerabilities"></a>

![](https://i.imgur.com/V7IjvFD.png)

This project is written in pure functional haskell like language [PureScript](http://try.purescript.org/) together with the [pux framework]( https://github.com/alexmingoia/purescript-pux). Pux is currently in a experimental state and might have some performance bottlenecks.

Main PUX function for projects in type-safe HTML Smolder Markup:

```purescript
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
```

The CSS is also written in purescript an checked for correctness at compile time.
```purescript
  fromString ".todayStars" ? do
    float floatRight
    marginTop (10.0 #px)
    fontSize (28.0 #px)
    minHeight (40.0 #px)
    fontWeight bold
    color mediumseagreen
```

Pros:
* Type-safe web application
* Isomorphic rendering
* Hot reloading
* Render to React (or any virtual DOM library)
* Time-travelling debugging
* Good JavaScript interop (one can use all npm libs)
* The #haskell and #purescript community on freenode and in general is very helpful and kind

Cons:
* Performance
* Steep learning curve
* JavaScript interop is unpure, hence a bit hacky

# Backend API
https://github.com/madnight/grendel

The backend API fetches the required information from Google BigQuery plus Github via GraphQL and is written in Haskell.

# Related Work 

https://github.com/trending
* Pros: select trending repos per programming language e.g. top trending haskell
* Cons: limitation of top 25 repos

http://www.gitlogs.com/
* Pros: select trending repos per programming language e.g. top trending haskell
* Cons: closed source, secret selection mechanism, GitHub OAuth required because of API rate limit
