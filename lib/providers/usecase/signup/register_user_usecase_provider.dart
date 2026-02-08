import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/register_user_usecase.dart';
import '../../datastore/signup/signup_datastore_provider.dart';

/// RegisterUserUseCaseを提供するProvider
final registerUserUseCaseProvider = Provider<RegisterUserUseCase>((ref) {
  final dataStore = ref.watch(signupDataStoreProvider);
  return RegisterUserUseCase(dataStore);
});
