import 'package:flutter/material.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';
import 'package:pwfe/components/buttons/button_blue_lighter_rounded.dart';
import 'package:pwfe/pages/MyShoppingListsPage.dart';

class AddShoppingListPage extends StatefulWidget {
  const AddShoppingListPage({Key? key}) : super(key: key);

  @override
  State<AddShoppingListPage> createState() => _AddShoppingListPageState();
}

class _AddShoppingListPageState extends State<AddShoppingListPage> {
  final addShoppingListController = TextEditingController();

  Color selectedColor = Colors.blue; // Default color
  IconData? selectedIcon; // Default icon

  // Example color choices
  final List<Color> colorChoices = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.cyan,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey
    // ... add more colors ...
  ];

  // Example icons
  final List<IconData> icons = [
    Icons.book,
    Icons.sports_soccer,
    Icons.pets,
    Icons.shopping_bag,
    Icons.shopping_cart,
    Icons.shopping_basket,
    Icons.shopping_bag_outlined,
    Icons.shopping_bag_rounded,
    Icons.shopping_cart_outlined,
    Icons.shopping_cart_rounded,
    Icons.shopping_basket_outlined,
    Icons.shopping_basket_rounded,
    Icons.shopping_cart_sharp,
    Icons.shopping_basket_sharp,

    // ... add more icons ...
  ];

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    addShoppingListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Shopping List'),
      ),
      body: SingleChildScrollView(
        // Wrapped in a SingleChildScrollView
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: addShoppingListController,
                decoration: InputDecoration(
                  labelText: 'Shopping List Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Added space
            // Color choices
            Wrap(
              spacing: 8.0,
              runSpacing: 20.0, // Added space between rows
              children: colorChoices.map((color) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColor = color;
                    });
                  },
                  child: Container(
                    width: 42,
                    height: 42,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20), // Added space
        // Icon choices
            Wrap(
              spacing: 8.0,
              runSpacing: 20.0, // Added space between rows
              children: icons.map((icon) {
                return IconButton(
                  icon: Icon(icon),
                  onPressed: () {
                    setState(() {
                      selectedIcon = icon;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20), // Added space
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
            onPressed: () {
              // Show the dialog

              // Add the shopping list
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyShoppingLists()));
            },
            
            style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text(
                  'Add Shopping List',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),         
                ),),
            
          ],
        ),
      ),
      bottomNavigationBar: navigation_bar_bottom(context),
    );
  }
}