import 'package:flutter/material.dart';

class ComparadorImagenes extends StatefulWidget {
  final double escala;
  const ComparadorImagenes({super.key, this.escala = 1.0});

  @override
  State<ComparadorImagenes> createState() => _ComparadorImagenesState();
}

class _ComparadorImagenesState extends State<ComparadorImagenes> {
  final ImageProvider _imagen1 = AssetImage('assets/imagenes/fuerte.png');
  final ImageProvider _imagen2 = AssetImage('assets/imagenes/gordo.png');

  double _posicion = 0.5;
  Size? _tamanioImagen;

  @override
  void initState() {
    super.initState();
    _obtenerTamanioImagen(_imagen1);
  }

  void _obtenerTamanioImagen(ImageProvider provider) {
    final ImageStream stream = provider.resolve(const ImageConfiguration());
    late ImageStreamListener listener;
    listener = ImageStreamListener((ImageInfo info, bool _) {
      final size = Size(info.image.width.toDouble(), info.image.height.toDouble());
      setState(() {
        _tamanioImagen = size;
      });
      stream.removeListener(listener);
    });
    stream.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    if (_tamanioImagen == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final ancho = _tamanioImagen!.width * widget.escala;
    final alto = _tamanioImagen!.height * widget.escala;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: ancho,
          height: alto,
          child: Stack(
            children: [
              Image(
                image: _imagen1,
                width: ancho,
                height: alto,
                fit: BoxFit.fill,
              ),
              ClipRect(
                child: Align(
                  alignment: Alignment.centerLeft,
                  widthFactor: _posicion,
                  child: Image(
                    image: _imagen2,
                    width: ancho,
                    height: alto,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                left: _posicion * ancho - 12,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      double nuevaPos = (_posicion * ancho + details.delta.dx) / ancho;
                      _posicion = nuevaPos.clamp(0.0, 1.0);
                    });
                  },
                  child: Container(
                    width: 24,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Container(
                      width: 3,
                      height: alto,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
