# Auth Flow App Documentation

This project is a comprehensive Flutter authentication system built using **Clean Architecture** principles and powered by **Supabase**.

## 🚀 Key Features
- **Email & Password Authentication**: Signup, Login, and Password Reset.
- **Social Authentication**: Google, Github, Apple login via Supabase.
- **Phone Authentication**: SMS-based OTP verification.
- **Session Management**: Persistent login states.
- **Profile Management**: Handling user profile data.
- **Forgot Password Flow**: Step-by-step OTP-based password recovery.

## 🏗️ Architecture: Clean Architecture
The project follows a modular structure divided into three main layers:

### 1. Core Layer (`lib/core/`)
Contains app-wide utilities and configurations:
- **`di/`**: Dependency Injection using `GetIt`.
- **`error/`**: Custom `Exceptions` and `Failures`.
- **`network/`**: Supabase client wrappers (`AuthClient`).

### 2. Data Layer (`lib/features/auth/data/`)
Handles data retrieval and persistence:
- **DataSources**: Direct interactions with Supabase Auth.
- **Models**: Data transfer objects (e.g., `UserModel`) with JSON serialization.
- **Repositories**: Implementations of domain repository interfaces.

### 3. Domain Layer (`lib/features/auth/domain/`)
Contains business logic (agnostic of framework/external tools):
- **Entities**: Core business objects (e.g., `UserEntity`).
- **Repositories**: Abstract definitions of data operations.

### 4. Presentation Layer (`lib/features/auth/presentation/`)
UI and State Management:
- **BLoCs**: State management for different auth types (`EmailAuthBloc`, `SocialAuthBloc`, `PhoneAuthBloc`, `SessionBloc`, `ProfileBloc`).
- **Screens**: Flutter Widgets representing full pages (Login, Signup, Forget Password).
- **Widgets**: Reusable UI components (e.g., `OtpStepWidget`).

## 🛠️ Tech Stack
- **Flutter**: UI Framework.
- **Supabase**: Backend-as-a-Service (Auth, Database).
- **Flutter BLoC**: State Management.
- **GetIt**: Service Locator for DI.
- **Dartz**: Functional programming (Either type for error handling).
- **Pinput**: OTP input widget.
- **Flutter Dotenv**: Environment variable management.

## 📂 Project Structure Overview
```text
lib/
├── core/                   # Shared logic and configurations
│   ├── di/                 # Dependency injection
│   ├── error/              # Failure/Exception handling
│   └── network/            # Supabase auth client implementation
├── features/               # Modular features (Clean Architecture)
│   └── auth/               # Authentication feature
│       ├── data/           # Data layer (Models, Repos, DataSources)
│       ├── domain/         # Domain layer (Entities, Repos)
│       └── presentation/   # UI layer (BLoCs, Screens, Widgets)
└── main.dart               # App entry point
```

## ⚙️ Setup & Configuration
- **Supabase**: Initialized in `main.dart` using credentials from `.env`.
- **Environment Variables**: Requires `.env` file with `SUPABASE_URL` and `SUPABASE_KEY`.
- **Dependency Injection**: `initDependencies()` in `injection_container.dart` registers all singletons and factories.

## 📱 Auth Workflow
1. **App Launch**: `AuthWrapper` checks the current session via `SessionBloc`.
2. **Authenticated**: User is directed to `HomePage`.
3. **Unauthenticated**: User starts at `LoginPage`.
4. **Registration**: Supports email/password with validation.
5. **Forget Password**: 
   - Enter email -> Receive OTP -> Verify OTP -> Reset Password.
