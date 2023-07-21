import 'package:cloud_firestore/cloud_firestore.dart';
extension IterableIndexed<E> on Iterable<E> {
  List<T> mapIndexed<T>(T Function(int index, E element) f) {
    int index = 0;
    return map((element) => f(index++, element)).toList();
  }
}
class GraphDots{
    final double x;
    final double y;
    GraphDots({required this.x, required this.y});

 static   List<GraphDots>  graphDots(){
      final data=<double>[1,2,4,5,6];
            return data.mapIndexed((index,element)=>GraphDots(x: index.toDouble(), y: index.toDouble())).toList();
    }
}