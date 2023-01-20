import '../entities/register_entity.dart';
import '../repositories/local_register_repository.dart';

class SearchLocalDatabase {
  final ILocalRegisterRepository localRepository;

  SearchLocalDatabase({
    required this.localRepository,
  });

  Future<List<RegisterEntity>> call() async {
    final result = await localRepository.get();

    return result;
  }
}
