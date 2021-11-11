import 'package:flutter/material.dart';

class StoreFilterWidget extends StatelessWidget {
  final String? value;
  final Function(String?)? onChanged;
  const StoreFilterWidget({Key? key, this.value, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF1592E6),),
      iconSize: 24,
      elevation: 16,
      isDense: true,
      style: const TextStyle(color: Color(0xFF1592E6)),
      underline: const SizedBox(),
      onChanged: onChanged,
      items: <String>['Popularity', 'Featured', 'New Arrivals']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
