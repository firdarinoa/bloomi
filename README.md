🌸 Bloomi
Bloomi is a women-focused iOS wellness app designed to help users understand and track their weight-loss journey through weight, body measurements, and menstrual cycle data.
Bloomi integrates with Apple HealthKit to seamlessly read and synchronise relevant health data, providing users with a centralised view of their health and progress.
The project demonstrates modern iOS development practices, including Clean MVVM architecture, reactive programming, local data persistence, HealthKit integration, data visualisation, and testable business logic.

✨ Features
⚖️ Weight Tracking
Record and monitor weight over time
Visualise weight trends and progress
Sync weight data with Apple Health through HealthKit
📏 Body Measurements
Track measurements such as waist, hips, arms, and thighs
Monitor changes over time
Visualise measurement progress
🌸 Period Tracking
Record menstrual cycle and period history
Track cycle-related data alongside weight and body measurements
Integrate relevant menstrual health data with Apple HealthKit
❤️ HealthKit Integration
Connect Bloomi with Apple Health
Read supported health and fitness data from HealthKit
Synchronise health information while respecting Apple's privacy and permission model
Handle HealthKit authorisation and data access
📊 Progress Visualisation
Interactive charts for weight and measurement trends
Historical health data visualisation
Progress-focused dashboard

🛠️ Tech Stack
Swift
SwiftUI
HealthKit
Swift Charts
Combine
SwiftData / Core Data
MVVM / Clean Architecture
Dependency Injection
Swift Package Manager
XCTest

🍎 HealthKit Integration
HealthKit acts as one of Bloomi's primary data sources.
The app handles:
HealthKit authorisation
Reading supported health data
Writing supported data where applicable
Mapping HealthKit data into the application's domain models
Synchronising health data with the local application state
Handling unavailable or unauthorised HealthKit data gracefully
HealthKit access is implemented with user privacy in mind, following Apple's permission-based approach to health data.

🎯 Project Goals
Bloomi was created as a portfolio project to demonstrate how modern iOS technologies can be combined to build a real-world, health-focused application.
The project demonstrates experience with:
Building modern SwiftUI interfaces
Integrating native Apple frameworks
Working with HealthKit and health data permissions
Designing scalable Clean MVVM architecture
Applying repository and use-case patterns
Managing application state with Combine
Persisting and querying local data
Building data visualisations with Swift Charts
Applying dependency injection
Writing testable business logic
Designing privacy-conscious health features

🚀 Future Improvements
Advanced HealthKit data synchronisation
Apple Watch integration
More detailed progress analytics
Goal and milestone tracking
Cycle-based progress insights
Cloud synchronisation
Notifications and reminders
Home Screen and Lock Screen widgets
Live Activities for relevant tracking features
