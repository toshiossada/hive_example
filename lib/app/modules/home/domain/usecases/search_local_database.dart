import '../entities/register_entity.dart';
import '../repositories/local_register_repository.dart';

class SearchLocalDatabase {
  final ILocalRegisterRepository localRepository;

  SearchLocalDatabase({
    required this.localRepository,
  });

  Future<List<RegisterEntity>> call({
    int pageSize = 0,
    int currentPage = 1,
    Map<String, dynamic>? filter,
  }) async {
    final result = await localRepository.get(
      pageSize: pageSize,
      currentPage: currentPage,
      filter: filter,
    );

    return result;
  }
}
