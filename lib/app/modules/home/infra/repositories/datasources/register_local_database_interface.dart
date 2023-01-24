import '../../models/register_model.dart';

abstract class IRegisterLocalDatasource {
  Future<List<RegisterModel>> get();
  Future add(List<RegisterModel> registers);
  Future clear();

  Future<List<RegisterModel>> getWhere({
    int pageSize = 0,
    int currentPage = 1,
    Map<String, dynamic>? filter,
  });
}
