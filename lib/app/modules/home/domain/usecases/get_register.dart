import '../entities/register_entity.dart';
import '../repositories/register_repository_interface.dart';

class GetRegister {
  final IRegisterRepository repository;

  GetRegister(this.repository);

  Future<List<RegisterEntity>> call() async {
    final result = await repository.getRegisters();
    return result;
  }
}
