part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductWishListButtonEvent extends HomeEvent {
  final ProductDataModel product;
  HomeProductWishListButtonEvent({required this.product});
  
}

class HomeProductCartButtonEvent extends HomeEvent {
  final ProductDataModel product;
  HomeProductCartButtonEvent({required this.product});
}

class HomeWishListButtonNavigateEvent extends HomeEvent {}

class HomeCartButtonNavigateEvent extends HomeEvent {}
