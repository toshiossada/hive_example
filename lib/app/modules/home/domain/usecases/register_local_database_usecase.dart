import '../entities/register_entity.dart';
import '../repositories/local_register_repository.dart';

class RegisterLocalDatabaseUsecase {
  final ILocalRegisterRepository localRepository;

  RegisterLocalDatabaseUsecase({
    required this.localRepository,
  });

  Future call(List<RegisterEntity> registers) async {
    final d = registers
        .asMap()
        .entries
        .map((entry) => entry.value.copyWith(fields: {'row': entry.key}))
        .toList();

    await localRepository.registerLocal(d);
  }
}
