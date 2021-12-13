import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/data/models/product.dart';
import 'package:market_app/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:market_app/logic/blocs/cart_bloc/cart_bloc.dart';
import 'package:market_app/logic/blocs/products_bloc/product_bloc.dart';
import 'package:market_app/logic/providers/cart_provider.dart';

import 'package:market_app/presentation/screens/add_product_screen.dart';
import 'package:market_app/presentation/screens/auth_screen.dart';
import 'package:market_app/presentation/screens/cart_screen.dart';
import 'package:market_app/presentation/screens/single_producr.dart';
import 'package:market_app/presentation/widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ProductsBloc = BlocProvider.of<ProductsBloc>(context);

    return Scaffold(
      backgroundColor: Colors.grey,
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Market App"),
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.of(context).pushNamed('/cart_screen');
                Navigator.of(context).pushNamed(
                    BlocProvider.of<AuthBloc>(context).state is Authunticated
                        ? '/cart_screen'
                        : "/auth_screen");
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => BlocProvider.of<AuthBloc>(context)
                //             .state is Authunticated
                //         ? CartScreen()
                //         : AuthScreen(),
                //   ),
                // );
              },
              icon: Icon(
                Icons.shopping_cart,
              ))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<ProductsBloc>(context).add(LoadAllProducts());
        },
        child: BlocBuilder<ProductsBloc, ProductsState>(
          buildWhen: (old, newSteate) {
            return old != newSteate;
          },
          builder: (context, state) {
            if (state is ProductInitial) {
              _ProductsBloc.add(LoadAllProducts());
            } else if (state is ProductsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProductsLoadingFailed) {
              return const Center(
                child: Text("Unexpected error occured pull down to refersh!"),
              );
            } else if (state is ProductsLoaded) {
              List<Product> products = state.productsList;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 5),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(index: index)));
                  },
                  child: GridTile(
                    header: Container(
                      color: const Color.fromRGBO(0, 0, 0, 0.4),
                      child: ListTile(
                        tileColor: const Color.fromRGBO(0, 0, 0, 0.6),
                        leading: IconButton(
                          icon: const Icon(Icons.favorite),
                          onPressed: () {},
                        ),
                        // trailing: BlocBuilder<CartBloc, CartState>(
                        //   builder: (context, state) {
                        //     var isContained =
                        //         RepositoryProvider.of<CartProvider>(context)
                        //             .items
                        //             .containsKey(products[index].id!);
                        //     return IconButton(
                        //       icon: Icon(
                        //         Icons.shopping_cart,
                        //         color: isContained ? Colors.red : null,
                        //       ),
                        //       onPressed: () {
                        //         if (isContained) {
                        //           BlocProvider.of<CartBloc>(context).add(
                        //               RemoveProductFromCart(
                        //                   products[index].id!));
                        //         } else {
                        //           BlocProvider.of<CartBloc>(context)
                        //               .add(AddProductToCart(products[index]));
                        //         }
                        //       },
                        //     );
                        //   },
                        // ),
                      ),
                    ),
                    child: Hero(
                      tag: products[index].id!,
                      child: Image.network(
                        products[index].imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                itemCount: products.length,
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

/* StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("products").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("An error Has Occured ty again later"),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data == null) {
              return Center(
                child: Text("No Products to be shown"),
              );
            }
            for (var document in snapshot.data!.docs) {
              products.add(Product.fromSnapshot(document));
              products.last.id = document.id;
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5),
              itemBuilder: (context, itemIndex) => GridTile(
                header: Container(
                  color: Color.fromRGBO(0, 0, 0, 0.4),
                  child: ListTile(
                    tileColor: Color.fromRGBO(0, 0, 0, 0.6),
                    leading: IconButton(
                      icon: Icon(Icons.favorite),
                      onPressed: () {},
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.shopping_basket),
                      onPressed: () {},
                    ),
                  ),
                ),
                child: Image.network(
                  products[itemIndex].imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              itemCount: products.length,
            );
          }), */