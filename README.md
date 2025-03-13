# Flutter Mini App

This Flutter mini app demonstrates a simple product listing and details screen using the MVVM architecture and Provider for state management.

## Features

-Authentication: Users can sign in using Google or email/password. Profile information such as the profile image (with a cropping option), first name, and last name can be edited.

-Home Screen: Displays products fetched from an API with their images, names, and prices. A search bar allows users to filter products.

-Navigation: Custom drawer includes the user's image, name, and an option to edit the profile. The drawer also includes options to log out and switch between Arabic and English localization.

-Product Details: Clicking on a product navigates to a Product Details Screen displaying the product description.

-Cart: Users can add products to their cart, which displays the total price. A Stripe payment method is integrated for processing payments.

-App Bar: Includes a search bar and a cart icon for easy navigation.

## Architecture and State Management

### Architecture

The app follows the MVVM (Model-View-ViewModel) architecture pattern. This pattern helps in separating the UI (View) from the business logic (ViewModel) and the data (Model). 

- **Model**: Represents the data and business logic of the app. In this app, the `Product` model represents the product data fetched from the API.
- **View**: Represents the UI of the app. The `HomeScreen` and `ProductDetailsScreen` are the views in this app.
- **ViewModel**: Acts as a bridge between the Model and the View. It holds the app's state and business logic. The `ProductViewModel` is responsible for fetching product data and managing the state of the product list.

### State Management

The app uses the Provider package for state management. Provider is a recommended state management solution in Flutter that allows you to manage and propagate state efficiently.

- **Provider**: The `ProductViewModel` is provided to the widget tree using the `ChangeNotifierProvider`. This allows the views to listen to changes in the ViewModel and rebuild accordingly.

## API Handling

The `fetchProducts` function in the `ProductViewModel` handles fetching product data from Firebase and updates the app state. Errors are gracefully handled with error messages displayed if the API call fails.

## UI Design

The UI design follows modern design practices and ensures responsiveness. The Home Screen displays a list of products with their images, names, and prices. The Product Details Screen includes an "Add to Cart" button.

<img width="291" alt="Screenshot 2024-12-10 173754" src="https://github.com/user-attachments/assets/48070ff4-18f3-46b0-a26f-16786e24165a">
<img width="257" alt="Screenshot 2024-12-10 173846" src="https://github.com/user-attachments/assets/f802f72d-3e37-488f-b750-0e7c851eb6f9">
<img width="263" alt="Screenshot 2024-12-10 174007" src="https://github.com/user-attachments/assets/b3c97ed6-61a8-4ac0-9001-27879e35cae4">
<img width="721" alt="Screenshot 2024-12-10 174104" src="https://github.com/user-attachments/assets/197e30f7-57f7-421a-bf7a-b091927ec94d">
