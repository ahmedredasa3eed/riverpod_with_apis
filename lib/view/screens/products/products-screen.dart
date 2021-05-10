import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop/model/categories/categories_model.dart';
import 'package:go_shop/model/products/products_model.dart';
import 'package:go_shop/providers/providers.dart';
import 'package:go_shop/utils/enums.dart';
import 'package:go_shop/utils/page_router.dart';
import 'package:go_shop/view/screens/favourite/favourite_view.dart';
import 'package:go_shop/view/screens/products/product_item.dart';
import 'package:go_shop/view/widgets/loading_alert_widget.dart';
import 'package:go_shop/view/widgets/loading_widget.dart';

class ProductsScreen extends StatelessWidget {

  CategoryModel categoryModel;
  ProductsScreen(this.categoryModel);

  @override
  Widget build(BuildContext context) {
    print(categoryModel.id);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text("المنتجات"),
            backgroundColor: Colors.teal,
            actions: [
              IconButton(
                onPressed: () {
                  PageRouter.pushScreen(
                      context: context,
                      transition: AppTransition.fade,
                      screen: FavouriteScreen());
                },
                icon: Icon(Icons.favorite),
              ),
            ],
          ),
          body: Stack(
            children: [
              FutureBuilder(
                future: context.read(productViewModelProvider).loadProductsByCategory(categoryModel.id),
                builder: (context, snapshot) {
                  ProductsModel productsModel = snapshot.data;

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingWidget();
                  }
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: GridView.builder(
                      itemCount: productsModel.data.products.length,
                      shrinkWrap: true,
                      primary: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        return ProductItem(productsModel, index);
                      },
                    ),
                  );
                },
              ),
              LoadingAndAlertWidget(),
            ],
          )),
    );
  }
}
