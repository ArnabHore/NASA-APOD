# NASA-APOD
NASA Astronomy Picture of the Day
<br />
<p align="left">
  <img src="https://user-images.githubusercontent.com/20384695/201543716-78c87c26-e389-495e-a4e7-e4348ee877c2.png" width="231" height="500">
  <img src="https://user-images.githubusercontent.com/20384695/201543887-c4c63ad7-3ee2-4b35-a4f6-f988cbb99110.png" width="231" height="500">
</p>
<br />

## Requirements

- iOS 13.0+
- Xcode 13.0

## Setup

Open `NASA-APOD.xcworkspace` file on Xcode. In Xcode, select the simulator (e.g. iPhone 13) and click on the run button.

## Architecture

- I have used `MVVM` architecture here. 
- All the business logic is written inside `ViewModel` which is communicating with `Network Layer` (as I did not use `Repository` here because of time constraint). 
- Once `ViewModel` gets the data from `Network Layer`, it will parse the data and publish them which will be observed by the subscriber inside `ViewController`. 
- The `ViewModel` is communicating with `CoreDataManager`, which is performing all the local DB related work to save favourites 
- I have used `Combine` framework for this communication, it is a reactive framework, same as `RxSwift`, provided by Apple

## Note
- `Unit test` is written to test the logical features of the app
- `In line documentations` are provided for better understandings

## Third Party Vendors
- Alamofire: For network call
- Kingfisher: For downloading and caching images from the web

## Features

- Display date, explanation, title and the image / video of the day
- Users can search picture and details for a date of their choice by tapping on `calendar` icon on top left
- Users can tap on `heart` button to add/delete the image as favourite listings
- Users can tap on `list` icon at the top right to view their favourite list
- App will cache favourite information and will display even in case of network unavailability
- To read the whole explanation text, user can tap on `up` arrow
- App has dark mode support
- App can handle different screen sizes, orientations

## Developer

Arnab Hore
