import 'dart:async';

import 'package:hive/hive.dart';
import 'package:hive_discovery/app/modules/home/infra/models/register_model.dart';
import 'package:path_provider/path_provider.dart';

import '../../repositories/datasources/register_local_database_interface.dart';
import 'models/register_model_database.dart';

class RegisterLocalDatasource implements IRegisterLocalDatasource {
  var completer = Completer<Box>();

  RegisterLocalDatasource() {
    _initDb();
  }

  Future _initDb() async {
    var appDocDirectory = await getApplicationDocumentsDirectory();
    Hive
      ..init(appDocDirectory.path)
      ..registerAdapter(RegisterModelDatabaseAdapter());

    final box = await Hive.openBox('registers');
    if (!completer.isCompleted) completer.complete(box);
  }

  @override
  Future clear() async {
    final box = await completer.future;
    await box.clear();
  }

  @override
  Future add(List<RegisterModel> registers) async {
    final model =
        registers.map((e) => RegisterModelDatabase.fromModel(e)).toList();

    final box = await completer.future;
    await clear();

    await box.addAll(model);
    model.map((e) async => await e.save());
  }

  @override
  Future<List<RegisterModel>> get() async {
    final box = await completer.future;

    //final registers = box.get('registers');
    final registers = box.values.toList();
    final result = registers.map((e) {
      return (e as RegisterModelDatabase).toModel();
    }).toList();

    return result;
  }

  @override
  Future<List<RegisterModel>> getWhere({
    int pageSize = 0,
    int currentPage = 1,
    Map<String, dynamic>? filter,
  }) async {
    final box = await completer.future;
    var values = box.values.toList();
    List<dynamic> filtered = [];
    if (filter != null) {
      filter.forEach((key, value) {
        filtered.addAll(values.where((element) {
          return value.isEmpty || element.fields[key].contains(value);
        }));
      });
      filtered = filtered.toList().unique((x) => x.id);
    } else {
      filtered.addAll(values);
    }

    if (pageSize == 0) {
      return filtered.map((e) {
        return (e as RegisterModelDatabase).toModel();
      }).toList();
    }

    return filtered
        .toList()
        .sublist(pageSize * (currentPage - 1), pageSize * currentPage)
        .map((e) {
      return (e as RegisterModelDatabase).toModel();
    }).toList();
  }
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = <dynamic>{};
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}
