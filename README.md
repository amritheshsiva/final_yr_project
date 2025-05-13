# 🌐 Drone Disease Detection App

Welcome to the **Drone Disease Detection App** (`drone_project`) – a smart solution for identifying and mapping coconut tree diseases using a drone integrated with machine learning.

---

## 🚀 Features

- 🔒 **User Authentication:** Secure login using Firebase Authentication.
- 🌍 **Location Tracking:** Automatically fetches user location using OpenStreetMap API.
- 📸 **Disease Detection:** Drone captures images and detects diseases using a trained ML model.
- 🗺️ **Real-time Mapping:** Detected diseases are mapped with their locations in Firebase.
- 🖼️ **Prediction Images:** Displays images of detected diseases with details in the app.

---

## 🛠️ Technologies Used

- **Frontend:** Flutter (Dart)
- **Backend:** Firebase Authentication, Firebase Realtime Database
- **Location Services:** OpenStreetMap API
- **Machine Learning:** Image classification for disease detection (on drone hardware)
- **Hardware:** Drone with camera for image capture

---

## 📸 How It Works

1. **User Login:** User logs in using Firebase Authentication.
2. **Location Fetching:** The app fetches the user's location using OpenStreetMap API and displays it on the Map tab.
3. **Disease Detection:** The drone, equipped with a camera and ML model, captures images of coconut trees.
4. **Data Upload:** If a disease is detected, the drone stores the disease name, location, and captured image in Firebase.
5. **Prediction Display:** The app retrieves disease data and images from Firebase and displays them in the Prediction tab.

---

## 📂 Project Structure

