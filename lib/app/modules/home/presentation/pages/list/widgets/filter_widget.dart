import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  final String initialFilter;
  const FilterWidget({
    super.key,
    this.initialFilter = '',
  });

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  late final txtFilter;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    txtFilter = TextEditingController(text: widget.initialFilter);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Não encontrou a palavra?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: txtFilter,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nome',
            ),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(txtFilter.text);
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
