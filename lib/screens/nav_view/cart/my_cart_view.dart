import 'package:emall/managers/cart_manager/cart_manager.dart';
import 'package:emall/managers/ui_manager/cart_page_manager.dart';
import 'package:emall/screens/nav_view/cart/views/add_new_address_view.dart';
import 'package:emall/screens/nav_view/cart/views/cart_view.dart';
import 'package:emall/screens/nav_view/cart/views/order_flow_view.dart';
import 'package:flutter/material.dart';

class MyCartView extends StatefulWidget {
  const MyCartView({Key? key}) : super(key: key);

  @override
  State<MyCartView> createState() => _MyCartViewState();
}

class _MyCartViewState extends State<MyCartView> {

  int _processIndex = 0;

  @override
  void initState() {
    super.initState();
    cartManager.getCartItemList();
    cartManager.getCartTotal();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int?>(
      stream: cartPageManager.pageIndexStream,
      builder: (context, snapshot) {
        if(snapshot.hasData && snapshot.data != null){
          _processIndex = snapshot.data!;
        }
        switch(_processIndex) {
          case 0: {
            return const CartView();
          }
          case 1: {
            return const OrderFlowView();
          }
          case 2: {
            return const AddNewAddressView();
          }
          default: {
            return const CartView();
          }
        }
      },
    );
  }
}
