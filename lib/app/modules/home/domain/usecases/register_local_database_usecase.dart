import 'package:faker/faker.dart';

import '../entities/register_entity.dart';
import '../repositories/local_register_repository.dart';

class RegisterLocalDatabaseUsecase {
  final ILocalRegisterRepository localRepository;

  RegisterLocalDatabaseUsecase({
    required this.localRepository,
  });

  Future call(List<RegisterEntity> registers) async {
    var faker = Faker();
    final d = registers
        .asMap()
        .entries
        .map((entry) => entry.value.copyWith(fields: {
              'row': entry.key,
              'name': faker.person.name(),
              'email': faker.internet.email(),
            }))
        .toList();

    await localRepository.registerLocal(d);
  }
}
