import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/barrels/cubits.dart';
import 'package:qik_pharma_mobile/barrels/repositories.dart';
import 'package:qik_pharma_mobile/core/api/dio/dio_client.dart';
import 'package:qik_pharma_mobile/core/repositories/paystack_repository.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/cubit/country/country_cubit.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/cubit/get_company_types/get_company_types_cubit.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/cubit/get_medications/get_medications_cubit.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/cubit/onboarding/onboarding_cubit.dart';
import 'package:qik_pharma_mobile/core/storage/offline_client.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/cubit/registration/sign_up_cubit.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/cubit/reset_password/reset_password_cubit.dart';
import 'package:qik_pharma_mobile/features/auth/presentation/cubit/role/role_cubit.dart';
import 'package:qik_pharma_mobile/features/auth/repository/info_repository.dart';
import 'package:qik_pharma_mobile/features/cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:qik_pharma_mobile/features/cart/presentation/cubit/checkout/checkout_cubit.dart';
import 'package:qik_pharma_mobile/features/cart/presentation/cubit/logistics/logistics_cubit.dart';
import 'package:qik_pharma_mobile/features/cart/repository/cart_repository_impl.dart';
import 'package:qik_pharma_mobile/features/category/presentation/cubit/category_cubit.dart';
import 'package:qik_pharma_mobile/features/category/presentation/cubit/single_category_cubit.dart';
import 'package:qik_pharma_mobile/features/orders/presentation/orders/order_cubit.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/product/deals_of_day/dod_cubit.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/product/product_cubit.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/product/user_products/user_product_cubit.dart';
import 'package:qik_pharma_mobile/features/product/presentation/cubit/region/region_cubit.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/shipping/shipping_cubit.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/user/user_cubit.dart';
import 'package:qik_pharma_mobile/features/profile/repositories/shipping_repository_impl.dart';
import 'package:qik_pharma_mobile/features/settings/presentation/2FA/cubit/two_fa_cubit.dart';
import 'package:qik_pharma_mobile/features/splash/cubit/splash_cubit.dart';
import 'package:qik_pharma_mobile/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:qik_pharma_mobile/features/wallet/repository/wallet_repository_impl.dart';

import 'core/repositories/repositories.dart';

final userRepo = UserRepositoryImpl(
  dioClient: DioClient(),
  offlineClient: OfflineClient(),
);

final authRepo = AuthRepositoryImpl(
  dioClient: DioClient(),
  offlineClient: OfflineClient(),
);

final infoRepo = InfoRepositoryImpl(
  dioClient: DioClient(),
  offlineClient: OfflineClient(),
);

final categoryRepo = CategoryRepositoryImpl(
  dioClient: DioClient(),
  offlineClient: OfflineClient(),
);

final productRepo = ProductRepositoryImpl(
  dioClient: DioClient(),
  offlineClient: OfflineClient(),
);

final cartRepo = CartRepositoryImpl(
  dioClient: DioClient(),
  offlineClient: OfflineClient(),
);

final orderRepo = OrderRepositoryImpl(
  dioClient: DioClient(),
  offlineClient: OfflineClient(),
);

final regionRepo = RegionRepositoryImpl(
  dioClient: DioClient(),
  offlineClient: OfflineClient(),
);

final walletRepo = WalletRepositoryImpl(
  dioClient: DioClient(),
  offlineClient: OfflineClient(),
  userRepositoryImpl: userRepo,
  payStackRepository: PayStackRepository(),
);

final roleRepo = RoleRepositoryImpl(
  dioClient: DioClient(),
  offlineClient: OfflineClient(),
);

final checkoutRepo = CheckoutRepositoryImpl(
  dioClient: DioClient(),
  offlineClient: OfflineClient(),
  payStackRepository: PayStackRepository(),
);

final shippingRepo = ShippingRepositoryImpl(
  dioClient: DioClient(),
  offlineClient: OfflineClient(),
);

final providers = [
  BlocProvider<SplashCubit>(
    create: (context) => SplashCubit(userRepo),
  ),

  BlocProvider<OnboardingCubit>(
    create: (context) => OnboardingCubit(userRepo),
  ),

  BlocProvider<SignUpCubit>(
    create: (context) => SignUpCubit(authRepo),
  ),

  BlocProvider<RoleCubit>(
    create: (context) => RoleCubit(roleRepo)..getRoles(),
  ),

  BlocProvider<LoginCubit>(
    create: (context) => LoginCubit(authRepo),
  ),

  BlocProvider<ResetPasswordCubit>(
    create: (context) => ResetPasswordCubit(authRepo),
  ),

  BlocProvider<OtpVerificationCubit>(
    create: (context) => OtpVerificationCubit(authRepo),
  ),

  BlocProvider<UserCubit>(
    create: (context) => UserCubit(
      userRepo,
      authRepo,
    ),
  ),

  BlocProvider<CountryCubit>(
    create: (context) => CountryCubit(infoRepo),
  ),

  BlocProvider<GetMedicationsCubit>(
    create: (context) => GetMedicationsCubit(infoRepo),
  ),

  BlocProvider<GetCompanyTypesCubit>(
    create: (context) => GetCompanyTypesCubit(infoRepo),
  ),

  BlocProvider<CategoryCubit>(
    create: (context) => CategoryCubit(categoryRepo),
  ),

  BlocProvider<ProductCubit>(
    create: (context) => ProductCubit(productRepo),
  ),

  BlocProvider<DODCubit>(
    create: (context) => DODCubit(productRepo),
  ),

  BlocProvider<SingleCategoryProductsCubit>(
    create: (context) => SingleCategoryProductsCubit(categoryRepo),
  ),

  BlocProvider<CartCubit>(
    create: (context) => CartCubit(cartRepo),
  ),

  BlocProvider<LogisticsCubit>(
    create: (context) => LogisticsCubit(cartRepo),
  ),

  BlocProvider<OrderCubit>(
    create: (context) => OrderCubit(orderRepo),
  ),

  BlocProvider<RegionCubit>(
    create: (context) => RegionCubit(regionRepo),
  ),

  BlocProvider<UserProductCubit>(
    create: (context) => UserProductCubit(productRepo),
  ),

  BlocProvider<WalletCubit>(
    create: (context) => WalletCubit(walletRepo),
  ),

  BlocProvider<CheckoutCubit>(
    create: (context) => CheckoutCubit(checkoutRepo),
  ),

  BlocProvider<ShippingCubit>(
    create: (context) => ShippingCubit(shippingRepo),
  ),

  BlocProvider<SetupTwoFaCubit>(
    create: (context) => SetupTwoFaCubit(userRepo),
  ),

  BlocProvider<ConfirmTwoFaCubit>(
    create: (context) => ConfirmTwoFaCubit(userRepo),
  ),
  // BlocProvider<RetailerCubit>(
  //   create: (context) => RetailerCubit(),
  // ),
  // BlocProvider<RetailerCubit>(
  //   create: (context) => RetailerCubit(),
  // ),
];
