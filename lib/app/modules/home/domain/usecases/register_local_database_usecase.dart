import '../entities/register_entity.dart';
import '../repositories/local_register_repository.dart';

class RegisterLocalDatabaseUsecase {
  final ILocalRegisterRepository localRepository;

  RegisterLocalDatabaseUsecase({
    required this.localRepository,
  });

  Future call(List<RegisterEntity> registers) async {
    await localRepository.registerLocal(registers);
  }
}
