import 'package:emall/models/user_model/user_model.dart';
import 'package:rxdart/rxdart.dart';


class AddressManager{

  final _editAddressController = BehaviorSubject<Address?>();
  Stream<Address?> get editAddress => _editAddressController.stream;

  setEditAddress(Address address){
    _editAddressController.sink.add(address);
  }


  Address? getEditAddress(){
    return _editAddressController.value;
  }


  dispose(){
    _editAddressController.close();
  }

  resetData(){
    _editAddressController.sink.add(null);
  }
}

final AddressManager addressManager = AddressManager();