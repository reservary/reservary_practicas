import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(41.653380, -4.711395),
    zoom: 18,
  );

  final Set<Marker> _markers = {
    Marker(markerId: MarkerId("Pepito"), position: LatLng(41.653380, -4.711395),infoWindow: InfoWindow(title: "Resturante"))
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Map")),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        onMapCreated: (controller) {
          _controller = controller;
        },
        mapType: MapType.normal,
        markers: _markers,
        onTap: (latLng) => addMarker(latLng),
      ),
    );
  }
  
  void addMarker(LatLng latLong) async{
    TextEditingController _textController= TextEditingController();
    String? title= await showDialog<String>(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Añade un titulo"),
        content: TextField(
          controller: _textController,
          decoration: InputDecoration(hintText: "Restaurante..."),
        ),
        actions: [
          TextButton(onPressed: ()=>Navigator.of(context).pop(null), child: Text("Cancelar")),
          TextButton(onPressed: ()=>Navigator.of(context).pop(_textController.text), child: Text("Guardar")),
        ]
      );
    });
    if(title!=null && title.isNotEmpty){
      setState(() {
        _markers.add(
          Marker(markerId: MarkerId(latLong.toString()),
          position: latLong,infoWindow: InfoWindow(title: title))
        );
      });
    }
  }
}
