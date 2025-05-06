// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/data_source/online_data_source.dart' as _i391;
import '../../features/auth/data/data_source_impl/online_data_source_impl.dart'
    as _i161;
import '../../features/auth/presentation/viewmodels/auth_view_model.dart'
    as _i308;
import '../../features/demand/data/data_source/online_data_source.dart'
    as _i1026;
import '../../features/demand/data/data_source_impl/online_data_source_impl.dart'
    as _i388;
import '../../features/demand/presentation/viewmodels/demand_view_model.dart'
    as _i837;
import '../../features/home/data/data_source/online_data_source.dart' as _i916;
import '../../features/home/data/data_source_impl/online_data_source_impl.dart'
    as _i685;
import '../../features/home/presentation/viewmodels/home_view_model.dart'
    as _i514;
import '../../features/inventory/data/data_source/online_data_source.dart'
    as _i550;
import '../../features/inventory/data/data_source_impl/online_data_source_impl.dart'
    as _i366;
import '../../features/inventory/presentation/view_models/inventory_view_model.dart'
    as _i326;
import '../../features/profiles/data/data_source/online_data_source.dart'
    as _i301;
import '../../features/profiles/data/data_source_impl/online_data_source_impl.dart'
    as _i771;
import '../../features/profiles/presentation/view_models/profile_view_model.dart'
    as _i174;
import '../../features/shop/data/data_source/online_data_source.dart' as _i958;
import '../../features/shop/data/data_source_impl/online_data_source_impl.dart'
    as _i690;
import '../../features/shop/presentation/viewmodels/shop_view_model.dart'
    as _i993;
import '../network/api/api_manager.dart' as _i561;
import '../network/api/network_module.dart' as _i138;
import '../providers/token_provider.dart' as _i924;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.factory<_i924.TokenProvider>(() => _i924.TokenProvider());
    gh.lazySingleton<_i361.Dio>(() => dioModule.provideDio());
    gh.singleton<_i561.ApiManager>(
      () => _i561.ApiManager(gh<_i361.Dio>(), gh<_i924.TokenProvider>()),
    );
    gh.factory<_i958.OnlineDataSource>(
      () => _i690.OnlineDataSourceImpl(gh<_i561.ApiManager>()),
    );
    gh.factory<_i391.OnlineDataSource>(
      () => _i161.OnlineDataSourceImpl(gh<_i561.ApiManager>()),
    );
    gh.factory<_i301.OnlineDataSource>(
      () => _i771.OnlineDataSourceImpl(gh<_i561.ApiManager>()),
    );
    gh.factory<_i1026.OnlineDataSource>(
      () => _i388.OnlineDataSourceImpl(gh<_i561.ApiManager>()),
    );
    gh.factory<_i550.OnlineDataSource>(
      () => _i366.OnlineDataSourceImpl(gh<_i561.ApiManager>()),
    );
    gh.factory<_i326.InventoryViewModel>(
      () => _i326.InventoryViewModel(gh<_i550.OnlineDataSource>()),
    );
    gh.factory<_i837.DemandViewModel>(
      () => _i837.DemandViewModel(gh<_i1026.OnlineDataSource>()),
    );
    gh.factory<_i993.ShopViewModel>(
      () => _i993.ShopViewModel(gh<_i958.OnlineDataSource>()),
    );
    gh.factory<_i308.AuthViewModel>(
      () => _i308.AuthViewModel(gh<_i391.OnlineDataSource>()),
    );
    gh.factory<_i174.ProfileViewModel>(
      () => _i174.ProfileViewModel(gh<_i301.OnlineDataSource>()),
    );
    gh.factory<_i916.OnlineDataSource>(
      () => _i685.OnlineDataSourceImpl(gh<_i561.ApiManager>()),
    );
    gh.factory<_i514.HomeViewModel>(
      () => _i514.HomeViewModel(gh<_i916.OnlineDataSource>()),
    );
    return this;
  }
}

class _$DioModule extends _i138.DioModule {}
