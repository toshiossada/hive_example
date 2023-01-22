import '../entities/register_entity.dart';

abstract class ILocalRegisterRepository {
  Future registerLocal(List<RegisterEntity> registers);
  Future clear();
  Future<List<RegisterEntity>> get();
}
