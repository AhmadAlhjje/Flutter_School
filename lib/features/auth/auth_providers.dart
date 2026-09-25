import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/network_providers.dart';
import 'data/auth_repository_impl.dart';
import 'domain/entities/student_account.dart';
import 'domain/repositories/auth_repository.dart';

/// Feature composition: binds the domain contract to its data implementation.
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    api: ref.watch(apiClientProvider),
    tokens: ref.watch(tokenStoreProvider),
    device: ref.watch(deviceIdentityProvider),
    secure: ref.watch(secureStoreProvider),
  ),
);

final publicConfigProvider = FutureProvider<PublicConfig>((ref) => ref.watch(authRepositoryProvider).publicConfig());
