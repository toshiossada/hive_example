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
    //await box.put('registers', model);
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
}
