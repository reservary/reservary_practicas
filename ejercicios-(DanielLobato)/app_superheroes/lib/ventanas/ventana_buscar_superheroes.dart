import 'package:app_superheroes/datos/modelo/superhero_datil_response.dart';
import 'package:app_superheroes/datos/modelo/superhero_responese.dart';
import 'package:app_superheroes/datos/repositorio.dart';
import 'package:app_superheroes/ventanas/ventana_detalles_superheroe.dart';
import 'package:flutter/material.dart';

class VentanaBuscarSuperheroes extends StatefulWidget {
  const VentanaBuscarSuperheroes({super.key});

  @override
  State<VentanaBuscarSuperheroes> createState() => _VentanaBuscarSuperheroesState();
}

class _VentanaBuscarSuperheroesState extends State<VentanaBuscarSuperheroes> {
  Future<SuperheroResponse?>? _superheroInfo;
  Repositorio _repositorio = Repositorio();
  bool _textoVacio = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buscar Superheroes"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Buscar Superheroes",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder()),
                onChanged: (text){
                  setState(() {
                    _textoVacio = text.isEmpty;
                    _superheroInfo = _repositorio.fetchSuperheroInfo(text);
                  });
                }),
          ),
          bodyList(_textoVacio)
        ],

      ),
    );

  }

  FutureBuilder<SuperheroResponse?> bodyList(bool textoVacio){
    return FutureBuilder(
      future: _superheroInfo, 
      builder: (context, snapshot) {
        if(textoVacio) return Center(child: Text("Introduce un nombre"));
            if(snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              var superheroList = snapshot.data?.result;
              return Expanded(
                child: ListView.builder(itemCount: superheroList?.length ?? 0,
                itemBuilder: (context, index){
                  if(superheroList != null){
                    return itemSuperhero(superheroList[index]);
                  }else{
                    return Text("Error");
                  }
                }),
              );
            }else{
              return Text("No se encontró información");
            }
          });
  }

  Padding itemSuperhero(SuperheroDetailResponse item) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => VentanaDetallesSuperheroe(superhero: item))),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.red), 
        child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(item.url, height: 250,
                width: double.infinity, 
                fit: BoxFit.cover,
                alignment: Alignment(0, -0.6),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(item.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),),
              ),
            ],
          ),
      ),
    ),
  );
}