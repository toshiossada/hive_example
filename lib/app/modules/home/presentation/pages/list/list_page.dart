import 'package:flutter/material.dart';
import 'package:hive_discovery/app/modules/home/domain/entities/register_entity.dart';
import 'package:hive_discovery/app/modules/home/presentation/pages/list/list_controller.dart';

class ListPage extends StatefulWidget {
  final ListController controller;
  const ListPage({
    super.key,
    required this.controller,
  });

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  ListController get controler => widget.controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List'),
      ),
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: controler.loading,
            builder: (BuildContext context, bool value, _) {
              return Visibility(
                visible: value,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: controler.list,
            builder: (BuildContext context, List<RegisterEntity> value, _) {
              return Expanded(
                child: ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = value[index];
                      return ListTile(
                        title: Text(item.name),
                      );
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
}
