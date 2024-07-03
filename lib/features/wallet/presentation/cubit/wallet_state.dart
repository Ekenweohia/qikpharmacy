part of 'wallet_cubit.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

class WalletInitial extends WalletState {
  const WalletInitial();
}

class WalletLoading extends WalletState {
  const WalletLoading();
}

class WalletLoaded extends WalletState {
  final Wallet wallet;
  const WalletLoaded(this.wallet);
}

class WalletCreated extends WalletState {
  const WalletCreated();
}

class WalletEmailVerified extends WalletState {
  const WalletEmailVerified();
}

class WalletLoggedIn extends WalletState {
  final Wallet wallet;
  const WalletLoggedIn(this.wallet);
}

class WalletDebited extends WalletState {
  const WalletDebited();
}

class WalletCredited extends WalletState {
  const WalletCredited();
}

class WalletError extends WalletState {
  const WalletError();
}

class WalletLoginError extends WalletState {
  const WalletLoginError();
}
