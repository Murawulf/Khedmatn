# Khedmatn Project

## Overview
Khedmatn is a comprehensive service application for the Tunisian market, built with Flutter.
It integrates three main verticals:
1.  **Errand Runner (Kodyan):** Task posting and execution.
2.  **Home Cooked Meals (Makla):** Food ordering from local cooks.
3.  **Ride Sharing (Covoiturage):** Commute sharing.

## Tech Stack
*   **Framework:** Flutter
*   **Language:** Dart
*   **State Management:** Provider
*   **Local Storage:** Hive (NoSQL)
*   **Maps:** Google Maps Flutter (Placeholder setup)
*   **Localization:** Custom JSON-based (EN, FR, TN)

## Features Implemented
*   **Authentication:** Simulated Login/Role Selection (Client, Worker, Admin).
*   **Localization:** Dynamic language switching.
*   **Errands:** Create Task, List Tasks, Accept Task (Simulated).
*   **Food:** Browse Cooks (Static).
*   **Rides:** Browse Rides (Static).
*   **Admin:** Dashboard structure.

## Architecture
*   `lib/core`: Services (Storage, Localization), Models.
*   `lib/features`: Modular feature structure (Auth, Dashboard, Errands, Food, Rides, Admin).
*   `lib/main.dart`: App entry point.

## Next Steps
*   Integrate real Google Maps API Key.
*   Implement real backend (Firebase or Supabase) replacing Hive for sync.
*   Add Image Upload for Cook Profiles.
*   Implement Chat feature.
