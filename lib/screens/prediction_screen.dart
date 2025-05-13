import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/prediction_service.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final PredictionService _predictionService = PredictionService();
  Map<String, dynamic>? predictionData;

  @override
  void initState() {
    super.initState();
    _fetchPrediction();
  }

  Future<void> _fetchPrediction() async {
    var data = await _predictionService.getHighestAccuracyPrediction();

    if (data != null && data['location'] != null) {
      List<String> latLng = data['location'].split(",");
      data['latitude'] = double.parse(latLng[0]);
      data['longitude'] = double.parse(latLng[1]);
    }

    setState(() {
      predictionData = data;
    });
  }

  final Map<String, String> predictionImages = {
    "CCI_Caterpillars": "assets/images/CCI_Caterpillars.jpg",
    "CCI_Leaflets": "assets/images/CCI_Leaflets.jpg",
    "Healthy_Leaves": "assets/images/Healthy_Leaves.jpg",
    "WCLWD_DryingofLeaflets": "assets/images/WCLWD_DryingofLeaflets.jpeg",
    "WCLWD_Flaccidity": "assets/images/WCLWD_Flaccidity.jpeg",
    "WCLWD_Yellowing": "assets/images/WCLWD_Yellowing.jpeg",
  };

  String? _getImageForPrediction(String predictionClass) {
    return predictionImages[predictionClass];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prediction Details"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchPrediction,
            tooltip: 'Refresh data',
          ),
        ],
      ),
      body:
          predictionData == null
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                onRefresh: _fetchPrediction,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.analytics,
                                  size: 28,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Latest Prediction",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            if (_getImageForPrediction(
                                  predictionData!['class'],
                                ) !=
                                null)
                              Center(
                                child: Image.asset(
                                  _getImageForPrediction(
                                    predictionData!['class'],
                                  )!,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            const SizedBox(height: 20),

                            _buildPredictionItem(
                              "Class",
                              predictionData!['class'],
                              Icons.category,
                            ),
                            const Divider(height: 20),
                            _buildPredictionItem(
                              "Confidence",
                              "${predictionData!['confidence']}%",
                              Icons.verified,
                            ),
                            const Divider(height: 20),
                            _buildPredictionItem(
                              "Timestamp",
                              predictionData!['timestamp'],
                              Icons.access_time,
                            ),
                            const SizedBox(height: 20),

                            if (predictionData!['latitude'] != null &&
                                predictionData!['longitude'] != null)
                              SizedBox(
                                height: 300,
                                child: FlutterMap(
                                  options: MapOptions(
                                    initialCenter: LatLng(
                                      predictionData!['latitude'],
                                      predictionData!['longitude'],
                                    ),
                                    initialZoom: 13.0,
                                  ),
                                  children: [
                                    TileLayer(
                                      urlTemplate:
                                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                      subdomains: ['a', 'b', 'c'],
                                    ),
                                    MarkerLayer(
                                      markers: [
                                        Marker(
                                          point: LatLng(
                                            predictionData!['latitude'],
                                            predictionData!['longitude'],
                                          ),
                                          width: 50.0,
                                          height: 50.0,
                                          child: const Icon(
                                            Icons.location_pin,
                                            color: Colors.red,
                                            size: 40,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
    );
  }

  Widget _buildPredictionItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 24, color: Colors.grey[600]),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
