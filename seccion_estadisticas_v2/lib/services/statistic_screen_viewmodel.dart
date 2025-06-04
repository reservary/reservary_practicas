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
  List<String> _selectedEmployeeIds = [];
  bool _isLoading = false;
  List<String> _selectedServices = [];

  DateTime? get initDate => _initDate;
  DateTime? get endDate => _endDate;
  bool get isLoading => _isLoading;
  List<String> get selectedServices => _selectedServices;
  List<String> get selectedEmployeeIds => _selectedEmployeeIds;
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
    if (_filteredStats != null) {
      return _filteredStats!.totalBookingsPerService;
    }
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
    if (employeeId == null) {
      _selectedEmployeeIds = [];
    } else {
      if (_selectedEmployeeIds.contains(employeeId)) {
        _selectedEmployeeIds.remove(employeeId);
      } else {
        _selectedEmployeeIds.add(employeeId);
      }
    }
    notifyListeners();
  }

  Statistics filteredByDate(DateTime? initDate, DateTime? endDate) {
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
    if (initDate == null || endDate == null) {
      _filteredStats = _originalStats;
      _initDate = null;
      _endDate = null;
      notifyListeners();
      return _filteredStats!;
    }
    List<Progress> filteredProgress =
        _originalStats!.progress.where((p) {
          final date = DateTime.parse(p.date);
          return date.isAfter(initDate.subtract(Duration(days: 1))) &&
              date.isBefore(endDate.add(Duration(days: 1)));
        }).toList();

    _filteredStats = Statistics(
      totalBookings: _originalStats!.totalBookings,
      totalBilledAmount: _originalStats!.totalBilledAmount,
      employeeId: _originalStats!.employeeId,
      serviceId: _originalStats!.serviceId,
      progress: filteredProgress,
      totalBookingsPerEmployee: _originalStats!.totalBookingsPerEmployee,
      totalBookingsByStatus: _originalStats!.totalBookingsByStatus,
      totalBookingsPerService: _originalStats!.totalBookingsPerService,
      totalBookingsPerPlatform: _originalStats!.totalBookingsPerPlatform,
    );

    _initDate = initDate;
    _endDate = endDate;
    notifyListeners();
    return _filteredStats!;
  }

  void filteredByServices(List<String> services) {
    if (_originalStats == null) return;

    _selectedServices = List<String>.from(services);
    
    if (services.isEmpty) {
      _filteredStats = _originalStats;
    } else {
      Map<String, int> filteredServices = {};
      for (var service in services) {
        if (_originalStats!.totalBookingsPerService.containsKey(service)) {
          filteredServices[service] = _originalStats!.totalBookingsPerService[service]!;
        }
      }

      _filteredStats = Statistics(
        totalBookings: _originalStats!.totalBookings,
        totalBilledAmount: _originalStats!.totalBilledAmount,
        employeeId: _originalStats!.employeeId,
        serviceId: services.isNotEmpty ? int.parse(services.first) : 0,
        progress: _originalStats!.progress,
        totalBookingsPerEmployee: _originalStats!.totalBookingsPerEmployee,
        totalBookingsByStatus: _originalStats!.totalBookingsByStatus,
        totalBookingsPerService: filteredServices,
        totalBookingsPerPlatform: _originalStats!.totalBookingsPerPlatform,
      );
    }

    notifyListeners();
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
      _selectedEmployeeIds = [];
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
    _selectedEmployeeIds = [employeeId];
    notifyListeners();
    return _filteredStats!;
  }
}
