import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_bloc_app/features/cart/ui/cart.dart';
import 'package:social_bloc_app/features/home/bloc/home_bloc.dart';
import 'package:social_bloc_app/features/home/ui/product_tile_widget.dart';
import 'package:social_bloc_app/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (previous, current) {
          return current is HomeActionState;
        },
        buildWhen: (previous, current) {
          return current is! HomeActionState;
        },
        listener: (context, state) {
          if (state is HomeNavigateToWishListActionState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Wishlist()));
          } else if (state is HomeNavigateToCartActionState) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Cart()));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (HomeLoadingState):
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case const (HomeLoadedSuccessState):
              final products = (state as HomeLoadedSuccessState).products;
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Grocery Bloc'),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite),
                      onPressed: () {
                        homeBloc.add(HomeWishListButtonNavigateEvent());
                      },
                    ),
                  ],
                ),
                body: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductTileWidget(product: product);
                  },
                ),
              );
            default:
              return const Scaffold();
          }
        });
  }
}
