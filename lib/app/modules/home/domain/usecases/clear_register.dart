import '../repositories/local_register_repository.dart';

class ClearRegisters {
  final ILocalRegisterRepository localRepository;

  ClearRegisters({
    required this.localRepository,
  });

  Future call() async {
    final _ = await localRepository.clear();
  }
}
