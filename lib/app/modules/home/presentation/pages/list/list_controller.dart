import 'package:flutter/cupertino.dart';

import '../../../domain/entities/register_entity.dart';
import '../../../domain/usecases/search_local_database.dart';

class ListController {
  final SearchLocalDatabase searchLocalDatabase;

  ListController({required this.searchLocalDatabase}) {
    load();
  }

  ValueNotifier<bool> loading = ValueNotifier(false);
  ValueNotifier<List<RegisterEntity>> list = ValueNotifier([]);

  load() {
    loading.value = true;
    searchLocalDatabase().then((value) {
      list.value = value.toList();
    }).then((value) => loading.value = false);
  }
}
