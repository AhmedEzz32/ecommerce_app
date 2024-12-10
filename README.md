# Flutter Mini App

This Flutter mini app demonstrates a simple product listing and details screen using the MVVM architecture and Provider for state management.

## Features

- Fetches product data from an API.
- Displays product image, name, and price on the Home Screen.
- Navigates to a Product Details Screen with an "Add to Cart" button.
- Uses modern design practices and ensures responsiveness.

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

The `fetchProducts` function in the `ProductViewModel` handles the API call and updates the state accordingly. Errors are handled gracefully by displaying an error message if the API call fails.

## UI Design

The UI design follows modern design practices and ensures responsiveness. The Home Screen displays a list of products with their images, names, and prices. The Product Details Screen includes an "Add to Cart" button.

<img width="291" alt="Screenshot 2024-12-10 173754" src="https://github.com/user-attachments/assets/2651b009-1c2c-4a1d-98a1-23c87fd98984">
<img width="257" alt="Screenshot 2024-12-10 173846" src="https://github.com/user-attachments/assets/f802f72d-3e37-488f-b750-0e7c851eb6f9">
<img width="263" alt="Screenshot 2024-12-10 174007" src="https://github.com/user-attachments/assets/b3c97ed6-61a8-4ac0-9001-27879e35cae4">
<img width="721" alt="Screenshot 2024-12-10 174104" src="https://github.com/user-attachments/assets/197e30f7-57f7-421a-bf7a-b091927ec94d">
