import 'dart:async';

import 'package:hive/hive.dart';
import 'package:hive_discovery/app/modules/home/infra/repositories/models/register_model.dart';
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

  Future clear() async {
    final box = await completer.future;
    await box.clear();
  }

  @override
  Future add(List<RegisterModel> registers) async {
    final model =
        registers.map((e) => RegisterModelDatabase.fromModel(e)).toList();

    final box = await completer.future;

    box.add(model);
  }

  @override
  Future<List<RegisterModel>> get() async {
    final box = await completer.future;
    final result = (box.values.first as List)
        .map<RegisterModelDatabase>((e) => e)
        .toList();

    return result.map((e) {
      return e.toModel();
    }).toList();
  }
}
