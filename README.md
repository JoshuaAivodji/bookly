
# Bookly 📚

Bookly - Discover and get book recommendations powered by smart AI tailored to your reading preferences.

---

## 🚀 Table of Contents

### **Part 1: Setting up Architecture and Basic Features**
1. **Application Architecture**
   - Clean Architecture
   - State Management with Flutter Bloc
   - Dependency Injection with GetIt
   - API Communication using Retrofit and Dio
   - Local Storage with Hive

2. **Book Display Features**
   - Fetching books using Google Books API
   - Paginated book display with `PagedListView`
   - Error handling and loading states

3. **Search Functionality**
   - Search for books by title, author, or genre

4. **Favorites Management**
   - Add or remove books from favorites
   - Persisting favorites using Hive
   - Dynamic UI updates

---

### **Part 2: Book Details and Recommendations**
1. **Book Details Page**
   - Display detailed information (title, author, description, etc.)
   - Button to add/remove book from favorites
   - Display of book cover

2. **Similar Book Recommendations**
   - Display similar books based on the current book
   - Using Google Books API for recommendations

3. **Personalized Recommendation Space**
   - Recommendations based on user preferences
   - Using favorite history to refine suggestions

---

### **Part 3: AI-Powered Recommendations Integration**
1. **TensorFlow Lite Integration**
   - Integrating TensorFlow Lite for content analysis
   - AI model for content-based book recommendations

2. **Preference-Based Recommendations**
   - Analyzing favorite books to understand user preferences
   - Personalized recommendations by genres, authors, etc.

3. **Continuous AI Model Improvement**
   - Collecting anonymized data to improve recommendations
   - Periodic updates of the AI model

---

## 🚀 Getting Started

This project is built with **Flutter 3.29.0** and follows the **Clean Architecture** pattern using:
- **Flutter Bloc** for state management.
- **GetIt** for dependency injection.
- **Retrofit & Dio** for API communication.
- **Hive** for local storage and caching.

---

## 📚 About
Bookly is a Flutter application that helps users discover and get book recommendations powered by smart AI tailored to their reading preferences. It uses the **Google Books API** to provide a wide range of books.

---

## 📸 Screenshots
Here is a preview of the app:
<img src="./assets/screenshoot/screen-1.jpg" alt="List of books not added to favorites Screen" width="250">
<img src="./assets/screenshoot/screen-2.jpg" alt="List of books with bookmarks Screen" width="250">


---

## ✨ Features
- Discover a wide range of books using Google Books API.
- Get book recommendations powered by smart AI.
- Search for books by title, author, or genre.
- Save your favorite books for later.
- Personalized recommendations based on user preferences.

---

## 🛠 Tech Stack
- **Flutter 3.29.0** - Frontend UI
- **Flutter Bloc** - State management
- **GetIt** - Dependency Injection
- **Dio + Retrofit** - Networking
- **Hive** - Local Storage
- **Google Books API** - Book data source
- **TensorFlow Lite** - AI Recommendations

---

## 📦 Installation

1. **Clone the repository**:
```bash
git clone https://github.com/JoshuaAivodji/bookly.git
```

2. **Navigate to the project directory**:
```bash
cd bookly
```

3. **Install the dependencies**:
```bash
flutter pub get
```

4. **Run the application**:
```bash
flutter run
```

---

## 🤝 Contributing
Contributions are welcome! Feel free to open issues or submit pull requests to help improve this project.

---

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 📧 Contact
For any inquiries or feedback, reach out at [joshuaaivodji@janako.tech].

---

## 🚀 Future Enhancements
- Book reviews and ratings
- User authentication and personalized reading lists
- Integration with other book APIs for more content variety
- Offline mode for reading without an internet connection
