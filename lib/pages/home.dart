import 'dart:io';
import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    new Band(id: '1', name: 'Metallica', votes: '5'),
    new Band(id: '2', name: 'Queen', votes: '1'),
    new Band(id: '3', name: 'Héroes del Silencio', votes: '2'),
    new Band(id: '4', name: 'Bon Jovi', votes: '5'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BandNames',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      //el itemBuilder es lo que usamos para crear los elementos de la lista
      body: ListView.builder(
        itemCount: bands
            .length, //realiza en base a la cantidad de elemntos del arreglo
        itemBuilder: (context, index) {
          return _bandTile(
            bands[index],
          ); //arreglo de bands en la posición index
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      //tenemos que poner un identificador único, en este caso usamos el band.id
      key: Key(band.id),
      //definimos a qué dirección queremos que se corra cuando arrastro la opcion de la lista para la izq o derecha
      direction: DismissDirection.startToEnd,
      //onDismissed es un método que se dispara con un argumento, usamos 'direction'
      onDismissed: (DismissDirection direction) {
        //éste método se ejecuta cuando arrastro la opción hasta el final para borrar
        print('direction: $direction');
        print('id: ${band.id}');
        //ToDo: llamar al borrado en el server
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          //acá podemos ingresar cualquier Widget, puede ser por ejemplo el dibujo de un basurero, para eliminar
          alignment: Alignment.centerLeft,
          child: Text('Borrar banda', style: TextStyle(color: Colors.white)),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          //vamos a poner la inicial de la banda tomando del arreglo band
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        //una de las ventajas de trabajar con el modelo porque es fácil poner sus propiedades
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
        //los votos ponemos así porque es un string
      ),
    );
  }

  addNewBand() {
    //para tomar los datos ingresados por el usuario
    final textController = new TextEditingController();
    //preguntar por plataforma
    //asegurarse de importar "PLATFORM" de dart.io (generalmente la segunda opción)
    if (Platform.isAndroid) {
      //ponemos un "return" porque si se ejecuta ésto, ya no quiero continuar
      return showDialog(
          context: context,
          //generalmente cuando hay un builder vamos a retornar un widget
          builder: (context) {
            return AlertDialog(
              title: Text('New band name:'),
              content: TextField(
                //le asignamos el controller que definimos arriba
                controller: textController,
              ),
              actions: <Widget>[
                MaterialButton(
                  child: Text('Add'),
                  elevation: 5,
                  textColor: Colors.blue,
                  onPressed: () => addBandToList(textController.text),
                )
              ],
            );
          });
    }
    showCupertinoDialog(
      //en el context se encuentra todo el árbol de widget y va a saber donde dibujarlo
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text('New band name:'),
          content: CupertinoTextField(
            //podemos usar el mismo textController para recibir lo que ingresa el usuario en la caja de texto
            controller: textController,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              //isDefaultAction: cuando presiona enter en el teclado del cel, dispara la acción
              isDefaultAction: true,
              child: Text('Add'),
              onPressed: () => addBandToList(textController.text),
            ),
            //PARA CERRAR EL DIALOGO, LO SIGUIENTE
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Dismiss'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }

  //definimos un método que no regresa nada (void)
  //recibimos un string que sería en éste caso el nombre de la banda
  void addBandToList(String name) {
    if (name.length > 1) {
      //podemos agregar
      //agregamos la banda
      this.bands.add(
            new Band(id: DateTime.now().toString(), name: name, votes: 0),
          );
      //redibujamos
      setState(() {});
    }
    Navigator.pop(context); //cerramos el cuadro del diálogo en ANDROID
  }
}
