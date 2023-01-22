import 'package:flutter/material.dart';
import 'package:hive_discovery/app/modules/home/domain/entities/register_entity.dart';
import 'package:hive_discovery/app/modules/home/presentation/pages/list_infinity_scroll/list_controller.dart';

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
  ListController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
          valueListenable: controller.list,
          builder: (__, List<RegisterEntity> value, _) {
            return Text('${value.length} Registros');
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              controller.showFilter();
            },
            icon: const Icon(Icons.filter_alt),
          ),
        ],
      ),
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: controller.loading,
            builder: (BuildContext context, bool value, _) {
              if (value) {
                return Visibility(
                  visible: value,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return ValueListenableBuilder(
                    valueListenable: controller.listFiltered,
                    builder: (_, List<RegisterEntity> value, __) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: value.length,
                          itemBuilder: (_, index) {
                            final item = value[index];
                            return ColoredBox(
                                color: index % 2 == 0
                                    ? Colors.green.withOpacity(.3)
                                    : Colors.purple.withOpacity(.3),
                                child: ListTile(
                                  title: Text(item.name),
                                ));
                          },
                        ),
                      );
                    });
              }
            },
          ),
        ],
      ),
    );
  }
}
