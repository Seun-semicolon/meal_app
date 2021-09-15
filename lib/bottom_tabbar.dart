import 'package:flutter/material.dart';
import './main_drawer.dart';
import './categories_screen.dart';
import './favorites_screen.dart';
import './meal.dart';

class BottomTabBar extends StatefulWidget {
final List<Meal> favouriteMeals;
BottomTabBar(this.favouriteMeals);
  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  List<Map<String, Object>> _pages;
 int _selectedPageIndex = 0;

 @override
 void initState() {
   _pages = [
     {'page':CategoriesScreen(),
       'title': 'Categories',
     },
     {
       'page':  FavoritesScreen(widget.favouriteMeals),
       'title': 'Your Favorites',
     },
   ];
   super.initState();
 }
  void _selectPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage ,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
       // type: BottomNavigationBarType.shifting,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text('Favorites'),
          ),
        ],
      ),
    );
  }
}
