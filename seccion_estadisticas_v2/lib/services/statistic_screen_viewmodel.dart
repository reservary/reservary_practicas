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
      final jsonString = await rootBundle.loadString('assets/data/ReservasFiltradasPorIdEmpresa.json');
      final List<dynamic> jsonList = jsonDecode(jsonString);
      
      // Procesar la lista de reservas para crear las estadísticas
      final Map<String, int> bookingsPerPlatform = {};
      final Map<String, int> bookingsPerEmployee = {};
      final Map<String, int> bookingsByStatus = {};
      final Map<String, int> bookingsPerService = {};
      final Map<String, List<dynamic>> bookingsByDate = {};
      
      for (var booking in jsonList) {
        // Procesar plataforma
        final origin = booking['origin'] as String? ?? 'unknown';
        bookingsPerPlatform[origin] = (bookingsPerPlatform[origin] ?? 0) + 1;
        
        // Procesar empleado
        final employeeId = booking['employeeId'] as String? ?? '0';
        bookingsPerEmployee[employeeId] = (bookingsPerEmployee[employeeId] ?? 0) + 1;
        
        // Procesar estado
        final status = booking['status'] as String? ?? 'unknown';
        bookingsByStatus[status] = (bookingsByStatus[status] ?? 0) + 1;
        
        // Agrupar por fecha
        final timestamp = int.tryParse(booking['timestamp']?.toString() ?? '0') ?? 0;
        final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
        final dateStr = date.toIso8601String().split('T')[0];
        if (!bookingsByDate.containsKey(dateStr)) {
          bookingsByDate[dateStr] = [];
        }
        bookingsByDate[dateStr]!.add(booking);
      }
      
      // Crear datos de progreso
      final progress = bookingsByDate.entries.map((entry) {
        return Progress(
          date: entry.key,
          bookings: entry.value.length,
          billedAmount: 0.0,
        );
      }).toList();
      
      _originalStats = Statistics(
        bookingId: '',
        status: '',
        timestamp: '',
        endTimestamp: '',
        userData: [],
        companyId: '',
        employeeId: '0',
        origin: '',
        totalBookings: jsonList.length,
        totalBilledAmount: 0.0,
        serviceId: 0,
        progress: progress,
        totalBookingsPerEmployee: bookingsPerEmployee,
        totalBookingsByStatus: bookingsByStatus,
        totalBookingsPerService: bookingsPerService,
        totalBookingsPerPlatform: bookingsPerPlatform,
      );
      
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
    if (_filteredStats != null) {
      return _filteredStats!.totalBookingsPerPlatform;
    }
    if (_originalStats == null) return {};
    return _originalStats!.totalBookingsPerPlatform;
  }

  Map<String, int> get totalBookingsPerEmployee {
    if (_filteredStats != null) {
      return _filteredStats!.totalBookingsPerEmployee;
    }
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
    if (_filteredStats != null) {
      return _filteredStats!.totalBookingsByStatus;
    }
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

  int dateTimeToTimeStamp(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch;
  }

  List<Progress> get allProgress {
    if (_filteredStats != null) {
      final progress = List<Progress>.from(_filteredStats!.progress);
      progress.sort(
        (a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)),
      );
      return progress;
    }
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

  Future<Statistics> filteredByDate(DateTime? initDate, DateTime? endDate) async {
    if (_originalStats == null) {
      return Statistics(
        bookingId: '',
        status: '',
        timestamp: '',
        endTimestamp: '',
        userData: [],
        companyId: '',
        employeeId: '0',
        origin: '',
        totalBookings: 0,
        totalBilledAmount: 0,
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

    int initTimestamp = dateTimeToTimeStamp(initDate);
    int endTimestamp = dateTimeToTimeStamp(endDate);

    // Cargar los datos originales
    final jsonString = await rootBundle.loadString('assets/data/ReservasFiltradasPorIdEmpresa.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);

    // Inicializar contadores
    final Map<String, int> filteredBookingsPerPlatform = {};
    final Map<String, int> filteredBookingsPerEmployee = {};
    final Map<String, int> filteredBookingsByStatus = {};
    final Map<String, int> filteredBookingsPerService = {};
    final Map<String, List<dynamic>> filteredBookingsByDate = {};
    int totalFilteredBookings = 0;

    // Filtrar y procesar las reservas
    for (var booking in jsonList) {
      final timestamp = int.tryParse(booking['timestamp']?.toString() ?? '0') ?? 0;
      if (timestamp >= initTimestamp && timestamp <= endTimestamp) {
        totalFilteredBookings++;
        
        // Procesar plataforma
        final origin = booking['origin'] as String? ?? 'unknown';
        filteredBookingsPerPlatform[origin] = (filteredBookingsPerPlatform[origin] ?? 0) + 1;
        
        // Procesar empleado
        final employeeId = booking['employeeId'] as String? ?? '0';
        filteredBookingsPerEmployee[employeeId] = (filteredBookingsPerEmployee[employeeId] ?? 0) + 1;
        
        // Procesar estado
        final status = booking['status'] as String? ?? 'unknown';
        filteredBookingsByStatus[status] = (filteredBookingsByStatus[status] ?? 0) + 1;
        
        // Procesar servicio
        final serviceId = booking['serviceId']?.toString() ?? '0';
        filteredBookingsPerService[serviceId] = (filteredBookingsPerService[serviceId] ?? 0) + 1;

        // Agrupar por fecha para el progreso
        final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
        final dateStr = date.toIso8601String().split('T')[0];
        if (!filteredBookingsByDate.containsKey(dateStr)) {
          filteredBookingsByDate[dateStr] = [];
        }
        filteredBookingsByDate[dateStr]!.add(booking);
      }
    }

    // Crear datos de progreso filtrados
    final filteredProgress = filteredBookingsByDate.entries.map((entry) {
      return Progress(
        date: entry.key,
        bookings: entry.value.length,
        billedAmount: 0.0,
      );
    }).toList();

    _filteredStats = Statistics(
      bookingId: _originalStats!.bookingId,
      status: _originalStats!.status,
      timestamp: _originalStats!.timestamp,
      endTimestamp: _originalStats!.endTimestamp,
      userData: _originalStats!.userData,
      companyId: _originalStats!.companyId,
      employeeId: _originalStats!.employeeId,
      origin: _originalStats!.origin,
      totalBookings: totalFilteredBookings,
      totalBilledAmount: _originalStats!.totalBilledAmount,
      serviceId: _originalStats!.serviceId,
      progress: filteredProgress,
      totalBookingsPerEmployee: filteredBookingsPerEmployee,
      totalBookingsByStatus: filteredBookingsByStatus,
      totalBookingsPerService: filteredBookingsPerService,
      totalBookingsPerPlatform: filteredBookingsPerPlatform,
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
        bookingId: _originalStats!.bookingId,
        status: _originalStats!.status,
        timestamp: _originalStats!.timestamp,
        endTimestamp: _originalStats!.endTimestamp,
        userData: _originalStats!.userData,
        companyId: _originalStats!.companyId,
        employeeId: _originalStats!.employeeId,
        origin: _originalStats!.origin,
        totalBookings: _originalStats!.totalBookings,
        totalBilledAmount: _originalStats!.totalBilledAmount,
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
        bookingId: '',
        status: '',
        timestamp: '',
        endTimestamp: '',
        userData: [],
        companyId: '',
        employeeId: '0',
        origin: '',
        totalBookings: 0,
        totalBilledAmount: 0,
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
      bookingId: _originalStats!.bookingId,
      status: _originalStats!.status,
      timestamp: _originalStats!.timestamp,
      endTimestamp: _originalStats!.endTimestamp,
      userData: _originalStats!.userData,
      companyId: _originalStats!.companyId,
      employeeId: _originalStats!.employeeId,
      origin: _originalStats!.origin,
      totalBookings: _originalStats!.totalBookings,
      totalBilledAmount: _originalStats!.totalBilledAmount,
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
