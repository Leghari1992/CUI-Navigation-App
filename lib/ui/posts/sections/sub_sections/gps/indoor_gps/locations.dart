// lib/locations.dart

// Maps location names to their node labels
final Map<String, List<String>> locationNodes = {
  'Student Lobby': ['A', 'B', 'C'],
  'Corridor': ['D', 'E', 'F', 'G', 'H', 'J', 'I', 'O'],
  'G06': ['P'],
  'G07': ['Q'],
  'G02': ['N', 'M'],
  'G01': ['K', 'L'],
};

// Returns a list of all available locations
List<String> getAllLocations() {
  return locationNodes.keys.toList();
}

// Gets all nodes for a specified location
List<Map<String, dynamic>> getNodesForLocation(
    String location,
    List<Map<String, dynamic>> allNodes,
    ) {
  List<String> nodeLabels = locationNodes[location] ?? [];
  return allNodes
      .where(
        (node) => node['label'] != null && nodeLabels.contains(node['label']),
  )
      .toList();
}

// Gets the nearest node within a location
Map<String, dynamic> getNearestNodeInLocation(
    String location,
    List<double> userPosition,
    List<Map<String, dynamic>> allNodes,
    ) {
  List<Map<String, dynamic>> locationNodes = getNodesForLocation(
    location,
    allNodes,
  );

  // If no nodes in this location
  if (locationNodes.isEmpty) {
    return {};
  }

  // If user position is unknown, return the first valid node
  if (userPosition[0] == 0 && userPosition[1] == 0) {
    // Find first node with valid coordinates
    for (var node in locationNodes) {
      if (node['coordinates'] != null) {
        return node;
      }
    }
    return locationNodes.first; // Fallback
  }

  // Find the nearest node in this location
  Map<String, dynamic> nearest = {};
  double minDistance = double.infinity;

  for (var node in locationNodes) {
    if (node['coordinates'] == null) continue;

    double distance = _calculateDistance(userPosition, node['coordinates']);
    if (distance < minDistance) {
      minDistance = distance;
      nearest = node;
    }
  }

  // If no valid node was found, return the first node
  if (nearest.isEmpty && locationNodes.isNotEmpty) {
    return locationNodes.first;
  }

  return nearest;
}

// Helper to calculate distance between two points
double _calculateDistance(List<double> point1, List<dynamic> point2) {
  return (point1[0] - point2[0]) * (point1[0] - point2[0]) +
      (point1[1] - point2[1]) * (point1[1] - point2[1]);
}
