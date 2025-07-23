# Flutter E-commerce API Practice App

A comprehensive Flutter application demonstrating API integration, state management, and local database operations with a focus on e-commerce functionality.

## 📱 Features

### Core E-commerce Features
- **Product Catalog**: Browse products fetched from Fake Store API
- **Shopping Cart**: Add/remove items with persistent local storage
- **Cart Management**: Real-time cart counter and total price calculation
- **Responsive Design**: Grid layout with product images and details

### API Integration Examples
- **GET Requests**: Fetch products, users, comments, and photos
- **POST Requests**: User authentication and login functionality
- **Image Upload**: Upload images to server using multipart requests
- **Complex JSON Parsing**: Handle nested JSON responses

### State Management
- **Provider Pattern**: Centralized state management for cart operations
- **Real-time Updates**: Automatic UI updates when cart changes
- **Persistent Storage**: SQLite database for cart persistence

## 🛠️ Tech Stack

- **Framework**: Flutter
- **State Management**: Provider
- **Local Database**: SQLite (sqflite)
- **HTTP Client**: http package
- **Image Handling**: image_picker
- **UI Components**: Custom widgets with Material Design

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
  sqflite: ^2.3.0
  http: ^1.1.0
  path: ^1.8.3
  badges: ^3.1.2
  image_picker: ^1.0.4
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- Android Emulator or physical device

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter-ecommerce-practice
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── Ecommerce/
│   ├── cartModel.dart          # Cart data model
│   ├── cartProvider.dart       # Cart state management
│   └── dbHelper.dart          # SQLite database operations
├── UI/
│   ├── cart_UI.dart           # Shopping cart interface
│   ├── exomerce.dart          # Main e-commerce screen
│   └── main.dart              # App entry point
├── practice/
│   ├── PostApi.dart           # Login API implementation
│   ├── complexApi.dart        # Complex JSON parsing example
│   ├── home.dart              # Comments API example
│   ├── imageuploadonserver.dart # Image upload functionality
│   ├── practice.dart          # Photos API example
│   └── pro.dart               # Complex model example
└── Models/
    ├── cs.dart                # E-commerce product model
    ├── apimodels.dart         # Comment model
    ├── practice.dart          # Photo model
    └── complexModel.dart      # Complex nested model
```

## 🔧 Key Components

### Cart Management System
- **CartModel**: Data structure for cart items
- **CartProvider**: State management with Provider pattern
- **DbHelper**: SQLite operations for persistent storage

### API Integration Examples
- **Product Fetching**: Fake Store API integration
- **User Authentication**: Login with form validation
- **Image Upload**: Multipart form data handling
- **Complex JSON**: Nested object parsing

## 🌐 API Endpoints Used

- **Products**: `https://fakestoreapi.com/products`
- **Login**: `https://reqres.in/api/login`
- **Users**: `https://jsonplaceholder.typicode.com/users`
- **Comments**: `https://jsonplaceholder.typicode.com/comments`
- **Photos**: `https://jsonplaceholder.typicode.com/photos`

## 💾 Database Schema

### Cart Table
```sql
CREATE TABLE cart(
  id INTEGER PRIMARY KEY AUTOINCREMENT, 
  productId TEXT UNIQUE,
  productName TEXT, 
  productPrice INTEGER,
  quantity INTEGER,
  image TEXT
)
```

## 🎯 Key Learning Points

### State Management
- Provider pattern implementation
- Real-time UI updates
- State persistence across app sessions

### Database Operations
- SQLite integration in Flutter
- CRUD operations
- Data modeling and relationships

### API Integration
- RESTful API consumption
- JSON serialization/deserialization
- Error handling and loading states
- File upload with multipart requests

### UI/UX Design
- Responsive grid layouts
- Custom widgets and reusable components
- Material Design principles
- Loading states and user feedback

## 🔍 Code Highlights

### Cart State Management
```dart
class CartProvider with ChangeNotifier {
  int _counter = 0;
  double _totalPrice = 0.0;
  
  void incrementCounter() {
    _counter++;
    notifyListeners();
  }
  
  Future<void> updateTotalFromDb() async {
    List<Cart> items = await db.getCart();
    _totalPrice = items.fold(0.0, (sum, item) => sum + (item.productPrice ?? 0));
    notifyListeners();
  }
}
```

### Database Operations
```dart
Future<Cart> insert(Cart cart) async {
  Database? db = await instance.database;
  await db!.insert('cart', cart.toMap());
  return cart;
}

Future<List<Cart>> getCart() async {
  Database? db = await instance.database;
  final List<Map<String,dynamic>> queryResult = await db!.query('cart');
  return queryResult.map((e) => Cart.fromMap(e)).toList();
}
```

## 🚧 Future Enhancements

- [ ] User authentication with JWT tokens
- [ ] Product search and filtering
- [ ] Order history and tracking
- [ ] Payment gateway integration
- [ ] Push notifications
- [ ] Offline mode support
- [ ] Product reviews and ratings
- [ ] Wishlist functionality

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support and questions, please open an issue in the repository or contact the development team.

---

**Happy Coding! 🚀**
