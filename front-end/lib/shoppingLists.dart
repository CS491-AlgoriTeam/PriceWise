// shoppingLists.dart
import 'package:flutter/material.dart';


class ShoppingLists extends StatefulWidget {
 @override
 _ShoppingListsScreenState createState() => _ShoppingListsScreenState();
}


class _ShoppingListsScreenState extends State<ShoppingLists> {
 int _currentIndex = 0;


 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('PriceWise'),
       backgroundColor: Colors.lightBlue,
     ),
     body: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text(
             'Shopping Lists',
             style: TextStyle(
               fontSize: 20.0,
               fontWeight: FontWeight.bold,
             ),
           ),
         ),
         Expanded(
           child: ListView.builder(
             itemCount: 5,
             itemBuilder: (context, index) {
               return Container(
                   color: Colors.amber,
                   child: ListTile(
                     title: Text('Item ${index + 1}'),
                   ));
             },
           ),
         ),
       ],
     ),
     bottomNavigationBar: BottomNavigationBar(
       currentIndex: _currentIndex,
       onTap: (int index) {
         setState(() {
           _currentIndex = index;
         });
       },
       items: [
         BottomNavigationBarItem(
           icon: Icon(Icons.list),
           label: 'Shopping Lists',
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.search),
           label: 'Search',
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.settings),
           label: 'My Profile',
         ),
       ],
     ),
   );
 }
}
