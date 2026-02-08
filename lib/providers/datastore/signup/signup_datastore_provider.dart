import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/signup/datastore/signup_datastore.dart';
import '../../core/api_client_provider.dart';

/// SignupDataStoreを提供するProvider
final signupDataStoreProvider = Provider<SignupDataStore>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return SignupDataStore(apiClient);
});
