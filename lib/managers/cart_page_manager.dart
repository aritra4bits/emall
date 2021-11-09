import 'dart:async';
import 'package:rxdart/rxdart.dart';

class CartPageManager{
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

final CartPageManager cartPageManager = CartPageManager();