import '../../../../../commons/adapters/http_client/http_client_adapter.dart';
import '../../models/register_model.dart';
import '../../repositories/datasources/register_datasource_interface.dart';

class RegisterDatasource implements IRegisterDatasource {
  final IHttpClientAdapter client;

  RegisterDatasource(this.client);

  @override
  Future<List<RegisterModel>> getRegisters() async {
    try {
      final response = await client.get('/test');
      final result = (response.data as List).map((e) {
        return RegisterModel.fromMap(e);
      }).toList();

      return result;
    } catch (e) {
      return [];
    }
  }
}
