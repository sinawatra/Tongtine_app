# Tongtine App

[![Flutter](https://img.shields.io/badge/Flutter-3.9.2-blue.svg?logo=flutter&logoColor=white)](https://flutter.dev)
[![GetX](https://img.shields.io/badge/State_Management-GetX-purple.svg)](https://pub.dev/packages/get)
[![Architecture](https://img.shields.io/badge/Architecture-Clean_GetX-green.svg)](https://github.com/jonataslaw/get_cli)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A sophisticated Flutter application built for the **Tongtine Ecosystem**. This project implements a robust architecture designed for scalability, featuring secure authentication, KYC integration, real-time communication, and comprehensive service management.

---

## Key Features

### Security and Identity
- **Multi-Factor Auth**: Secure OTP-based registration and login.
- **KYC Integration**: Automated ID extraction and document submission.
- **Secure Storage**: Sensitive data protected using AES-256 encryption.

### Communication and Interaction
- **Real-time Chat**: Powered by Socket.IO with media sharing capabilities.
- **Push Notifications**: Firebase Cloud Messaging (FCM) integration.
- **In-App Calling**: Integrated voice/video calling services.

### Service Management
- **Order Tracking**: Comprehensive lifecycle management for jobs and orders.
- **Profile Management**: Dynamic availability scheduling and KYC verification.
- **Location Services**: Google Maps integration for precise service tracking.

### Advanced UI/UX
- **Dynamic Theming**: Custom-built design system with Google Fonts.
- **Interactive Charts**: Data visualization using FL Charts.
- **Seamless UX**: Lottie animations and skeletonized loading states.

---

## Technology Stack

| Category | Technology |
| :--- | :--- |
| **Framework** | [Flutter](https://flutter.dev) |
| **State Management** | [GetX](https://pub.dev/packages/get) |
| **Networking** | [Dio](https://pub.dev/packages/dio) |
| **Real-time** | [Socket.io](https://pub.dev/packages/socket_io_client), [MQTT](https://pub.dev/packages/mqtt_client) |
| **Auth** | [Firebase Auth](https://firebase.google.com), [Local Auth](https://pub.dev/packages/local_auth) |
| **Mapping** | [Google Maps](https://pub.dev/packages/google_maps_flutter) |
| **Media** | [FFmpeg](https://pub.dev/packages/ffmpeg_kit_flutter_new), [Camera](https://pub.dev/packages/camera) |

---

## Project Structure

The project follows a modular **GetX Clean Architecture**:

```bash
lib/
├── app/
│   ├── common/         # Shared widgets and global components
│   ├── data/           # Repositories, providers, and models
│   │   ├── service/    # API & Storage service implementations
│   ├── modules/        # Feature-based modules (View, Controller, Binding)
│   │   ├── authentication/
│   │   ├── home/
│   │   └── utils/      # App constants, helpers, and themes
│   └── routes/         # Route definitions and page mappings
└── main.dart           # Application entry point
```

---

## Getting Started

### Prerequisites
- Flutter SDK `^3.9.2`
- Android Studio / VS Code
- CocoaPods (for iOS development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-repo/tongtine_app.git
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Environment**
   Update `lib/app/modules/utils/constants/app_constants.dart` with your API keys if necessary.

4. **Run the application**
   ```bash
   flutter run
   ```

---


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
Developed by the Tongtine Team.
