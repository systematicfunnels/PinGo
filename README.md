# PinGo

**"Pin it. Plan it. Go."**

PinGo is a journey-mapping app that helps people capture places, paths, and experiences—including unknown locations not present on traditional maps. It focuses on presence, memory, and exploration rather than social performance.

## 🏗 Architecture

This project follows a **Production-Grade Flutter Architecture**:
- **Style**: Clean Architecture + Feature-first + Local-first
- **State Management**: Riverpod
- **Routing**: GoRouter
- **Database**: Drift (SQLite) - Local source of truth
- **Networking**: Dio

### Folder Structure
```
lib/
├── core/               # Shared logic (Network, DB, Theme, Routing)
├── features/           # Feature-based modules
│   ├── onboarding/     # Splash, Welcome
│   └── pins/           # Pin management (Domain, Data, Presentation)
├── main.dart           # Entry point
└── app.dart            # Root widget
```

## 🚀 Getting Started

1.  **Install Dependencies**
    ```bash
    flutter pub get
    ```

2.  **Run Code Generator** (Required for Riverpod/Drift)
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

3.  **Run App**
    ```bash
    flutter run
    ```

## 🛠 Development Scripts

We provide scripts to ensure code quality (Format, Analyze, Test).

**Windows (PowerShell):**
```powershell
.\ci\scripts\check_quality.ps1
```

**Mac/Linux (Bash):**
```bash
./ci/scripts/check_quality.sh
```
