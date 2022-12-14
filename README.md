# Lebontest

### Application Architecture 🏛

##### App

In this folder you may find the AppDelegate and the AppCoordinator.
The AppCoordinator is the only Coordinator of the application since there is not many flow.
The Coordinator architecture is not really reflected on this Sample Project.

##### Commons / UICommons

In those folder you will find some helpers that are use through the app
Since those kind of folder tend to get quite big really fast I generally prefer putting all UI helpers separately.

##### Design

This is where the design system of the application is defined.
This part aim to be move in an external library or at least in a module.

##### Features

A folder regrouping each Feature. In a bigger application it would be nice to regroup those features in separate modules.
This application contains only two features, the classified ads list and the classified ad details.

### Time spent ⧗

- ~1h to read the subject, initialised the project and setup my environment
- ~2h to implement the basis of the Design System (Colors, Font) and create the first VM + VC with a header
- ~2h to implement the API Calls with Tests
- ~2h to create the item Design and display the list
- ~1/2h to implement the testing of the `ClassifiedAdsViewModel`
- ~1h to create the second VM + VC with the image header
- ~2h display the details on the classified ad details with Tests
- ~1h to handle navigation bar transition when scrolling on classified ad details
- ~1/2h to handle loading state on classified ads
- ~1h to handle error state on classified ads
- ~1/2h to add AppIcon & SplashScreen

### What I would like to do next 🤔

- Add more testing. (`DateFormatter`, `NumberFormatter`, ...)
- Add UISearchController to handle search on classified ads
- Add SnapshotTesting for Design Components
