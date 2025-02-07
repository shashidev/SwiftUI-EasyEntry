🍽️ **Meal App**

Meal App is an **iOS** application built using **SwiftUI** and follows the **Clean Architecture** principles. It allows users to explore various meal categories, view detailed meal information, and seamlessly navigate through a smooth UI experience.

📌 **Features**

1. View different meal categories
2. Browse a list of meals under each category
3. View detailed meal descriptions with images
4. Offline support with caching
5. MVVM architecture with protocol-oriented programming (POP)
6. Combine framework for reactive programming

🏗️ **Architecture**

This project follows Clean Architecture with the following layers:

🔹 **Presentation Layer**

Handles the UI using SwiftUI and manages user interactions through ViewModels following the MVVM pattern.

🔹 **Domain Layer**

Contains the business logic, use cases, and protocols that define interactions between the presentation and data layers.

🔹 **Data Layer**

Responsible for fetching data from APIs or local storage using repositories.

🔧 **Requirements**

      1. Xcode: Version: 15.0+
      2. Swift:Version: 5.9+
      3. iOS Deployment Target: Version: 16.0+

🚀 **Getting Started**

1️⃣ **Clone the Repository**

    git clone https://github.com/yourusername/MealApp.git
    cd MealApp

2️⃣ **Install Dependencies**

The app uses Swift Package Manager (SPM) for dependencies. Open the project in Xcode, and it will fetch the required packages automatically.

3️⃣ **Build & Run**

1. Open MealApp.xcodeproj in Xcode

2. Select an iOS Simulator or your device

3. Press Cmd + R to build and run

🛠️ **Technologies Used**

1. SwiftUI - UI framework for declarative and reactive UI

2. Combine - Handle asynchronous and event-driven code

3. URLSession - Networking

🧪 **Testing**

This project includes:
1. Unit Tests
2. Snapshot Tests

✅ **Run Tests**

    Cmd + U

📊 **Check Code Coverage**

1. Open Xcode
2. Go to Product → Test (Cmd + U)
3. Open Report Navigator (Cmd + 9)
4. Select the latest test run and check Code Coverage

🏎️ **Performance Optimization**

The app tracks **Longest Test Runs** and improves performance by:

1. Reducing expensive UI updates in tests
2. Using dependency injection to speed up unit tests
3. Caching data where applicable to minimize network calls

🤝 **Contributing**

Contributions are welcome! Feel free to open issues or submit pull requests to enhance the project.
