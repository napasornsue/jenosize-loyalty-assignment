# Jenosize Loyalty Assignment

A prototype mobile application for a Loyalty Platform, developed with Flutter as part of the Jenosize technical assignment.

---

## Features

* **Campaign List**: Display a list of loyalty campaigns
* **Membership**: Join a membership and persist the membership state locally
* **Referral**: Generate and share a referral link
* **Points Tracker**: Display current points and transaction history

---

## Tech Stack

* Flutter 3.38.5
* Dart 3.10.4
* State Management: Riverpod
* Local Storage: SharedPreferences

---

## Project Structure

This project follows **Clean Architecture** principles to clearly separate responsibilities across layers:

* **Domain**: Business rules and core entities
* **Data**: Data sources and repository implementations
* **Presentation**: UI and state management

This structure improves maintainability, testability, and scalability, and allows data sources to be replaced (e.g. Local → API/Firebase) with minimal impact on business logic.

---

## Notes

This project is a prototype and does not connect to a real backend.
Mock data and local storage are used to demonstrate system design and application flow.

* Referral and point logic are simulated for demonstration purposes only.
* The architecture is designed to support future integration with backend services or Firebase.

---

## Getting Started

```bash
flutter pub get
flutter run
```
