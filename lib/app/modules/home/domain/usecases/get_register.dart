import 'package:faker/faker.dart';

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
    var faker = Faker();
    final result = await repository.getRegisters();

    final d = result
        .asMap()
        .entries
        .map((entry) => entry.value.copyWith(fields: {
              'row': entry.key,
              'name': faker.person.name(),
              'email': faker.internet.email(),
            }))
        .toList();

    await localRepository.registerLocal(d);
    return d;
  }
}
