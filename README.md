# Civion - Civil Service MCQ App

A modern, professional MCQ (Multiple Choice Questions) application designed for Nepali Civil Service exam preparation. Built with Flutter and featuring a beautiful dark theme with glass-morphism design.

## 🎯 Features

### ✨ Modern UI/UX
- **Dark Theme**: Professional dark theme with cyan accents
- **Glass-morphism Design**: Modern card-based layout with transparency effects
- **Responsive Design**: Optimized for both mobile and web platforms
- **Professional Branding**: Custom Civion logo and consistent visual identity

### 📚 Comprehensive Question Sets
- **31 Question Sets**: Extensive collection of practice questions
- **Multiple Categories**: Covering various civil service exam topics
- **Nepali Language Support**: Questions in both Nepali and English
- **Detailed Explanations**: Comprehensive explanations for each answer

### 🧠 Smart Quiz System
- **Flexible Submission**: Submit quiz even if not all questions are answered
- **Progress Tracking**: Visual progress indicator throughout the quiz
- **Score Calculation**: Accurate scoring based on attempted questions
- **Result Analysis**: Detailed results with percentage and performance metrics

### 🎨 Professional Design
- **Custom Logo**: Beautiful Civion branding throughout the app
- **Modern Typography**: Clean, readable fonts with proper spacing
- **Smooth Animations**: Fluid transitions and interactions
- **Intuitive Navigation**: Easy-to-use interface with clear visual hierarchy

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Dimanjan/civionnew.git
   cd civionnew
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For web development
   flutter run -d chrome
   
   # For Android
   flutter run -d android
   ```

## 📱 Platform Support

- ✅ **Android**: Fully supported with release builds
- ✅ **Web**: Responsive web application
- ✅ **iOS**: Compatible (not actively developed)

## ��️ Project Structure

```
civion/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── models/                   # Data models
│   │   ├── question_set.dart
│   │   └── question.dart
│   └── screens/                  # UI screens
│       ├── home_screen.dart      # Main menu with question sets
│       └── quiz_screen.dart      # Quiz interface
├── assets/
│   ├── civion512.jpg            # App logo
│   └── data/                    # Question sets (JSON files)
│       ├── question_set_1.json
│       ├── question_set_2.json
│       └── ... (up to 31)
├── android/                     # Android-specific files
└── pubspec.yaml                 # Dependencies and configuration
```

## 🎨 Design System

### Color Palette
- **Primary**: Cyan (#00BCD4)
- **Secondary**: Dark Cyan (#0097A7)
- **Background**: Dark Blue-Grey (#0A0A0A, #1A1A2E, #16213E)
- **Text**: White with various opacity levels
- **Accent**: Glass-morphism effects with transparency

### Typography
- **Headings**: Bold, spaced letters for impact
- **Body Text**: Clean, readable fonts
- **Labels**: Consistent sizing and weight

## 📊 Question Sets

The app includes 31 comprehensive question sets covering:

1. **General Knowledge & Aptitude Test (Nepal)**
2. **Constitutional Law**
3. **Public Administration**
4. **Economics**
5. **Nepal's History & Culture**
6. **Current Affairs**
7. **And many more...**

Each question set contains multiple-choice questions with:
- Question text (Nepali/English)
- Four answer options
- Correct answer indicator
- Detailed explanation
- Category classification

## 🔧 Development

### Building for Release

1. **Android App Bundle (AAB)**
   ```bash
   flutter build appbundle --release
   ```
   Output: `build/app/outputs/bundle/release/app-release.aab`

2. **Web Build**
   ```bash
   flutter build web --release
   ```
   Output: `build/web/`

### Signing Configuration

The app is configured with proper release signing:
- **Keystore**: `upload-keystore.jks`
- **Key Properties**: `android/key.properties`
- **Certificate**: Valid until 2053

## 📈 Recent Updates

### Version 2.0 (Latest)
- ✨ **Professional Civion Branding**: Custom logo and consistent visual identity
- 🎨 **Modern Dark Theme**: Glass-morphism design with cyan accents
- 📱 **31 Question Sets**: Comprehensive collection of practice questions
- 🧠 **Flexible Quiz System**: Submit anytime, not forced to answer all questions
- 🐛 **UI Improvements**: Fixed overlapping text and improved spacing
- 🚀 **Performance Optimizations**: Better loading and smoother animations

### Previous Versions
- Initial release with basic MCQ functionality
- Question set expansion
- UI/UX improvements
- Bug fixes and optimizations

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Dimanjan**
- GitHub: [@Dimanjan](https://github.com/Dimanjan)
- Project: [Civion App](https://github.com/Dimanjan/civionnew)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design for design inspiration
- Nepali Civil Service Commission for exam structure reference
- All contributors and testers

## 📞 Support

For support, feature requests, or bug reports, please open an issue on GitHub.

---

**Civion** - Empowering Civil Service Aspirants with Modern Technology 🚀
