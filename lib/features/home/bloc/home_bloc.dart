import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_bloc_app/data/grocery_data.dart';
import 'package:social_bloc_app/features/home/models/home_product_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishListButtonEvent>(homeProductWishListButtonEvent);
    on<HomeProductCartButtonEvent>(homeProductCartButtonEvent);
    on<HomeWishListButtonNavigateEvent>(homeWishListButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }

  FutureOr<void> homeProductCartButtonEvent(
      HomeProductCartButtonEvent event, Emitter<HomeState> emit) {
    print('HomeProduct -> CartButtonEvent');
  }

  FutureOr<void> homeProductWishListButtonEvent(
      HomeProductWishListButtonEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState());
    print('HomeProduct -> WishListButtonEvent');
    emit(HomeLoadedSuccessState(
      products: GroceryData.groceryData
          .map((e) => ProductDataModel.fromJson(e))
          .toList(),
    ));
  }

  FutureOr<void> homeWishListButtonNavigateEvent(
      HomeWishListButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Home -> WishListButtonNavigateEvent');
    emit(HomeNavigateToWishListActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Home -> CartButtonNavigateEvent');
    emit(HomeNavigateToCartActionState());
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(
      HomeLoadedSuccessState(
        products: GroceryData.groceryData
            .map((e) => ProductDataModel.fromJson(e))
            .toList(),
      ),
    );
  }
}
