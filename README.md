# QuickView - NY Times Articles

A Flutter application that displays the most popular articles from the New York Times API.

##  Running the Code

### Setup
1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

**Note:** Currently tested on Android platform only.

**API Key:** Default API key is already configured for testing purposes.

##  Running Tests

### Run All Tests
```bash
flutter test
```

### Run Specific Tests
```bash
flutter test test/core/widget/utils_test.dart
flutter test test/features/article_list_and_details_view/viewmodel/article_viewmodel_test.dart
```

## 📊 Generating Coverage Reports

### Step 1: Generate Coverage Data
```bash
flutter test --coverage
```

### Step 2: Install lcov (one-time setup)
```bash
# macOS
brew install lcov

# Ubuntu/Linux
sudo apt-get install lcov
```

### Step 3: Generate HTML Coverage Report
```bash
genhtml coverage/lcov.info -o coverage/html
```

### Step 4: View Coverage Report
```bash
# macOS
open coverage/html/index.html

# Linux
xdg-open coverage/html/index.html

# Windows
start coverage/html/index.html
```

### Coverage Report Location
```
coverage/
├── lcov.info              # Raw coverage data

```

##  What's Tested
- ViewModel business logic
- Utility functions  

