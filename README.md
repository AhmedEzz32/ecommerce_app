# E-commerce App

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

<img width="250" alt="Screenshot 2024-12-10 173754" src="https://github.com/user-attachments/assets/48070ff4-18f3-46b0-a26f-16786e24165a">
<img width="250" alt="Screenshot 2024-12-10 173846" src="https://github.com/user-attachments/assets/a2bc83ca-72c3-467e-8c93-4dc6c074fee8">
<img width="250" alt="Screenshot 2024-12-10 174007" src="https://github.com/user-attachments/assets/a12cb75c-55db-475d-8ae7-46442c022178">
<img width="250" alt="Screenshot 2024-12-10 174104" src="https://github.com/user-attachments/assets/0fd2b0d1-ea01-4c5d-811e-b2caf069a5a8">
<img width="250" alt="Screenshot 2024-12-10 174104" src="https://github.com/user-attachments/assets/b334c617-b11a-49e9-8d40-a2ddf152de95">
<img width="250" alt="Screenshot 2024-12-10 174104" src="https://github.com/user-attachments/assets/69f014da-5067-427e-b96a-6305e56b239d">
<img width="250" alt="Screenshot 2024-12-10 174104" src="https://github.com/user-attachments/assets/6137a19d-881e-4c81-8667-0b6642177c4c">
<img width="250" alt="Screenshot 2024-12-10 174104" src="https://github.com/user-attachments/assets/829d3212-a339-4815-aaf7-42ff0759a6b5">
<img width="250" alt="Screenshot 2024-12-10 174104" src="https://github.com/user-attachments/assets/179dcfb9-50b2-4c62-8b07-0f1d23463948">
