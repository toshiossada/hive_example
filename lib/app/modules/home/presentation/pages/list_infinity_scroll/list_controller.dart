import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../commons/adapters/custom_alerts/dialog_adapter.dart';
import '../../../domain/entities/register_entity.dart';
import '../../../domain/usecases/search_local_database.dart';
import 'widgets/filter_widget.dart';

class ListController {
  final SearchLocalDatabase searchLocalDatabase;
  final IDialogAdapter dialog;

  ListController({
    required this.searchLocalDatabase,
    required this.dialog,
  }) {
    load();
  }

  var loading = ValueNotifier(false);
  var list = ValueNotifier(<RegisterEntity>[]);
  var listFiltered = ValueNotifier(<RegisterEntity>[]);
  var filter = '';

  final PagingController<int, RegisterEntity> pagingController =
      PagingController(firstPageKey: 1);

  showFilter() async {
    final filterDialog = await dialog.showDialog<String?>(FilterWidget(
      initialFilter: filter,
    ));
    if (filterDialog == null) return;

    filter = filterDialog;
    if (filter.isEmpty) {
      listFiltered.value = list.value;
    } else if (filter.isNotEmpty) {
      listFiltered.value = list.value
          .where(
            (element) =>
                element.fields['name']
                    .toUpperCase()
                    .contains(filter.toUpperCase()) ||
                element.fields['email']
                    .toUpperCase()
                    .contains(filter.toUpperCase()),
          )
          .toList();
    }
  }

  load() {
    loading.value = true;
    searchLocalDatabase().then((value) {
      list.value = value.toList();
      listFiltered.value = list.value;
    }).then((value) => loading.value = false);
  }
}
