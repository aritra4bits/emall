import 'dart:async';
import 'package:rxdart/rxdart.dart';

class OrderFlowManager{
  final _pageIndex = BehaviorSubject<int?>();
  Stream<int?> get pageIndexStream => _pageIndex.stream;
  StreamSink<int?> get pageIndexSink => _pageIndex.sink;

  updatePageIndex(int index){
    pageIndexSink.add(index);
  }

  reset(){
    pageIndexSink.add(null);
  }

  dispose(){
    _pageIndex.close();
  }
}

final OrderFlowManager orderFlowManager = OrderFlowManager();