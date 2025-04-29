import 'package:flutter/material.dart';
import 'package:videogames_search/data/model/videogame_detail.dart';
import 'package:videogames_search/data/model/videogames_response.dart';
import 'package:videogames_search/data/repository.dart';
import 'package:videogames_search/screens/videogame_detail_screen.dart';

class VideogamesSearchScreen extends StatefulWidget {
  const VideogamesSearchScreen({super.key});

  @override
  State<VideogamesSearchScreen> createState() => _VideogamesSearchScreenState();
}

class _VideogamesSearchScreenState extends State<VideogamesSearchScreen> {
  Future<VideogamesResponse?>? _videogamesResponse;
  Repository repository = Repository();
  bool _isTextEmpty = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Videogames Search'), backgroundColor: Colors.red),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Busca un videojuego",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _isTextEmpty = value.isEmpty;
                  _videogamesResponse = repository.fetchVideogames(value);
                });
              },
            ),
          ),
          bodyList(_isTextEmpty),
        ],
      ),
    );
  }

  FutureBuilder<VideogamesResponse?> bodyList(bool isTextEmpty) {
    return FutureBuilder(
      future: _videogamesResponse,
      builder: (context, snapshot) {
        if (isTextEmpty) return Text("Introduce un videojuego");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error ${snapshot.error}");
        } else if (snapshot.hasData) {
          var videogamesList = snapshot.data?.result;
          return SizedBox(
            height: 600,
            child: ListView.builder(
              itemCount: videogamesList?.length ?? 0,
              itemBuilder: (context, index) {
                if (videogamesList != null) {
                  return itemVideogame(videogamesList[index]);
                } else {
                  return Text("No hay datos");
                }
              },
            ),
          );
        } else {
          return Text("No hay datos");
        }
      },
    );
  }

  Padding itemVideogame(VideogameDetail videogame) => Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
    child: GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideogameDetailScreen(videogame: videogame),
            ),
          ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xFF929191),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                videogame.url,
                height: 300,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                videogame.name,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
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
