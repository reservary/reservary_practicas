import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'Calculadora de Edad',
      theme:ThemeData(
        primarySwatch:Colors.blue,
      ),
      home:MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState()=>_MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage>{
  final TextEditingController _controller=TextEditingController();
  String _result='';
  void _calcularEdad(){
    int anioNacimiento=int.parse(_controller.text);
    if(anioNacimiento!=null){
      int anioActual=2025;
      int edad=anioActual-anioNacimiento;
      setState((){
        _result='Tu edad actual es: $edad años';
      });
    }else{
      setState((){
        _result='El año de nacimiento introducido no es válido.';
      });
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:Text('CALCULADORA DE EDAD'),
        centerTitle:true,
        titleTextStyle: TextStyle(color:const Color.fromARGB(255, 207, 1, 248),fontSize: 40,),

      ),
      body:Padding(
        padding:const EdgeInsets.all(16.0),
        child:Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children:<Widget>[
            TextField(
              controller:_controller,
              decoration:InputDecoration(
                labelText:'Introduce tu año de nacimiento',
              ),
              keyboardType:TextInputType.number,
            ),
            SizedBox(height:20),
            ElevatedButton(
              onPressed:_calcularEdad,
              child:Text('Calcular Edad',style:TextStyle(color:const Color.fromARGB(255, 207, 1, 248),fontSize: 20,)),
            ),
            SizedBox(height:20),
            Text(
              _result,
              style:TextStyle(fontSize:20),
            ),
          ],
        ),
      ),
    );
  }
}
