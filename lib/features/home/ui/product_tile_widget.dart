import 'package:flutter/material.dart';
import 'package:social_bloc_app/features/home/bloc/home_bloc.dart';
import 'package:social_bloc_app/features/home/models/home_product_data_model.dart';

class ProductTileWidget extends StatelessWidget {
  const ProductTileWidget({super.key, required this.product});

  final ProductDataModel product;

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = HomeBloc();
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            spreadRadius: 0.1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: NetworkImage(product.image),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.description,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '\$${product.price}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  homeBloc
                      .add(HomeProductWishListButtonEvent(product: product));
                },
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  homeBloc.add(HomeProductCartButtonEvent(product: product));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
