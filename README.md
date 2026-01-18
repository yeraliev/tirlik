# tirlik

Tirlik - Personal Task Management App
A secure, feature-rich task management application built with Flutter, emphasizing privacy and clean architecture principles.
📱 About
Secure Task is a personal productivity app that helps users organize their tasks, notes, and daily activities with PIN-based authentication. The app stores all data locally on the device using an encrypted SQLite database, ensuring complete privacy and offline functionality.
✨ Features

🔐 PIN-Based Authentication - Secure 4-digit PIN with SHA-256 hashing
📁 Task Groups - Organize tasks into customizable categories with colors and emojis
✅ Task Management - Create, update, and track tasks with priorities and due dates
📝 Notes - Quick note-taking with pinning capability
🎨 Customization - Personalize task groups with custom colors and icons
💾 Offline First - All data stored locally with Drift (SQLite)
🔒 Privacy Focused - No cloud sync, no data collection, everything stays on your device

🛠️ Tech Stack
Core

Flutter - Cross-platform UI framework
Dart - Programming language

Architecture

Clean Architecture - Separation of concerns with domain, data, and presentation layers
BLoC Pattern - State management with flutter_bloc
Repository Pattern - Data abstraction layer

Database & Storage

Drift (v2.30.1) - Type-safe SQL database built on SQLite
SQLite3 - Local database engine
Path Provider - File system access

Security

Crypto - SHA-256 PIN hashing

Dependency Injection

GetIt - Service locator for dependency injection

Navigation

go_router - Declarative routing with custom transitions

State Management

flutter_bloc - Predictable state managementmanagement. 

