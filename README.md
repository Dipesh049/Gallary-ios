# Gallary – Photo Gallary App
This is a photo gallery app built using the MVVM architecture that allows users to log in with Google, view online images, and access them offline.

## Architecture
The app follows the **Model-View-ViewModel (MVVM)** architecture to maintain a clean
separation of concerns, modular code structure, and improved testability.

## Key Components:
* Gallery Screen: Displays a paginated list of images fetched from the API, and allows offline viewing once images are saved.
* Image Pagination: Loads more images as the user scrolls down the gallery
* Image caching using NSCache and disk caching.
* Profile Page: Displays user profile information and includes a logout option.
* API Layer: Handles API requests, response parsing, and data models.

Local Storage Management (Core Data): Manages image persistence offline.
## Summary
| Layer | Responsibility |
|---------------|-------------------------------------------|
| Model | API, UI
| View | view controllers, cell
| ViewModel | Logic, data transformation, bindings
| Api Service  | API calls
| Core Data | Persistent storage


## Third-Party Libraries
* GoogleSignIn
  
