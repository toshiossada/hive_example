import '../entities/register_entity.dart';

abstract class ILocalRegisterRepository {
  Future registerLocal(List<RegisterEntity> registers);
  Future<List<RegisterEntity>> get();
}
