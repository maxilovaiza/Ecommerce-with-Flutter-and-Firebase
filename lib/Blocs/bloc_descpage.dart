import 'dart:async';
class CounterBase{}
class IncrementCounter extends CounterBase{}
class DecresCounter extends CounterBase{}

class CounterBlock{
  int _count = 1;
  StreamController<CounterBase> _input = StreamController();
  StreamController<int> _ouput = StreamController();

  Stream<int> get counterStream => _ouput.stream;
  StreamSink<CounterBase> get sendEvent => _input.sink;
  CounterBlock(){
    _input.stream.listen(_onEvent);
  }

  void dispose(){
    _input.close();
    _ouput.close();
  }

  void _onEvent(CounterBase event){
    if(event is IncrementCounter){
      _count++;
    }else{
      if(_count>1) {
        _count--;
      }else {
        _count = 1;
      }

    }
    _ouput.add(_count);

  }
}