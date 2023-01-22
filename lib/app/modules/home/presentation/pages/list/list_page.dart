import 'package:flutter/material.dart';
import 'package:hive_discovery/app/modules/home/domain/entities/register_entity.dart';
import 'package:hive_discovery/app/modules/home/presentation/pages/list/list_controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
    controller.pagingController.addPageRequestListener((pageKey) {
      controller.nextPage(pageKey);
    });
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
                  valueListenable: controller.currentPageData,
                  builder: (__, List<RegisterEntity> value, _) {
                    return Expanded(
                        child: PagedListView<int, RegisterEntity>.separated(
                      pagingController: controller.pagingController,
                      separatorBuilder: (context, index) => const Divider(),
                      builderDelegate:
                          PagedChildBuilderDelegate<RegisterEntity>(
                        animateTransitions: true,
                        // [transitionDuration] has a default value of 250 milliseconds.
                        transitionDuration: const Duration(milliseconds: 500),
                        itemBuilder: (context, item, index) => ColoredBox(
                          color: index % 2 == 0
                              ? Colors.green.withOpacity(.3)
                              : Colors.purple.withOpacity(.3),
                          child: ListTile(
                            title: Text(item.name),
                          ),
                        ),
                      ),
                    ));
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
