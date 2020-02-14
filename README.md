# TheMovieDB

This is a demo Movie Browsing app written with VIPER Architecture using Swift 5.1 , XCode 11.3

![demo](https://user-images.githubusercontent.com/21119818/74569080-fdcb4c80-4f92-11ea-9a2b-fee5cb28e84c.gif)

## About VIPER

### Viper Components

Each VIPER module consists of the following parts:

View (View, ViewController)
Interactor (Business Logic, Use Cases)
Presenter (Prepare Business logic for presentation in the View)
Entity (Model)
Router (Assemble each module and Take control of Routing)

### Dependency Graph

The dependence graph is unidirectional, which means:
View knows about Presenter
Presenter knows about Router and Interactor
Interactor communicates with Database/Repository

### Dependency Inversion (Feedback Loop)

However, when we want to inform the outer layer changes of the inner layer, a feedback channel needs to be created to bring info from inside of the onion out. This can be achieved in several ways. Using Rx Binding, closure (blocks) or like what we do here, using delegates (protocols).

We use ViewProtocol to communicate back from Presenter to View and OutputInteractorProtocol to communicate back from Interactor to Presenter.

## About the Demo App

It is a simple app which fetches movies and display them in collectionview. User can select Category (Now Playing, Upcoming, Popular, Top Rated). By default Now Playing is selected. When the user taps on a movie, it shows movie detail.

There are in total 2 VIPER modules: MovieList and MovieDetail at this moment

## The UI appearance

![List](https://user-images.githubusercontent.com/21119818/74568078-a4fab480-4f90-11ea-8162-ffbf6482aec3.png)

![Detail](https://user-images.githubusercontent.com/21119818/74568086-a926d200-4f90-11ea-8a11-5ac41d028830.png)


