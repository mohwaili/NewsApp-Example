# News App
This app fetches the latest headlines & news articles from https://newsapi.org/ 


![Gif](https://media.giphy.com/media/hX0SB8TMuq2gOBxAYE/giphy.gif)

## Requirements
* Swift 5.0
* Xcode 11
* iOS 10+

## Features
 - Shows an overview of news articles for the given query & category
 - Detail screen to show more info about the article 
 - Browser to read the full article

## Architecture

  - The app is built using the MVVM architecture 
  - The workspace consists of 
    - NewsAPIKit: contains of the network client, repositories, models, operations... 
    - NewsUIKit: contains of GenericErrorView & The colors used in the app
    - NewsApp: The iOS app implementation
 
 ## Tools & Dependencies

  - Swiftlint: code checking 
  - EarlGrey: UI Testing 
  - Swiftgen: Generating Assets & Strings 
  - Sourcery: Generating mocks 

## Tests
 - Unit tests are written using XCTest framework (NewsAPIKit & The ViewModels in NewsApp)
 - UI tests are written using EarlGrey 

## Improvements
 - Implement SSL Pinning for better security to prevent Man-in-the-middle attacks
 - Extend Unit & UI tests for the detail screen
 - Configure fastlane to build, Test & deploy
 - Convert the Overview screen to a UICollectionView to support multi column layout (iPad)
 - Add caching for image download to prevent unnecessary calls 
 - Extend NewsUIKit with fonts & styles
 - Animate the header away while scrolling down
 - Implement Empty state support
 - Let a UI/UX designer have a look to improve the overal app appearance 
