# EmployMe — Hyperlocal Job Platform for India's Informal Workforce

> 🏆 Built for National Hackathon | Team Xypheria Membrane

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB" />
  <img src="https://img.shields.io/badge/Vite-646CFF?style=for-the-badge&logo=vite&logoColor=white" />
</p>

---

## 🎯 Problem Statement

**400 million+ informal workers** in India — daily wage earners, domestic helpers, delivery partners, shop assistants — have **no structured way** to find hyperlocal jobs. Employers in local markets, restaurants, and households struggle to find trustworthy workers nearby.

**EmployMe bridges this gap** with a mobile-first, bilingual (English + Kannada), trust-verified job platform that connects workers and employers within walking distance.

---

## 💡 Key Features

### For Workers 👷
- **AI-Matched Job Feed** — Personalized job recommendations based on skills, location, and availability
- **Nearby Jobs Map** — Uber-inspired hyperlocal map showing jobs within walking distance with salary pins
- **Quick Apply** — 2-tap application flow with availability and timing preferences
- **Trust Score Dashboard** — Fintech-grade credit score visualization (87/100) with verification badges
- **Earnings Wallet** — CRED-inspired earnings dashboard with weekly charts and transaction history
- **Bilingual UI** — Full English + Kannada support throughout

### For Employers 🏢
- **Post Jobs in 60 seconds** — Guided job posting with AI-generated descriptions
- **View Applicants** — Trust-score ranked applicant list with skill matching
- **Nearby Workers Map** — Find available verified workers in your area
- **Chat & Hire** — In-app messaging with job offer cards

### Trust & Safety 🛡️
- **Multi-Layer Verification** — Phone OTP → Community → NGO Ground Verification
- **Trust Score System** — Composite score from verification, reviews, and reliability
- **Employer Ratings** — Star ratings + badge system (On Time, Honest, Hardworking)

---

## 📱 App Screens (27 Screens)

| Flow | Screens |
|------|---------|
| **Auth** | Splash → Language Selection → Role Selection → Phone + OTP |
| **Onboarding** | Skills Selection → Location & Availability → Profile Setup |
| **Worker** | Job Feed → Nearby Map → Job Detail → Quick Apply → My Jobs → Earnings Wallet → Profile → Notifications |
| **Employer** | Dashboard → Post Job → View Applicants |
| **Chat** | Chat List → Chat Screen (with job offer cards) |
| **Trust** | Trust Score Dashboard → NGO Verification |
| **Demo** | Impact Dashboard → Feature Highlights → SMS Fallback |

---

## 🏗️ Tech Stack

### Flutter Mobile App (Primary)
```
employme_flutter/
├── lib/
│   ├── main.dart              # App entry + routing (27 routes)
│   ├── theme/app_theme.dart   # Design system (colors, shadows, typography)
│   ├── providers/app_state.dart # State management (Provider)
│   ├── screens/
│   │   ├── auth/              # Splash, Language, Role, Phone+OTP
│   │   ├── onboarding/        # Skills, Location, Profile Setup
│   │   ├── worker/            # Feed, Map, Detail, Apply, Jobs, Wallet, Profile
│   │   ├── employer/          # Dashboard, Post Job, Applicants
│   │   ├── chat/              # Chat List, Chat Screen
│   │   ├── trust/             # Trust Score, NGO Verification
│   │   └── demo/              # Impact, Features, SMS Fallback
│   ├── widgets/               # Reusable components (JobCard, BottomNav, etc.)
│   └── services/demo_data.dart # Demo data for hackathon
└── pubspec.yaml
```

### MERN Web Prototype (Reference)
```
src/
├── screens/          # 24 React screens
├── App.jsx           # Router + screen navigation
├── index.css         # Design system (CSS variables)
└── main.jsx          # Entry point
```

---

## 🎨 Design System

| Token | Value |
|-------|-------|
| **Primary** | `#10B981` (Emerald Green — trust, growth) |
| **Navy** | `#1E293B` (Deep trust blue — headers, dark cards) |
| **Background** | `#F9FAFB` (Warm off-white) |
| **Card** | `#FFFFFF` with soft shadow |
| **Alert** | `#EF4444` (Urgent jobs) |
| **Warning** | `#F59E0B` (Pending verification) |
| **Font** | Inter (Google Fonts) |
| **Border Radius** | 8px–24px (consistent) |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.x+
- Android Studio / VS Code
- Android device or emulator

### Run Flutter App
```bash
cd employme_flutter
flutter pub get
flutter run
```

### Run Web Prototype (Reference)
```bash
npm install
npm run dev
# Opens at http://localhost:5173
```

---

## 🏆 Hero Screens for Demo

1. **🗺️ Nearby Jobs Map** — Uber-inspired hyperlocal map with salary pins, radius controls, draggable bottom sheet
2. **🛡️ Trust Score** — Animated gradient arc (fintech credit score style), badge grid, comparison charts
3. **💰 Earnings Wallet** — Dark balance card, weekly bar chart, transaction history
4. **📱 Job Feed** — AI-matched recommendations with category filters, urgent banners, search
5. **⚡ Quick Apply** — 2-step form with animated transitions, success celebration

---

## 🌍 Innovation Highlights

- **Bilingual-first** — English + Kannada throughout (not an afterthought)
- **Trust Score** — Multi-layer verification unique to informal workforce
- **Walking Distance Jobs** — Hyperlocal radius-based matching
- **SMS Fallback** — Works even without internet (feature phone compatible)
- **Community Verification** — Neighbor-based identity verification
- **NGO Ground Verification** — Partnership model for deep trust

---

## 👥 Team Xypheria Membrane

Built with ❤️ for India's 400M+ informal workforce.

---

## 📄 License

This project is built for hackathon demonstration purposes.
