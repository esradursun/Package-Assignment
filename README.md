# Package Application

- --
`Package` project provides a package list iOS application which contains sort and filter algorithms. It provides to pick a pacakage as a favorite and store it into the local file manager. Once the package is selected and added to the favorite list, it is resorted based on the sorting business logic and repositioned at the top of the list.
Favorite packages are stored into a plist named `favoritePackage.plist` in the local file manager.

There are 3 different sorting option buttons which are `Data` as a default, `Talk` and `Sms`.
For filtering there is a `Filter` button on the top left. Filter button contains 4 different filtering options as `Yearly`, `Monthly`, `Weekly` and `Available until date`. This dropbox is implemented as a Cocoapods library. 
The searchbar can be used for searching the packages by a package name.

# Technologies
- ---
 - Swift 5
 - JSONDecoder
 - MVVM Design Pattern
 - CocoaPods
 - XCTest

# Prerequisites
- ---
 - Cocoapods
 - XCode(12.2)

# Run & Build
- --
To build and run `package` application you can follow the below directions;
```sh
$ cd Package-Assignment
$ pod install
```
It's mandatory to install cocoapods to your local system. it can be installed by the following directions;
```sh
$ sudo gem install cocoapods
```