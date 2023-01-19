import '../models/register_model.dart';

abstract class IRegisterDatasource {
  Future<List<RegisterModel>> getRegisters();
}
