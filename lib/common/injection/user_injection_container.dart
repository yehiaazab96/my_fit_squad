import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/user_management/data/data_sources/user_locale_data_source.dart';
import 'package:my_fit_squad/features/user_management/data/data_sources/user_network_data_source.dart';
import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';
import 'package:my_fit_squad/features/user_management/data/repositories/user_repository_impl.dart';
import 'package:my_fit_squad/features/user_management/presentation/view_models/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//User

final userLocalDataSourceProvider = Provider<UserLocaleDataSource>((ref) {
  return UserLocaleDataSource(ref.read(sharedPreferencesProvider));
});

final userNetworkDataSourceProvider = Provider<UserNetworkDataSource>((ref) {
  return UserNetworkDataSource();
});

final userRepositoryProvider = Provider<UserRepositoryImpl>((ref) {
  return UserRepositoryImpl(ref.read(userLocalDataSourceProvider),
      ref.read(userNetworkDataSourceProvider));
});

final userProvider = StateNotifierProvider<UserViewModel, User?>((ref) {
  return UserViewModel(
    ref.read(userRepositoryProvider),
  );
});
