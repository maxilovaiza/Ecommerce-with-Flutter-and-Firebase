import 'dart:async';
class CounterPedidoBase{}
class IncrementCounter extends CounterPedidoBase{}

class PedidosBlock{
  int _count = 1;
  StreamController<CounterPedidoBase> _input = StreamController();
  StreamController<int> _ouput = StreamController();

  Stream<int> get counterStream => _ouput.stream;
  StreamSink<CounterPedidoBase> get sendEvent => _input.sink;
  PedidosBlock(){
    _input.stream.listen(_onEvent);
  }

  void dispose(){
    _input.close();
    _ouput.close();
  }

  void _onEvent(CounterPedidoBase event){
    if(event is IncrementCounter){
      _count++;
    }
    _ouput.add(_count);

  }
}