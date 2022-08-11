import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DropdownSelector extends StatelessWidget{
  final String value;
  final String title;
  final List<String> items;
  final void Function(String type) onChange;

  DropdownSelector(
      {Key key,
        @required this.onChange,
        @required this.value,
        @required this.items,
        @required this.title
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              height: 20 / 14,
            )),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButton<String>(
            underline: Container(),
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
            value: value,
            dropdownColor: Theme.of(context).primaryColor,
            onTap: () => FocusManager.instance.primaryFocus.unfocus(),
            onChanged: (_) {
              //setState(() => _value = value);
              onChange(_);
            },
            items: items
                .map((item) => buildDropdownMenuItem(item))
                .toList(),
            isExpanded: true,
          ),
        ),
      ],
    );
  }


  DropdownMenuItem<String> buildDropdownMenuItem(String value) {

    return DropdownMenuItem<String>(
        value: value,
        child: Text(value, style: TextStyle(color: Colors.black))
    );
  }
}
