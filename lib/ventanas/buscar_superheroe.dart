import 'package:segundoejercicioflutter/datos/modelo/superhero_response.dart';
import 'package:segundoejercicioflutter/datos/modelo/superhero_detail_response.dart';
import 'package:segundoejercicioflutter/datos/repositorio.dart';
import 'package:segundoejercicioflutter/ventanas/ventana_detalles_superheroe.dart';
import 'package:flutter/material.dart';

class VentanaBuscarSuperheroes extends StatefulWidget {
  const VentanaBuscarSuperheroes({super.key});

  @override
  State<VentanaBuscarSuperheroes> createState() =>
      _EstadoVentanaBuscarSuperheroes();
}

class _EstadoVentanaBuscarSuperheroes extends State<VentanaBuscarSuperheroes> {
  Future<RespuestaSuperheroe?>? _infoSuperheroe;
  final Repositorio _repositorio = Repositorio();
  bool _textoVacio = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buscar Superhéroes")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Buscar Superhéroes",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (texto) {
                setState(() {
                  _textoVacio = texto.isEmpty;
                  _infoSuperheroe = _repositorio.obtenerInfoSuperheroe(texto);
                });
              },
            ),
          ),
          construirLista(_textoVacio),
        ],
      ),
    );
  }

  FutureBuilder<RespuestaSuperheroe?> construirLista(bool textoVacio) {
    return FutureBuilder(
      future: _infoSuperheroe,
      builder: (context, snapshot) {
        if (textoVacio) return Center(child: Text("Introduce un nombre"));
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData) {
          var listaSuperheroes = snapshot.data?.resultado;
          return Expanded(
            child: ListView.builder(
              itemCount: listaSuperheroes?.length ?? 0,
              itemBuilder: (context, index) {
                if (listaSuperheroes != null) {
                  return itemSuperhero(listaSuperheroes[index]);
                } else {
                  return Text("Error");
                }
              },
            ),
          );
        } else {
          return Text("No se encontró información");
        }
      },
    );
  }

  Padding itemSuperhero(RespuestaDetalleSuperheroe item) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VentanaDetallesSuperheroe(superhero: item),
            ),
          ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.red,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                item.url,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                alignment: Alignment(0, -0.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.nombre,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
