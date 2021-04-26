
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop/model/categories/categories_model.dart';
import 'package:go_shop/view/widgets/loading_alert_widget.dart';

import '../../providers/providers.dart';

class HomeView extends StatelessWidget {
  static const routeName = 'home-view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: Stack(
        children: [
          Container(
            child: FutureBuilder(
                future: context.read(categoriesProvider).loadCategories(context),
                builder: (context, snapshot) {

                  CategoriesModel categoriesModel = snapshot.data;

                  if(snapshot.connectionState == ConnectionState.waiting)
                  {
                    return Center(child: CircularProgressIndicator(),);
                  }
                  return ListView.builder(
                      itemCount: categoriesModel.data.categoryItem.length,
                      itemBuilder: (context, index) {

                        return ListTile(
                          leading: Image.network(categoriesModel.data.categoryItem[index].image),
                          title: Text(categoriesModel.data.categoryItem[index].name),
                        );
                      });
                }),
          ),

          LoadingAndAlertWidget(),

        ],
      ),
    );
  }
}
