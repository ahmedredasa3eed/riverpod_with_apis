import 'package:go_shop/entities/snack_bar_entity.dart';
import 'package:go_shop/model/auth/auth_model.dart';
import 'package:go_shop/model/categories/categories_api_response.dart';
import 'package:go_shop/network/auth_services.dart';
import 'package:go_shop/network/categories_services.dart';
import 'package:go_shop/view_models/categories_view_model.dart';
import 'package:go_shop/view_models/login_view_model.dart';
import 'package:go_shop/view_models/splash_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


/// Login View Provider
final loginViewModelProvider = ChangeNotifierProvider<LoginViewModel>(
        (ref) => LoginViewModel(ref.read));

/// Login Status
final userAuthStatusProvider = StateProvider<Auth>((ref) => Auth());

/// Login Services Provider
final userAuthNotifier = ChangeNotifierProvider<AuthServices>((ref) => AuthServices());


/// Splash View Provider
final splashProvider = ChangeNotifierProvider<SplashChangeNotifier>((_) => SplashChangeNotifier());

/// Snack bar provider
final snackBarStateProvider = StateProvider<SnackBarEntity>(
  (_) => SnackBarEntity.initial(),
);

/// Loading provider
final loadingStateProvider = StateProvider<bool>((_) => false);

/// Loading Button provider
final loadingButtonStateProvider = StateProvider<bool>((_) => false);


/// Categories Response api status Services Provider
final categoriesResponseStatusProvider = StateProvider<CategoriesApiResponse>((ref) => CategoriesApiResponse());


/// Categories Data Provider
final categoriesServiceProvider = ChangeNotifierProvider<CategoriesServices>((ref) => CategoriesServices());


final categoriesProvider = ChangeNotifierProvider<CategoriesViewModel>(
        (ref) => CategoriesViewModel(ref.read));