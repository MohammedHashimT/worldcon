class RouteMapModel {
  final String name;
  final String image;

  RouteMapModel({required this.name, required this.image});

  factory RouteMapModel.fromJson(Map<String, dynamic> json) {
    return RouteMapModel(
      name: json['name']?.toString() ?? 'Unnamed Venue',
      image: json['image']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'image': image};
  }
}

class ResponseModel {
  final String status;
  final String venueCount;
  final List<RouteMapModel> venue;

  ResponseModel({
    required this.status,
    required this.venueCount,
    required this.venue,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    List<RouteMapModel> parsedVenues = [];
    if (json['route_map_to_venue'] != null &&
        json['route_map_to_venue'] is List) {
      parsedVenues =
          (json['route_map_to_venue'] as List)
              .map((item) {
                if (item is Map<String, dynamic>) {
                  return RouteMapModel.fromJson(item);
                }
                print('Warning: Invalid item in venue list: $item');
                return RouteMapModel(name: 'Invalid Data', image: '');
              })
              .whereType<RouteMapModel>()
              .toList();
    }

    return ResponseModel(
      status:
          json['status']?.toString() ??
          'Unknown Status',
      venueCount: json['route_map_to_venue_count']?.toString() ?? '0',
      venue: parsedVenues,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'route_map_to_venue_count': venueCount,
      'route_map_to_venue': venue.map((v) => v.toJson()).toList(),
    };
  }
}
