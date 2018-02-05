# SWIFT
The app has the libraries compiled in SWIFT 4.0 to compile it and make it work fine please use XCode 9.0.0 or use another version but befor run carthage update.

# Sports Events App
Movies  iOS app is using [Clean Architecture](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html) and [MVP](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93presenter).

## Description
Sports Events App works to list and show sports using an own API that allows you use a mock created in JS, This app is created for tesing purposes.

## Architecture
The code is divided in 3 layers, Core, ViewModel and View. The Core is structured following the main premises of [Clean Architecture](https://github.com/mp911de/CleanArchitecture "Clean Architecture"). The app follows the [dependency inversion principle](https://en.wikipedia.org/wiki/Dependency_inversion_principle) using the protocol oriented approach that Swift has on its foundations. The app has unit test for each layer.

### Core
On this layer belongs all the classes which main concern is handling the data and the high level rules of the app.

#### - Entities
On this group belongs the AppSyncData protocol which represents the data to be consumed by the app. 

#### - Services
Services represents external agents like the web service used for getting the data and the repository in which data is stored, grouped and fetched. All the interfaces on this group are protocols, this allows mock objects to conform these protocols and being used for testing purposes on higher layers (like use cases and view models).

#### - Use Cases
The code in this layer contains application specific business rules. Each use case is represented by a protocol, the internal implementation is separated from the interface. Having a protocol per Use Case enforces the [Single Responsibility Principle](https://en.wikipedia.org/wiki/Single_responsibility_principle), facilitates unit testing and improves traceability. The use cases are accessed via the UseCaseLocator class which is a [Service Locator](https://en.wikipedia.org/wiki/Service_locator_pattern) providing a centralized place to resolve and inject the use cases dependencies. The objects on this group relies on the entities and the services via protocols (to preserve dependency inversion principle) and returns the data using [DTOs](https://en.wikipedia.org/wiki/Data_transfer_object) to avoid exposing the entity layer and to model the data in a convenient way to be consumed by the App.

## Presenter
The objects in this layer have the responsibilities described in the [MVP](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93presenter) architectural pattern. The Presenters relies on the UseCases to get the data and model in a convenient way to be shown in the UI.

## View

The objects on this layer are the UIViewControllers and the UIViews used to present the data to the user. The view controller binds the data from the ViewModels to the UI objects, for tracking changes simple closure are used. This project doesn't include any binding framework to keep this as simple as posible and avoid coupling the layers with any reactive code.


## Carthage
This is the dependency manager to work with Swift. It exclusively uses dynamic frameworks instead of static libraries, this is only way to distribute Swift binaries that are that are supported by iOS 8+.

### Carthage - Installation
At the "core" of Carthage" is a command line tool that assists with fetching and building dependencies.
There are 2 ways to install it: downloading and running a .pkg installer for the latest release, or using the Homebrew package manager.

First method (using brew):
    - Run in Terminal app: ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null
    - Press enter/return key. Wait for the command to finish.
    - Once it is done, run: brew install carthage

Second method (download the .pkg file manually):
    - Download the .pkg from here: https://github.com/Carthage/Carthage/releases
    - Install the .pkg downloaded.

### Carthage - First Cartfile
A cartfile is a simple text file that describes your project's dependencies to Carthage, so it can determine what to install. Each line in a Cartfile states where to fetch a dependency from, the name of the dependency, and optionally, which version of the dependency to use. A Cartfile is the equivalent of a CocoaPods Pod-file.

So these are the steps to create a Cartfile:
    - Open a Terminal app
    - Run the following command: touch Cartfile
    - Run the following command to edit it: open -a Xcode Cartfile
    - Add the dependencies you want to integrate with your project, for instance:
    
        github "Alamofire/Alamofire" ~> 4.3
        github "Alamofire/AlamofireImage" ~> 3.1
        github "realm/realm-cocoa"

There are two key pieces of information on each line of a Cartfile:
    - Dependency origin: this tells Carthage where to fetch a dependency from. Carthage supports 2 types of origins: github (you specify a Github project in the Username/ProjectName format) and git (The git keyword is followed by the path to the git repository, whether that's a remote URL using git://, http://, or ssh://, or a local path to a git repository).
    - Dependency version: this is how you tell Carthage which version of a dependency you would like to use. There are a number of options at your disposal, depending on how specific you want to be:
        + "== 1.0" means "Use exactly version 1.0"
        + ">= 1.0" means "Use version 1.0 or higher"
        + "~> 1.0" means "Use any version that is compatible with 1.0", essentially meaning any version up until the next major release.
        + "branchName/tagName/commitName" means "Use this specific git branch / tag / commit". For example, it could be like: "master/v0.1.0/2c3b74a"
