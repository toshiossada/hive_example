import '../entities/register_entity.dart';

abstract class IRegisterRepository {
  Future<List<RegisterEntity>> getRegisters();
}
