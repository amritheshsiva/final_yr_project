import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class PredictionService {
  late FirebaseDatabase _database;
  bool _isInitialized = false;

  PredictionService() {
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      _database = FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL:
            'https://cocodata-bab89-default-rtdb.asia-southeast1.firebasedatabase.app/',
      );
      _isInitialized = true;
      print("✅ Firebase Database initialized successfully");
    } catch (e) {
      print("🔥 Firebase initialization failed: $e");
    }
  }

  Future<Map<String, dynamic>?> getHighestAccuracyPrediction() async {
    while (!_isInitialized) {
      print("⏳ Waiting for Firebase to initialize...");
      await Future.delayed(const Duration(seconds: 2));
    }

    try {
      DatabaseReference dbRef = _database.ref("predictions");
      DatabaseEvent event = await dbRef.once();
      DataSnapshot snapshot = event.snapshot;

      if (!snapshot.exists || snapshot.value == null) {
        print("⚠️ No data found in Firebase!");
        return null;
      }

      Map<String, dynamic> predictions = Map<String, dynamic>.from(
        snapshot.value as Map,
      );

      String bestClass = "";
      double highestConfidence = 0.0;
      String timestamp = "";
      String location = "";

      predictions.forEach((key, value) {
        Map<String, dynamic> data = Map<String, dynamic>.from(value);
        double confidence = (data["confidence"] ?? 0.0).toDouble();

        if (confidence > highestConfidence) {
          highestConfidence = confidence;
          bestClass = data["class"] ?? "";
          timestamp = data["timestamp"] ?? "";
          location = data["location"] ?? "";
        }
      });

      return {
        "class": bestClass,
        "confidence": highestConfidence,
        "timestamp": timestamp,
        "location": location,
      };
    } catch (e) {
      print("🔥 Error fetching predictions: $e");
      return null;
    }
  }
}
