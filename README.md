# 🎵 Spotify Clone - Flutter

A feature-rich **Spotify clone** built with Flutter, showcasing modern app architecture, state management, and Firebase integration. This project demonstrates professional-grade development practices including Clean Architecture, SOLID principles, and advanced UI/UX patterns.

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.5.3-blue?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.9.2-005496?style=for-the-badge&logo=dart)
![Firebase](https://img.shields.io/badge/Firebase-Latest-yellow?style=for-the-badge&logo=firebase)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

</div>

---

## 📋 Table of Contents

- [Features](#-features)
- [Screenshots](#-screenshots)
- [Figma Designs](#-figma-design-files)
- [Demo Video](#-demo-video)
- [Tech Stack](#-tech-stack)
- [Project Architecture](#-project-architecture)
- [Installation](#-installation)
- [Project Structure](#-project-structure)
- [Key Technologies](#-key-technologies)
- [Code Highlights](#-code-highlights)
- [Screen Navigation](#-screen-navigation)

---

## 📸 Screenshots

<div align="center" >

### Welcome & Mode Screens

<div style="display:flex; gap:80px;">
<img src="assets\images\screenshots\splash.png" alt="Splash Screen" width="180" />
  &nbsp;&nbsp;
<img src="assets\images\screenshots\get_started.png" alt="get_started" width="180" />
  &nbsp;&nbsp;
<img src="assets\images\screenshots\chose_mode.png" alt="Chose Mode" width="180" />
</div>

<br>

### Authentication Screens Bright

<div style="display:flex; gap:80px;">
<img src="assets\images\screenshots\enjoy_bright.png" alt="register_sign_in" width="180" />
<img src="assets\images\screenshots\register_bright.png" alt="register Screen" width="180" />
<img src="assets\images\screenshots\sign_in_bright.png" alt="Sign In" width="180" />
</div>

<br>

### Authentication Screens Dark

<div style="display:flex; gap:20px;">
<img src="assets\images\screenshots\enjoy_dark.png" alt="register_sign_in" width="180" />
<img src="assets\images\screenshots\register_dark.png" alt="register Screen" width="180" />
<img src="assets\images\screenshots\sign_in_dark.png" alt="Sign In" width="180" />
</div>

<br>

### UX Bright Screens

<div style="display:flex; gap:20px;">
<img src="assets\images\screenshots\home_bright.png" alt="Home Screen" width="180" />
<img src="assets\images\screenshots\player_bright.png" alt="Player Screen" width="180" />
<img src="assets\images\screenshots\profile_bright.png" alt="Profile Screen" width="180" />
</div>

<br>

### UX Dark Screens

<div style="display:flex; gap:20px;">
<img src="assets\images\screenshots\home_dark.png" alt="Home Screen" width="180" />
<img src="assets\images\screenshots\player_dark.png" alt="Player Screen" width="180" />
<img src="assets\images\screenshots\profile_dark.png" alt="Profile Screen" width="180" />
</div>
</div>

---

## 🎨 Figma Design Files

<div align="center">

### Light Mode Design

[![Figma - Light Mode](https://img.shields.io/badge/Figma-Light+Mode-blue?style=for-the-badge&logo=figma)](https://www.figma.com/design/8aMFldDfUXasRdpfLWaxjW/Spotify-Redesign---Free-Ui-Kit--Light---Community---Copy-?node-id=0-1&p=f&t=w3C0oOFElRQBwD6w-0)

**[👉 View Light Mode Design on Figma](https://www.figma.com/design/8aMFldDfUXasRdpfLWaxjW/Spotify-Redesign---Free-Ui-Kit--Light---Community---Copy-?node-id=0-1&p=f&t=w3C0oOFElRQBwD6w-0)**

<br>

### Dark Mode Design

[![Figma - Dark Mode](https://img.shields.io/badge/Figma-Dark+Mode-1a1a1a?style=for-the-badge&logo=figma&logoColor=white)](https://www.figma.com/design/ZIPue3XKkYO4W5ZsgzGLTk/Spotify-Redesign---Free-Ui-Kit--Dark-Mode---Community-?node-id=1-105&p=f&t=GfvcUQT7qjYap6Qh-0)

**[👉 View Dark Mode Design on Figma](https://www.figma.com/design/ZIPue3XKkYO4W5ZsgzGLTk/Spotify-Redesign---Free-Ui-Kit--Dark-Mode---Community-?node-id=1-105&p=f&t=GfvcUQT7qjYap6Qh-0)**

</div>

---

## 🎬 Demo Video

<div align="center">

[![Spotify Clone Demo](https://img.shields.io/badge/YouTube-Watch+Demo-red?style=for-the-badge&logo=youtube)](https://youtu.be/DvDS03PGHP4)

**[👉 Click here to watch the app in action on YouTube](https://youtu.be/DvDS03PGHP4)**

<a href="https://youtu.be/DvDS03PGHP4" target="_blank">
  <img src="assets\images\screenshots\Spotify_video_thumbnail.png" alt="Spotify Clone YouTube Demo" width="600" style="border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.3);" />
</a>

</div>

---

## ✨ Features

### 🎯 Core Functionality

- ✅ **User Authentication** - Firebase Auth with secure sign-in/registration
- ✅ **Song Discovery** - Browse and search music catalog from Firestore
- ✅ **Music Player** - Full-featured audio playback with progress tracking
- ✅ **Favorites Management** - Add/remove favorite songs with persistent storage
- ✅ **Theme Support** - Light/Dark mode with hydrated state persistence
- ✅ **Responsive Design** - Adaptive UI across all device sizes using ScreenUtil

### 🎨 User Experience

- 📱 Device-responsive layouts (mobile-first design)
- 🎯 Smooth animations and transitions
- 🎨 Custom UI components with modern design
- 📲 Clean, intuitive navigation flow
- 💾 State persistence across app restarts

### 🔧 Technical Excellence

- 🏗️ Clean Architecture with clear separation of concerns
- 📦 Dependency Injection with automatic code generation
- ⚡ Efficient state management with Cubits
- 🔄 Functional error handling with Result type pattern
- 📸 Cached image loading for optimal performance
- 🎵 Seamless audio streaming

---

## 🛠 Tech Stack

### **Core Framework**

| Technology | Version | Purpose                     |
| ---------- | ------- | --------------------------- |
| Flutter    | 3.6.1+  | Cross-platform UI framework |
| Dart       | 3.6.1+  | Programming language        |

### **State Management & Architecture**

| Package                | Version | Purpose                                     |
| ---------------------- | ------- | ------------------------------------------- |
| `flutter_bloc`         | 9.1.1   | State management pattern                    |
| `injectable`           | 2.6.0   | Dependency injection (DI) annotations       |
| `injectable_generator` | 2.9.1   | Code generation for DI                      |
| `get_it`               | 9.0.5   | Service locator for DI                      |
| `dartz`                | 0.10.1  | Functional programming (Either/Result type) |

### **Backend & Database**

| Package           | Version | Purpose                 |
| ----------------- | ------- | ----------------------- |
| `firebase_core`   | 4.2.0   | Firebase initialization |
| `firebase_auth`   | 6.1.1   | User authentication     |
| `cloud_firestore` | 6.1.0   | Cloud database          |

### **Media & Audio**

| Package                 | Version | Purpose                      |
| ----------------------- | ------- | ---------------------------- |
| `just_audio`            | 0.10.5  | Audio playback engine        |
| `flutter_cache_manager` | 3.4.1   | Cache management             |
| `cached_network_image`  | 3.4.1   | Image caching & optimization |

### **UI & Styling**

| Package                    | Version | Purpose                   |
| -------------------------- | ------- | ------------------------- |
| `flutter_screenutil`       | 5.9.3   | Responsive design scaling |
| `flutter_svg`              | 2.2.0   | SVG rendering support     |
| `device_preview`           | 1.3.1   | Multi-device preview      |
| `loading_animation_widget` | 1.3.0   | Loading animations        |

### **State Persistence**

| Package         | Version | Purpose                |
| --------------- | ------- | ---------------------- |
| `hydrated_bloc` | 10.1.1  | Bloc state persistence |
| `path_provider` | 2.1.5   | Device storage paths   |

### **Development Tools**

| Package         | Version | Purpose                |
| --------------- | ------- | ---------------------- |
| `build_runner`  | 2.10.4  | Code generation runner |
| `flutter_lints` | 5.0.0   | Linting rules          |

### **Custom Fonts**

- **Satoshi** - Primary font (weights: 300, 400, 500, 700, 900)
- **FontAwesome 6 Pro** - Icon fonts (Solid, Regular, Light, Thin, Brands)

---

## 🏗 Project Architecture

### **Clean Architecture Pattern**

The project follows **Clean Architecture** principles with clear separation into layers:

```
lib/
├── common/                    # Shared utilities & errors
│   ├── errors/               # Failure handling
│   ├── helpers/              # Helper functions
│   └── widgets/              # Reusable UI components
│
├── core/                      # Core application setup
│   ├── configs/              # Theme & assets configuration
│   ├── localization/         # i18n & localization
│   └── usecases/             # Abstract use case contracts
│
├── src/                       # Main application source
│   ├── data/                 # Data layer (API, Models, Repositories)
│   │   ├── api/              # External APIs (Auth, Songs)
│   │   ├── models/           # Data models with serialization
│   │   └── repository/       # Repository implementations
│   │
│   ├── logic/                # Domain layer (Entities, Contracts)
│   │   ├── entities/         # Business entities
│   │   ├── repository/       # Repository interfaces
│   │   └── usecases/         # Business logic use cases
│   │
│   └── presentation/         # Presentation layer (UI, State)
│       ├── authentication/   # Auth screens & cubits
│       ├── chose_mode/       # Theme selection
│       ├── home/             # Home screen & song list
│       ├── profile/          # User profile
│       ├── song/             # Song player
│       ├── splash/           # Splash screen
│       └── welcome/          # Welcome screen
└── main.dart                 # App entry point
```

### **Architecture Layers**

#### **1. Data Layer** 📊

- **APIs**: Fetch data from Firebase (Auth, Firestore)
- **Models**: Map API responses to Dart objects
- **Repositories**: Implement repository contracts

#### **2. Domain/Logic Layer** 🧠

- **Entities**: Pure business models (independent of frameworks)
- **Repositories**: Define contracts for data access
- **Use Cases**: Encapsulate business logic operations

#### **3. Presentation Layer** 🎨

- **Cubits**: State management using `flutter_bloc`
- **Pages**: Full-screen widgets
- **Widgets**: Reusable UI components

### **Key Design Patterns**

#### **1. Dependency Injection (DI)**

```dart
// Automatic registration via @injectable annotations
@injectable
class AuthRepositoryImp extends AuthRepository { }

// Usage with GetIt
final authRepo = getIt<AuthRepository>();
```

#### **2. Result Type Pattern (Either)**

```dart
// Functional error handling
Either<Failure, List<Song>> result = await fetchSongsUsecase();

result.fold(
  (failure) => print('Error: ${failure.message}'),
  (songs) => print('Success: ${songs.length} songs'),
);
```

#### **3. State Management with Cubits**

```dart
class SongsCubit extends Cubit<SongsState> {
  SongsCubit() : super(FetchingSongs());

  void fetchSongs() async {
    final result = await getIt<FetchsongsUsecase>().call();
    result.fold(
      (failure) => emit(FetchingSongsFailed(failure: failure)),
      (songs) => emit(FetchingSongSuccess(songs: songs)),
    );
  }
}
```

#### **4. Audio Playback Management**

```dart
class SongPlayerCubit extends Cubit<SongPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> loadSong(String url) async {
    await audioPlayer.setUrl(url);
    emit(SongPlayerLoaded());
  }
}
```

---

## 📦 Installation

### **Prerequisites**

- Flutter SDK (3.6.1+)
- Dart SDK (3.6.1+)
- Firebase account (for backend)
- Android Studio / Xcode (for platform-specific setup)

### **Setup Steps**

1. **Clone the repository**

   ```bash
   git clone https://github.com/KhezamiTaha/Spotify-Clone.git
   cd Spotify-Clone
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate dependency injection code**

   ```bash
   dart run build_runner build
   ```

4. **Configure Firebase**

   - Create a Firebase project
   - Download `google-services.json` (Android)
   - Download `GoogleService-Info.plist` (iOS)
   - Place them in respective platform directories

5. **Run the app**
   ```bash
   flutter run
   ```

---

## 📂 Project Structure

### **Detailed Breakdown**

```
lib/
├── main.dart
│   ├── Firebase initialization
│   ├── Hydrated Bloc setup for state persistence
│   ├── Device Preview configuration
│   ├── Screen Util for responsive design
│   └── Multi-BLoC provider setup
│
├── injection_container.dart
│   └── Service Locator configuration (GetIt + Injectable)
│
├── common/
│   ├── errors/
│   │   └── failure.dart          # Error handling abstraction
│   ├── helpers/
│   │   └── is_dark_mode.dart     # Theme helper utilities
│   └── widgets/
│       └── Custom reusable components
│
├── core/
│   ├── configs/
│   │   ├── assets/
│   │   │   ├── app_images.dart
│   │   │   └── app_vectors.dart
│   │   └── theme/
│   │       ├── app_colors.dart    # Color palette (Light/Dark)
│   │       └── app_theme.dart     # ThemeData configuration
│   ├── localization/              # i18n setup
│   └── usecases/
│       └── abstract_usecase.dart  # Use case contract
│
└── src/
    ├── data/
    │   ├── api/
    │   │   ├── auth/
    │   │   │   └── auth_api.dart         # Firebase Auth integration
    │   │   └── songs/
    │   │       └── songs_api.dart        # Songs CRUD operations
    │   ├── models/
    │   │   ├── auth/
    │   │   │   └── user_model.dart       # User data model
    │   │   └── songs/
    │   │       └── song_model.dart       # Song data model
    │   └── repository/
    │       ├── auth/
    │       │   └── auth_repository_imp.dart
    │       └── songs/
    │           └── songs_repository_imp.dart
    │
    ├── logic/
    │   ├── entities/
    │   │   ├── auth/
    │   │   │   └── user.dart             # Pure User entity
    │   │   └── songs/
    │   │       └── song.dart             # Pure Song entity
    │   ├── repository/
    │   │   ├── auth/
    │   │   │   └── auth_repository.dart  # Auth contract
    │   │   └── songs/
    │   │       └── songs_repository.dart # Songs contract
    │   └── usecases/
    │       ├── auth/
    │       │   ├── register_usecase.dart
    │       │   └── signin_usecase.dart
    │       └── songs/
    │           ├── fetch_songs_usecase.dart
    │           ├── fetch_favorite_songs_usecase.dart
    │           └── toggle_favorite_song_usecase.dart
    │
    └── presentation/
        ├── authentication/          # Auth flow
        │   ├── cubits/
        │   ├── pages/
        │   │   ├── register_screen.dart
        │   │   ├── signin_screen.dart
        │   │   └── register_signin_screen.dart
        │   └── widgets/
        │
        ├── chose_mode/              # Theme selection
        │   ├── cubits/
        │   │   └── theme_cubit.dart  # Light/Dark mode toggle
        │   ├── pages/
        │   │   └── chose_mode_screen.dart
        │   └── widgets/
        │
        ├── home/                    # Main song browsing
        │   ├── cubits/
        │   │   ├── songs_cubit.dart         # Fetch & display songs
        │   │   └── favorite_songs_cubit.dart # Manage favorites
        │   ├── pages/
        │   │   └── homepage.dart
        │   └── widgets/
        │       ├── container_box_decoration.dart
        │       └── custom_bottom_navbar.dart
        │
        ├── song/                    # Music player
        │   ├── cubits/
        │   │   ├── song_player_cubit.dart
        │   │   └── song_player_state.dart
        │   ├── pages/
        │   │   └── song_player_screen.dart
        │   └── widgets/
        │
        ├── profile/                 # User profile
        │   ├── cubits/
        │   ├── pages/
        │   │   └── profile_screen.dart
        │   └── widgets/
        │
        ├── splash/                  # Initial loading
        │   ├── cubits/
        │   ├── screens/
        │   │   └── splash_screen.dart
        │   └── widgets/
        │
        ├── welcome/                 # Onboarding
        │   ├── cubits/
        │   ├── pages/
        │   │   └── welcome_screen.dart
        │   └── widgets/
        │
        └── template/                # Shared templates
            ├── cubits/
            ├── pages/
            └── widgets/
```

---

## 🎯 Key Technologies Explained

### **1. Flutter BLoC & Cubits**

A lightweight state management solution derived from the BLoC pattern. Cubits simplify state management without events.

**Why Cubits?**

- ✅ Simpler than full BLoC pattern
- ✅ Less boilerplate code
- ✅ Perfect for small to medium apps
- ✅ Great for learning state management

### **2. Firebase Integration**

- **Firebase Auth**: Secure user authentication
- **Cloud Firestore**: Real-time database for songs and metadata

### **3. Dependency Injection (Injectable)**

Automatic code generation for service registration using `@injectable` annotations.

**Benefits:**

- 🔄 Loose coupling between modules
- 🧪 Easier testing with mock implementations
- 📦 Centralized dependency management
- 🚀 Scalable architecture

### **4. Functional Error Handling (Dartz)**

Using `Either<Failure, Success>` type for type-safe error handling.

```dart
// No null checks needed!
final result = await repository.fetchSongs();
result.fold(
  (failure) => emit(Error(failure)),      // Left - Failure
  (songs) => emit(Success(songs)),         // Right - Success
);
```

### **5. Responsive Design (ScreenUtil)**

Automatic scaling of UI elements based on device screen size.

```dart
// Automatically scales across devices
Text('Hello', style: TextStyle(fontSize: 16.sp))  // scales by screen
SizedBox(height: 20.h)                             // responsive height
EdgeInsets.all(16.w)                               // responsive padding
```

### **6. State Persistence (Hydrated Bloc)**

Automatically saves and restores Bloc state from device storage.

```dart
// Theme preference persisted even after app restart
class ThemeCubit extends HydratedCubit<ThemeMode> {
  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    return ThemeMode.values[json['theme'] ?? 0];
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {'theme': state.index};
  }
}
```

### **7. Audio Management (Just Audio)**

Professional audio playback with position, duration, and state tracking.

**Features:**

- 🎵 Stream-based position and duration updates
- ⏯️ Play, pause, resume, seek operations
- 🔊 Volume control
- ⏱️ Real-time playback metrics

---

## 💡 Code Highlights

### **Clean Use Case Implementation**

```dart
class FetchsongsUsecase extends UseCase<List<SongModel>, NoParams> {
  final SongsRepository songsRepository;

  FetchsongsUsecase({required this.songsRepository});

  @override
  Future<Either<Failure, List<SongModel>>> call(NoParams params) async {
    return await songsRepository.fetchSongs();
  }
}
```

### **State Management with Cubits**

```dart
class SongsState {}
class FetchingSongs extends SongsState {}
class FetchingSongSuccess extends SongsState {
  final List<SongModel> songs;
  FetchingSongSuccess({required this.songs});
}
class FetchingSongsFailed extends SongsState {
  final Failure failure;
  FetchingSongsFailed({required this.failure});
}

class SongsCubit extends Cubit<SongsState> {
  SongsCubit() : super(FetchingSongs());

  void fetchSongs() async {
    final result = await getIt<FetchsongsUsecase>().call();
    result.fold(
      (failure) => emit(FetchingSongsFailed(failure: failure)),
      (songs) => emit(FetchingSongSuccess(songs: songs)),
    );
  }
}
```

### **Firebase Authentication**

```dart
@injectable
class AuthApiImp extends AuthApi {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserModel> signin({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebaseUser(userCredential.user!);
    } catch (e) {
      throw Exception(e);
    }
  }
}
```

### **Repository Pattern**

```dart
@injectable
class SongsRepositoryImp extends SongsRepository {
  final SongsApi songsApi;

  SongsRepositoryImp({required this.songsApi});

  @override
  Future<Either<Failure, List<SongModel>>> fetchSongs() async {
    try {
      final songs = await songsApi.fetchSongs();
      return Right(songs);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
```

### **Audio Player Implementation**

```dart
class SongPlayerCubit extends Cubit<SongPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    // Stream-based position updates
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      if (!isClosed) emit(SongPlayerLoaded());
    });

    // Stream-based duration updates
    audioPlayer.durationStream.listen((duration) {
      if (duration != null) songDuration = duration;
    });
  }

  Future<void> loadSong(String url) async {
    try {
      await audioPlayer.setUrl(url);
      if (!isClosed) emit(SongPlayerLoaded());
    } catch (e) {
      if (!isClosed) emit(SongPlayerError());
    }
  }

  Future<void> playSong() async => await audioPlayer.play();
  Future<void> pauseSong() async => await audioPlayer.pause();
  Future<void> seekSong(Duration duration) async =>
      await audioPlayer.seek(duration);
}
```

---

## 📱 Screen Navigation

### **User Journey**

```
Splash Screen
      ↓
Welcome Screen (Onboarding)
      ↓
Authentication (Sign In / Register)
      ↓
Theme Selection (Light / Dark)
      ↓
Home Screen (Song List)
      ↓ (Select Song)
      ↓
Song Player Screen
      ↓
Profile Screen (View/Manage Favorites)
```

### **Key Screens**

| Screen             | Purpose               | Cubits                         |
| ------------------ | --------------------- | ------------------------------ |
| **Splash**         | App initialization    | -                              |
| **Welcome**        | Onboarding UX         | -                              |
| **Authentication** | Sign In / Register    | AuthCubit                      |
| **Theme Mode**     | Light/Dark toggle     | ThemeCubit                     |
| **Home**           | Browse songs          | SongsCubit, FavoriteSongsCubit |
| **Song Player**    | Audio playback        | SongPlayerCubit                |
| **Profile**        | User info & favorites | ProfileCubit                   |

---

## 🎨 Design System

### **Color Palette**

- **Primary**: Spotify Green `#1DB954`
- **Light Background**: `#FFFBFE`
- **Dark Background**: `#0F0E0E`
- **Accent Colors**: Custom gradient support

### **Typography**

- **Primary Font**: Satoshi (Regular, Medium, Bold, Black)
- **Icon Fonts**: FontAwesome 6 Pro (complete icon set)

### **Responsive Breakpoints**

- **Design Size**: 390x844 (Mobile-first)
- **Scaling**: Automatic via ScreenUtil
- **Min Text Adapt**: Enabled for accessibility

---

## 🚀 Performance Optimizations

### **Image Caching**

```dart
CachedNetworkImage(
  imageUrl: song.coverImageUrl,
  placeholder: (context, url) => LoadingAnimationWidget.pulse(...),
  errorWidget: (context, url, error) => Icon(Icons.error),
)
```

### **State Persistence**

- Reduces API calls on app restart
- Improves user experience with instant app load
- Minimal storage footprint

### **Audio Streaming**

- Efficient buffering with Just Audio
- Progressive download support
- Battery-optimized playback

---

## 📊 Skills Showcased

### **Architecture & Design Patterns**

- ✅ Clean Architecture (3-layer pattern)
- ✅ Repository Pattern
- ✅ Dependency Injection
- ✅ BLoC/Cubit State Management
- ✅ Functional Error Handling (Either type)

### **Advanced Dart/Flutter**

- ✅ Stream-based reactive programming
- ✅ Async/await patterns
- ✅ Type-safe error handling
- ✅ Code generation (Build Runner)
- ✅ Custom theme management
- ✅ Responsive UI design

### **Backend Integration**

- ✅ Firebase Authentication
- ✅ Cloud Firestore (real-time database)
- ✅ API integration patterns
- ✅ Error handling & retry logic

### **UI/UX Implementation**

- ✅ Custom animations
- ✅ Responsive layouts
- ✅ Dark/Light theme support
- ✅ Bottom navigation
- ✅ Custom widgets
- ✅ Loading states

### **Code Quality**

- ✅ SOLID principles
- ✅ DRY (Don't Repeat Yourself)
- ✅ KISS (Keep It Simple)
- ✅ Code organization
- ✅ Linting & best practices

---

## 🔮 Future Enhancements

- [ ] Playlist creation and management
- [ ] Search functionality with filters
- [ ] Offline mode with local caching
- [ ] Social features (sharing, recommendations)
- [ ] Advanced audio controls (equalizer, volume boost)
- [ ] Analytics integration
- [ ] Push notifications
- [ ] Unit and widget tests

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 👤 Author

**Khezami Taha**

- GitHub: [@KhezamiTaha](https://github.com/KhezamiTaha)
- Repository: [Spotify-Clone](https://github.com/KhezamiTaha/Spotify-Clone)

---

## 🙏 Acknowledgments

- Flutter & Dart teams for the amazing framework
- Firebase for backend services
- Open-source community for excellent packages
- Design inspiration from Spotify

---

<div align="center">

**Built with ❤️ using Flutter**

[⬆ Back to top](#-spotify-clone---flutter)

</div>
