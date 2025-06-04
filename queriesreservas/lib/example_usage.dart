import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'services/mongo_service.dart';

class ExampleUsage {
  static String formatTimestamp(dynamic timestamp) {
    try {
      final milliseconds = int.parse(timestamp.toString());
      return DateTime.fromMillisecondsSinceEpoch(milliseconds).toString();
    } catch (e) {
      return timestamp.toString();
    }
  }

  static void printReservas(List<Map<String, dynamic>> reservas, String titulo) {
    print('\n=== $titulo ===');
    if (reservas.isEmpty) {
      print('No se encontraron reservas');
      return;
    }
    
    for (var reserva in reservas) {
      print('\n----------------------------------------');
      print('ID de Reserva: ${reserva['bookingId']}');
      print('Estado: ${reserva['status']}');
      print('Fecha: ${formatTimestamp(reserva['timestamp'])}');
      print('Datos del Cliente:');
      
      // Mostrar datos del usuario
      if (reserva['userData'] != null) {
        for (var userData in reserva['userData']) {
          print('  ${userData['name']}: ${userData['value']}');
        }
      }
      
      print('----------------------------------------');
    }
    print('\nTotal de reservas encontradas: ${reservas.length}');
    print('========================================\n');
  }

  static Future<void> main() async {
    try {
      // Connect to MongoDB
      await MongoService.connect();

      // Read bookings.json file
      final jsonPath = r'C:\Users\Luis P\dev\Reservary\Reservas\bookings.json';
      print('Buscando archivo en: $jsonPath');
      
      final file = File(jsonPath);
      if (!await file.exists()) {
        throw Exception('El archivo bookings.json no existe en la ruta: $jsonPath');
      }
      
      final jsonString = await file.readAsString();
      final List<dynamic> reservas = json.decode(jsonString);

      // Insert each reservation into MongoDB
      for (var reserva in reservas) {
        await MongoService.insertData(reserva);
      }

      // 1. Query for anthares_barber reservations
      /*
      print('\n1. Buscando reservas de Anthares Barber...');
      final antaresReservas = await MongoService.queryData({
        'companyId': 'anthares_barber'
      });
      printReservas(antaresReservas, 'RESERVAS DE ANTHARES BARBER');
      */

      // 2. Query for reservations on January 5th, 2024
      print('\n2. Buscando reservas del 5 de enero de 2024...');
      
      // Fechas para el 5 de enero de 2024
      final fechaInicio = DateTime(2024, 1, 5, 0, 0);
      final fechaFin = DateTime(2024, 1, 6, 0, 0);
      
      final reservasDia = await MongoService.queryData({
        'timestamp': {
          '\$gte': fechaInicio.millisecondsSinceEpoch,
          '\$lt': fechaFin.millisecondsSinceEpoch
        }
      });
      printReservas(reservasDia, 'RESERVAS DEL 5 DE ENERO DE 2024');

      // 3. Query for created reservations
      /*
      print('\n3. Buscando reservas creadas...');
      final reservasCreadas = await MongoService.queryData({
        'status': 'created'
      });
      printReservas(reservasCreadas, 'RESERVAS CREADAS');
      */

      // 4. Query for reservations with specific phone number
      /*
      print('\n4. Buscando reservas con teléfono específico...');
      final reservasTelefono = await MongoService.queryData({
        'userData': {
          '\$elemMatch': {
            'name': 'Teléfono',
            'value': '686785941'
          }
        }
      });
      printReservas(reservasTelefono, 'RESERVAS CON TELÉFONO ESPECÍFICO');
      */

      // Disconnect from MongoDB
      await MongoService.disconnect();
    } catch (e) {
      print('Error in example: $e');
    }
  }
} 