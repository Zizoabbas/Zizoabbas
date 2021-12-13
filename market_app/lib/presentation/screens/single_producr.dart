import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/data/models/product.dart';
import 'package:market_app/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:market_app/logic/blocs/cart_bloc/cart_bloc.dart';
import 'package:market_app/logic/blocs/products_bloc/product_bloc.dart';
import 'package:market_app/logic/providers/cart_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  int index;
  ProductDetailScreen({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _ProductsBloc = BlocProvider.of<ProductsBloc>(context);
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(loadedProduct.title),
        // ),
        body: SafeArea(child:
            BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
      if (state is ProductsLoaded) {
        List<Product> products = state.productsList;
        return Column(
          children: [
            CustomScrollView(
              shrinkWrap: true,
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(products[index].name),
                    background: Hero(
                      tag: products[index].id!,
                      child: Image.network(
                        products[index].imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(height: 10),
                      Text(
                        '\$${products[index].price}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        child: Text(
                          "${products[index].description}",
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                var isContained = RepositoryProvider.of<CartProvider>(context)
                    .items
                    .containsKey(products[index].id!);

                return IconButton(
                    onPressed: () {
                      if (isContained) {
                        BlocProvider.of<CartBloc>(context)
                            .add(RemoveProductFromCart(products[index].id!));
                      } else {
                        BlocProvider.of<CartBloc>(context)
                            .add(AddProductToCart(products[index]));
                      }
                    },
                    icon: Icon(
                      Icons.shopping_cart,
                      color: isContained ? Colors.red : null,
                    ));
                return Container();
              },
            )
          ],
        );
      }
      return Container();
    })));
  }
}
