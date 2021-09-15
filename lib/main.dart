import 'package:flutter/material.dart';
import './bottom_tabbar.dart';
import './categories_meals_screen.dart';
import './meal_detailscreen.dart';
import'./categories_screen.dart';
import './filters_screen.dart';
import './meal.dart';
import './dummy_data.dart';


void main() => runApp(_MyApp());

class _MyApp extends StatefulWidget {

  _MyAppState createState() =>_MyAppState();
}

class _MyAppState extends State<_MyApp>{
Map<String, bool>_filters = {
  'gluten' : false,
  'lactose' : false,
  'vegan' : false,
  'vegetarian' : false,
};
List<Meal> _availableMeals = DUMMY_MEALS;
List<Meal> _favouriteMeals = [];
void _setFilters(Map<String, bool> filterData){
  setState(() {
    _filters = filterData;
    _availableMeals = DUMMY_MEALS.where((meal){
     if (_filters['gluten'] && !meal.isGlutenFree){
       return false;
     }
     if (_filters['lactosse'] && !meal.isLactoseFree){
       return false;
     }
     if (_filters['vegan'] && !meal.isVegan){
       return false;
     }
     if (_filters['vegetarian'] && !meal.isVegetarian){
       return false;
     }
     return true;
    }).toList();
  });
}

void _toggleFavourite(String mealId) {
  final existingIndex = _favouriteMeals.indexWhere((meal) => meal.id == mealId);
  if (existingIndex >= 0){
    setState(() {
      _favouriteMeals.removeAt(existingIndex);
    });
  } else {
    setState(() {
      _favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
      );
    });
  }
}

bool _isMealFavourite(String id){
  return _favouriteMeals.any((meal) => meal.id == id);
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeal',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        accentColor: Colors.pinkAccent,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'DroidSerif',
        textTheme: ThemeData.light().textTheme.copyWith(
          body1: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          body2: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          title: TextStyle(
            fontSize: 24,
            fontFamily: 'DroidSans',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      //home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
       // '/': (ctx) => TabsScreen(),
        '/': (ctx) => BottomTabBar(_favouriteMeals),
        CategoriesMeals.routeName: (ctx) => CategoriesMeals(  _availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavourite, _isMealFavourite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
      // },
       onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
       }
    );
  }
}

