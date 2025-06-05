import 'package:seccion_estadisticas_v2/models/progress.dart';
import 'package:seccion_estadisticas_v2/models/usertdata.dart';

class Statistics {
  final String bookingId;
  final String status;
  final String timestamp;
  final String endTimestamp;
  final List<UserData> userData;
  final String companyId;
  final String employeeId;
  final String origin;
  final int totalBookings;
  final double totalBilledAmount;
  final int serviceId;
  final List<Progress> progress;
  final Map<String, int> totalBookingsPerEmployee;
  final Map<String, int> totalBookingsByStatus;
  final Map<String, int> totalBookingsPerService;
  final Map<String, int> totalBookingsPerPlatform;

  Statistics({
    required this.bookingId,
    required this.status,
    required this.timestamp,
    required this.endTimestamp,
    required this.userData,
    required this.companyId,
    required this.employeeId,
    required this.origin,
    required this.totalBookings,
    required this.totalBilledAmount,
    required this.serviceId,
    required this.progress,
    required this.totalBookingsPerEmployee,
    required this.totalBookingsByStatus,
    required this.totalBookingsPerService,
    required this.totalBookingsPerPlatform,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      bookingId: json['bookingId'] ?? '',
      status: json['status'] ?? '',
      timestamp: json['timestamp'] ?? '',
      endTimestamp: json['endTimestamp'] ?? '',
      userData: (json['userData'] as List?)?.map((e) => UserData.fromJson(e)).toList() ?? [],
      companyId: json['companyId'] ?? '',
      employeeId: json['employeeId']?.toString() ?? '',
      origin: json['origin'] ?? '',
      totalBookings: json['totalBookings'] ?? 0,
      totalBilledAmount: (json['totalBilledAmount'] ?? 0).toDouble(),
      serviceId: json['serviceId'] ?? 0,
      progress: (json['progress'] as List?)?.map((e) => Progress.fromJson(e)).toList() ?? [],
      totalBookingsPerEmployee: Map<String, int>.from(json['totalBookingsPerEmployee'] ?? {}),
      totalBookingsByStatus: Map<String, int>.from(json['totalBookingsByStatus'] ?? {}),
      totalBookingsPerService: Map<String, int>.from(json['totalBookingsPerService'] ?? {}),
      totalBookingsPerPlatform: Map<String, int>.from(json['totalBookingsPerPlatform'] ?? {}),
    );
  }
}
