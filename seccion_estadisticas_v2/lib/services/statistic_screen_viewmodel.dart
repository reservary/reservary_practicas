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
  String? _selectedEmployeeId;
  String? get selectedEmployeeId => _selectedEmployeeId;

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

  void selectEmployee(String? employeeId) {
    _selectedEmployeeId = employeeId;
    notifyListeners();
  }

  Statistics filteredByServices(int serviceId) {
    if (_originalStats == null) {
      return Statistics(
        totalBookings: 0,
        totalBilledAmount: 0,
        employeeId: 0,
        serviceId: 0,
        progress: [],
        totalBookingsPerEmployee: {},
        totalBookingsByStatus: {},
        totalBookingsPerService: {},
        totalBookingsPerPlatform: {},
      );
    }

    if (serviceId == 0) {
      _filteredStats = _originalStats;
      notifyListeners();
      return _filteredStats!;
    }
    List<Progress> filteredProgress =
        _originalStats!.progress
            .where((p) => _originalStats!.serviceId == serviceId)
            .toList();
    _filteredStats = Statistics(
      totalBookings: _originalStats!.totalBookings,
      totalBilledAmount: _originalStats!.totalBilledAmount,
      employeeId: _originalStats!.employeeId,
      serviceId: serviceId,
      progress: filteredProgress,
      totalBookingsPerEmployee: _originalStats!.totalBookingsPerEmployee,
      totalBookingsByStatus: _originalStats!.totalBookingsByStatus,
      totalBookingsPerService: _originalStats!.totalBookingsPerService,
      totalBookingsPerPlatform: _originalStats!.totalBookingsPerPlatform,
    );
    notifyListeners();
    return _filteredStats!;
  }

  Statistics filteredEmployee(String? employeeId) {
    if (_originalStats == null) {
      return Statistics(
        totalBookings: 0,
        totalBilledAmount: 0,
        employeeId: 0,
        serviceId: 0,
        progress: [],
        totalBookingsPerEmployee: {},
        totalBookingsByStatus: {},
        totalBookingsPerService: {},
        totalBookingsPerPlatform: {},
      );
    }
    if (employeeId == null) {
      _filteredStats = _originalStats;
      _selectedEmployeeId = null;
      notifyListeners();
      return _filteredStats!;
    }

    _filteredStats = Statistics(
      totalBookings: _originalStats!.totalBookings,
      totalBilledAmount: _originalStats!.totalBilledAmount,
      employeeId: _originalStats!.employeeId,
      serviceId: _originalStats!.serviceId,
      progress: _originalStats!.progress,
      totalBookingsPerEmployee: _originalStats!.totalBookingsPerEmployee,
      totalBookingsByStatus: _originalStats!.totalBookingsByStatus,
      totalBookingsPerService: _originalStats!.totalBookingsPerService,
      totalBookingsPerPlatform: _originalStats!.totalBookingsPerPlatform,
    );
    _selectedEmployeeId=employeeId;
    notifyListeners();
    return _filteredStats!;
  }
}
