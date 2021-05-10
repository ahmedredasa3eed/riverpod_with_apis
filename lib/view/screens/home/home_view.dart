import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop/model/home/home_data_model.dart';
import 'package:go_shop/providers/providers.dart';
import 'package:go_shop/utils/enums.dart';
import 'package:go_shop/utils/page_router.dart';
import 'package:go_shop/view/screens/categories/categories_screen.dart';
import 'package:go_shop/view/screens/contacts/contacts_view.dart';
import 'package:go_shop/view/screens/favourite/favourite_view.dart';
import 'package:go_shop/view/widgets/loading_alert_widget.dart';
import 'package:go_shop/view/widgets/loading_widget.dart';

class HomeDataView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: (){
            context.read(authViewModelProvider).logout(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: (){
              PageRouter.pushScreen(
                context: context,
                transition: AppTransition.bottom_to_top,
                screen: CategoriesScreen(),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: (){
              PageRouter.pushScreen(
                context: context,
                transition: AppTransition.bottom_to_top,
                screen: FavouriteScreen(),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: context.read(homeViewModelProvider).loadHomeData(),
            builder: (context,snapshot){
              HomeDataModel homeDataModel = snapshot.data;
              if(snapshot.connectionState == ConnectionState.waiting)
              {
                return LoadingWidget();
              }
              return Column(
                children: [
                  Text("${homeDataModel.homeData.products[7].name}"),
                ],
              );
            },
          ),
          LoadingAndAlertWidget(),
        ],
      ),
    );
  }
}
