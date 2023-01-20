import '../entities/register_entity.dart';
import '../repositories/local_register_repository.dart';
import '../repositories/register_repository_interface.dart';

class GetRegister {
  final IRegisterRepository repository;
  final ILocalRegisterRepository localRepository;

  GetRegister({
    required this.repository,
    required this.localRepository,
  });

  Future<List<RegisterEntity>> call() async {
    final result = await repository.getRegisters();
    await localRepository.registerLocal(result);
    return result;
  }
}
