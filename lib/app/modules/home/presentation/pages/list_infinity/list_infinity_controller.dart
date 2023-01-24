import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../commons/adapters/custom_alerts/dialog_adapter.dart';
import '../../../domain/entities/register_entity.dart';
import '../../../domain/usecases/search_local_database.dart';
import 'widgets/filter_widget.dart';

class ListControllerInfinityScroll {
  final SearchLocalDatabase searchLocalDatabase;
  final IDialogAdapter dialog;

  ListControllerInfinityScroll({
    required this.searchLocalDatabase,
    required this.dialog,
  }) {
    // load();
  }

  var loading = ValueNotifier(false);
  var list = ValueNotifier(<RegisterEntity>[]);
  var pageSize = 10;

  var filter = '';

  PagingController<int, RegisterEntity> pagingController =
      PagingController(firstPageKey: 1);
  getCurrentPage(int currentPage) async {
    await Future.delayed(const Duration(seconds: 2));
    final listCurrentPage = await search(
      pageSize: pageSize,
      currentPage: currentPage,
      filter: filter.isEmpty
          ? null
          : {
              'name': filter,
              'email': filter,
            },
    );
    pagingController.appendPage(listCurrentPage, currentPage + 1);
  }

  Future<List<RegisterEntity>> search({
    int pageSize = 0,
    int currentPage = 1,
    Map<String, dynamic>? filter,
  }) async {
    loading.value = true;
    final result = await searchLocalDatabase(
      pageSize: pageSize,
      currentPage: currentPage,
      filter: filter,
    );
    loading.value = false;

    return result;
  }

  void nextPage(pageKey) {
    getCurrentPage(pageKey);
  }

  showFilter() async {
    final filterDialog = await dialog.showDialog<String?>(FilterWidget(
      initialFilter: filter,
    ));
    if (filterDialog == null) return;

    filter = filterDialog;
    pagingController = PagingController(firstPageKey: 1);
    list.value = [];
    nextPage(1);
  }

  // load({
  //   int pageSize = 0,
  //   int currentPage = 1,
  //   Map<String, dynamic>? filter,
  // }) {
  //   loading.value = true;
  //   searchLocalDatabase(
  //     pageSize: pageSize,
  //     currentPage: currentPage,
  //     filter: filter,
  //   ).then((value) {
  //     list.value = value.toList();
  //     listFiltered.value = list.value;
  //   }).then((value) => loading.value = false);
  // }
}
