import '../entities/register_entity.dart';
import '../repositories/register_repository_interface.dart';

class GetRegisterPerPage {
  final IRegisterRepository repository;

  GetRegisterPerPage(this.repository);

  Future<List<RegisterEntity>> call(int page) async {
    final result = await repository.getRegistersPerPage(page);
    return result;
  }
}
