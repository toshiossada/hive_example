import '../models/register_model.dart';

abstract class IRegisterLocalDatasource {
  Future<List<RegisterModel>> get();
  Future add(List<RegisterModel> registers);
  Future clear();
}
