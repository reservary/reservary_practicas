import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:seccion_estadisticas_v2/models/progress.dart';
import 'package:seccion_estadisticas_v2/models/statistics.dart';

class StatisticsScreenViewModel extends ChangeNotifier {
  Statistics? _originalStats;
  Statistics? _filteredStats;

  DateTime? _initDate;
  DateTime? _endDate;
  final _dateFormat = DateFormat('dd/MM/yyyy');
  int? _employeeId;
  int? _servicesId;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Statistics? get originalStats => _originalStats;
  Statistics? get filteredStats => _filteredStats;

  Future<void> loadStats() async {
    try {
      _isLoading = true;
      notifyListeners();
      final jsonString = await rootBundle.loadString('assets/data/data.json');
      final jsonMap = jsonDecode(jsonString);
      _originalStats = Statistics.fromJson(jsonMap);
      _filteredStats = _originalStats;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Error cargando datos: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  Map<String, int> get totalBookingsPerPlatform {
    if (_originalStats == null) return {};
    return _originalStats!.totalBookingsPerPlatform;
  }

  Map<String, int> get totalBookingsPerEmployee {
    if (_originalStats == null) return {};
    return _originalStats!.totalBookingsPerEmployee;
  }

  Map<String, int> get totalBookingsPerService {
    if (_originalStats == null) return {};
    return _originalStats!.totalBookingsPerService;
  }

  Map<String, int> get totalBookingsByStatus {
    if (_originalStats == null) return {};
    return _originalStats!.totalBookingsByStatus;
  }

  String _formatDate(DateTime date) {
    return _dateFormat.format(date);
  }

  String formatDateFromString(String dateStr) {
    final date = DateTime.parse(dateStr);
    return _formatDate(date);
  }

  List<Progress> get allProgress {
    if (_originalStats == null) return [];

    final progress = List<Progress>.from(_originalStats!.progress);
    progress.sort(
      (a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)),
    );
    return progress;
  }

  // List<Progress> filteredByServices(int serviceId) {
  //   if (_originalStats == null || serviceId == 0) {
  //     _filteredStats = _originalStats;
  //   } else {
  //     if (_originalStats!.serviceId == serviceId) {
  //       _filteredStats = Statistics(
  //         totalBookings: _originalStats!.totalBookings,
  //         totalBilledAmount: _originalStats!.totalBilledAmount,
  //         employeeId: _originalStats!.employeeId,
  //         serviceId: serviceId,
  //         progress: _originalStats!.progress,
  //         totalBookingsPerEmployee: _originalStats!.totalBookingsPerEmployee,
  //         totalBookingsByStatus: _originalStats!.totalBookingsByStatus,
  //         totalBookingsPerService: _originalStats!.totalBookingsPerService,
  //         totalBookingsPerPlatform: _originalStats!.totalBookingsPerPlatform,
  //       );
  //     } else {
  //       _filteredStats = Statistics(
  //         totalBookings: _originalStats!.totalBookings,
  //         totalBilledAmount: _originalStats!.totalBilledAmount,
  //         employeeId: _originalStats!.employeeId,
  //         serviceId: serviceId,
  //         progress: _originalStats!.progress,
  //         totalBookingsPerEmployee: _originalStats!.totalBookingsPerEmployee,
  //         totalBookingsByStatus: _originalStats!.totalBookingsByStatus,
  //         totalBookingsPerService: _originalStats!.totalBookingsPerService,
  //         totalBookingsPerPlatform: _originalStats!.totalBookingsPerPlatform,
  //       );
  //     }
  //   }

  //   notifyListeners();
  // }
}
