import 'package:seccion_estadisticas_v2/models/progress.dart';

class Statistics {
  final int totalBookings;
  final double totalBilledAmount;
  final List<Progress> progress;
  final Map<String,int> totalBookingsPerEmployee;
  final Map<String,int> totalBookingsByStatus;
  final Map<String,int> totalBookingsPerService;
  final Map<String,int> totalBookingsPerPlatform;

  Statistics({required this.totalBookings, required this.totalBilledAmount, required this.progress, required this.totalBookingsPerEmployee, required this.totalBookingsByStatus,required this.totalBookingsPerService,required this.totalBookingsPerPlatform});

  factory Statistics.fromJson(Map<String,dynamic> json){
    return Statistics(
      totalBookings: json['totalBookings'],
      totalBilledAmount: json['totalBilledAmount'],
      progress: (json['progress'] as List).map((e)=> Progress.fromJson(e)).toList(),
      totalBookingsPerEmployee: Map<String,int>.from(json['totalBookingsPerEmployee']),
      totalBookingsByStatus: Map<String,int>.from(json['totalBookingsByStatus']),
      totalBookingsPerService: Map<String,int>.from(json['totalBookingsPerService']),
      totalBookingsPerPlatform: Map<String,int>.from(json['totalBookingsPerPlatform']),
    );
  }
}