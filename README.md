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
This is why you can find many class/struct which are `public`

##### Features

A folder regrouping each Feature. In a bigger application it would be nice to regroup those features in separate modules.
This application contains only two features, the classified ads list and the classified ad details.

### Time spent ⧗

- ~1h to read the subject, initialised the project and setup my environment
