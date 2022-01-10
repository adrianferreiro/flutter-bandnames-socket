/*
class Band {
  //le damos unas propiedades
  final id; //va a venir de mi back end
  final name;
  final votes;
  //constructor
  //le ponemos llaves para asignar los nombres a las variables directamente en el constructor
  const Band({required this.id,required this.name, required this.votes});
}

//Factory es un constructor que recibe cierto tipo de argumentos y
//regresa una nueva instancia de mi "Banda" o de mi clase
//se tiene que llamar igual que la clase
//Factory: TIENE COMO OBJETIVO REGRESAR UNA NUEVA INSTANCIA DE MI CLASE
//PERO AL HACERLO DE ESTA MANERA YO PUEDO DEFINIRLO O CREARLO MEDIANTE
//ESTE FRONT MAP, EL CUAL VA A RECIBIR  UN OBJETO QUE TIENE QUE SER DE TIPO MAP
//Y DE ESTA MANERA LE ESTABLEZCO LOS VALORES Y RETORNA UNA NUEVA INSTANCIA DE LA BANDA
factory Band.fromMap(Map<String, dynamic> obj){
  //retornamos una nueva instancia de la banda
 return Band(id: obj['id'], name: obj ['name'], votes: obj ['votes']);
}; 
*/