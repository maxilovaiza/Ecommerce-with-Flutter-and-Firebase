class Productos {
  final String idproductos;
  final int subprecio;
  final int total;


  Productos({ this.subprecio,this.idproductos,this.total});

  Map<String, dynamic> toMap() {
    return {
      'producto':idproductos,
      'subprecio': subprecio,
    };
}


}