import'package:flutter/material.dart';

import './meal_item.dart';
import './meal.dart';


class CategoriesMeals extends StatefulWidget {
  static const routeName = '/categories-meals';
  final List<Meal> availableMeals;

  CategoriesMeals(this.availableMeals);
  // final String categoryId;
  // final String categoryTitle;
  //
  // CategoriesMeals(this.categoryId, this.categoryTitle);
  _CategoriesMealsState createState() => _CategoriesMealsState();
}
class _CategoriesMealsState extends State <CategoriesMeals>{
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedInitData = false;
  void initState(){
    super.initState();

  }
  @override
  void didChangeDependencies() {
    if(!_loadedInitData){
      final routeArgs = ModalRoute.of(context).settings.arguments as Map<String,String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['Id'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  // void _removeMeal(String mealId){
  //   setState(() {
  //     displayedMeals.removeWhere((meal) => meal.id == mealId);
  //   });
  // }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(itemBuilder: (ctx, index) {
      return MealItem(
        id: displayedMeals[index].id,
        title: displayedMeals[index].title,
        imageUrl: displayedMeals[index].imageUrl,
        duration: displayedMeals[index].duration,
        affordability: displayedMeals[index].affordability,
        complexity: displayedMeals[index].complexity,
      );
      },
      itemCount: displayedMeals.length,
      ),
    );
  }
}
