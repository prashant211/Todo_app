import 'package:flutter/material.dart';

class RadioWidget extends StatefulWidget {
  const RadioWidget({
    Key? key,
    required this.title,
    required this.categoryColor,
    required this.valueInput,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final Color categoryColor;
  final int valueInput;
  final int groupValue;
  final Function(int?) onChanged;

  @override
  _RadioWidgetState createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Theme(
        data: ThemeData(unselectedWidgetColor: widget.categoryColor),
        child: RadioListTile(
          activeColor: widget.categoryColor,
          contentPadding: EdgeInsets.zero,
          title: Transform.translate(
            offset: const Offset(-22, 0),
            child: Text(
              widget.title,
              style: TextStyle(
                color: widget.categoryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          value: widget.valueInput,
          groupValue: widget.groupValue,
          onChanged: (value) {
            setState(() {
              widget.onChanged(value);
            });
          },
        ),
      ),
    );
  }
}
