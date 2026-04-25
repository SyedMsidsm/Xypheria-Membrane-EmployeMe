# EmployeMe — Hyperlocal Hiring Without Resumes

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Vite](https://img.shields.io/badge/Vite-646CFF?logo=vite&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?logo=javascript&logoColor=black)
![CI](https://img.shields.io/badge/CI-GitHub_Actions-2088FF?logo=githubactions&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)

**EmployeMe connects local workers and nearby employers instantly through simple chat-based hiring and hyperlocal matching.**

</div>

---

## 🌍 Why EmployeMe?

Traditional hiring often excludes informal workers due to resume barriers, slow processes, and poor local discoverability.

**EmployeMe solves this by enabling:**
- 📍 **Hyperlocal matching** between nearby workers and employers  
- 💬 **Chat-first hiring** without requiring formal resumes  
- ⚡ **Faster job access** for workers and quicker staffing for small businesses  
- 🤝 **Inclusive opportunity** for the informal economy

---

## ✨ Core Features

- Worker & employer onboarding
- Nearby opportunity discovery
- Chat-based hiring flow
- Lightweight profile-based matching
- Mobile-first user experience
- Expandable architecture for trust, verification, and ratings

---

## 🧱 Tech Stack

### Mobile
- Flutter (Dart)

### Web
- Vite + JavaScript

### Tooling
- GitHub Actions CI
- ESLint + Prettier (web)
- Flutter analyze/test/lints

---

## 🚀 Quick Start

## Prerequisites
- Node.js 18+
- npm
- Flutter SDK (stable)

### 1) Clone
```bash
git clone https://github.com/SyedMsidsm/Xypheria-Membrane-EmployeMe.git
cd Xypheria-Membrane-EmployeMe
```

### 2) Run Web (Vite)
```bash
npm install
npm run dev
```

Build:
```bash
npm run build
npm run preview
```

### 3) Run Flutter
```bash
cd employme_flutter
flutter pub get
flutter run
```

Quality checks:
```bash
flutter analyze
flutter test
```

---

## 📁 Project Structure

```text
.
├── src/                            # Web app (Vite)
├── employme_flutter/               # Flutter app
│   └── lib/
│       ├── core/                   # App-wide configs, services, utils
│       ├── features/               # Feature-first modules
│       └── shared/                 # Shared widgets/models/extensions
├── .github/
│   ├── workflows/ci.yml
│   └── ISSUE_TEMPLATE/
├── README.md
└── ...
```

---

## 🧭 Roadmap

- [ ] Role-based access (worker/employer/admin)
- [ ] Smarter location + skill-based ranking
- [ ] In-app trust signals (verification, ratings)
- [ ] Multilingual support
- [ ] Offline-first UX for low-connectivity areas
- [ ] Analytics for hiring conversion

---

## 🤝 Contributing

PRs are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) first.

---

## 🔐 Security

Please report vulnerabilities via [SECURITY.md](SECURITY.md).

---

## 📄 License

MIT — see [LICENSE](LICENSE)

---

## 👤 Maintainer

**SyedMsidsm**  
GitHub: [@SyedMsidsm](https://github.com/SyedMsidsm)
