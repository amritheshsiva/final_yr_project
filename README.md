# Drone Disease Detection App

**Drone Disease Detection App** for identifying and mapping coconut tree diseases using a drone integrated with machine learning.

---

## Features

- **User Authentication:** Secure login using Firebase Authentication.
- **Location Tracking:** Automatically fetches user location using OpenStreetMap API.
- **Disease Detection:** Drone captures images and detects diseases using a trained ML model.
- **Real-time Mapping:** Detected diseases are mapped with their locations in Firebase.
- **Prediction Images:** Displays images of detected diseases with details in the app.

---

## Technologies Used

- **Frontend:** Flutter (Dart)
- **Backend:** Firebase Authentication, Firebase Realtime Database
- **Location Services:** OpenStreetMap API
- **Machine Learning:** Image classification for disease detection

---

## How It Works

1. **User Login:** User logs in using Firebase Authentication.
2. **Location Fetching:** The app fetches the user's location using OpenStreetMap API and displays it on the Map tab.
3. **Disease Detection:** The drone, equipped with a camera and ML model, captures images of coconut trees.
4. **Data Upload:** If a disease is detected, the drone stores the disease name, location, and captured image in Firebase.
5. **Prediction Display:** The app retrieves disease data and images from Firebase and displays them in the Prediction tab.

---

## 📸 App Screenshots

### 1. Login Page
<img src="https://github.com/amritheshsiva/final_yr_project/blob/main/login_page.png" alt="Login Page" width="400">

### 2. User Location
<img src="https://github.com/amritheshsiva/final_yr_project/blob/main/user_location.png" alt="User Location" width="400">

### 3. Disease Prediction 1
<img src="https://github.com/amritheshsiva/final_yr_project/blob/main/prediction1.png" alt="Prediction 1" width="400">

### 4. Disease Prediction 2
<img src="https://github.com/amritheshsiva/final_yr_project/blob/main/prediction2.png" alt="Prediction 2" width="400">
