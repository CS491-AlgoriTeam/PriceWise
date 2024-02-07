import 'package:flutter/material.dart';
import 'package:pwfe/components/bars/app_bar_top.dart';
import 'package:pwfe/components/bars/navigation_bar_bottom.dart';

class SuggestedItems extends StatefulWidget {
  const SuggestedItems({Key? key}) : super(key: key);

  @override
  State<SuggestedItems> createState() => _SuggestedItemsState();
}

class _SuggestedItemsState extends State<SuggestedItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar_top(), // Custom app bar top
      bottomNavigationBar: navigation_bar_bottom(context), // Custom navigation bar bottom
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'From Migros',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              buildItemBox('Item 1', 'Price 1', 'Amount 1'),
              const SizedBox(height: 16), // Added padding between boxes
              buildItemBox('Item 2', 'Price 2', 'Amount 2'),
              const SizedBox(height: 16), // Added padding between boxes
              buildItemBox('Item 3', 'Price 3', 'Amount 3'),
              const SizedBox(height: 16), // Added padding between boxes
              buildItemBox('Item 4', 'Price 4', 'Amount 4'),
              const SizedBox(height: 16),
              buildSmallCenteredTotalBox('3.78\$'),
              const SizedBox(height: 16),
              const Text(
                'Suggested Items',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              buildRedBox(),
              const SizedBox(height: 8),
              buildGreenBox(),
              const SizedBox(height: 8),
              buildYellowBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItemBox(String name, String price, String amount) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
        color: Colors.lightBlue.shade100, // Light blue color
      ),
      child: Row(
        children: [
          const Icon(Icons.shopping_basket, color: Colors.black),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(price),
              ],
            ),
          ),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.add, color: Colors.black),
                onPressed: () {
                  // Handle add button press
                },
              ),
              IconButton(
                icon: const Icon(Icons.remove, color: Colors.black),
                onPressed: () {
                  // Handle remove button press
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSmallCenteredTotalBox(String totalAmount) {
    return Center(
      child: Container(
        width: 120,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey),
          color: Colors.lightBlue.shade100, // Light blue color
        ),
        child: Center(
          child: Text(
            'Total: $totalAmount',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // ... buildRedBox, buildGreenBox, and buildYellowBox methods unchanged
  Widget buildRedBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
        color: Colors.red,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Out of Stock: ',
                    style: TextStyle(color: Colors.black, fontFamily: 'sans-serif'),
                  ),
                  Text('Price',
                      style: TextStyle(color: Colors.black, fontFamily: 'sans-serif')),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tam Yağlı Süt',
                    style: TextStyle(color: Colors.black, fontFamily: 'sans-serif'),
                  ),
                  Text('1.08\$',
                      style: TextStyle(color: Colors.black, fontFamily: 'sans-serif')),
                ],
              ),
              SizedBox(width: 16),
              Icon(Icons.arrow_forward, color: Colors.black), // Arrow icon
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Yarım Yağlı Süt',
                    style: TextStyle(color: Colors.black, fontFamily: 'sans-serif'),
                  ),
                  Text('1.16\$',
                      style: TextStyle(color: Colors.black, fontFamily: 'sans-serif')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildGreenBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
        color: Colors.green,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'In Sale:           ',
                    style: TextStyle(color: Colors.black, fontFamily: 'sans-serif'),
                  ),
                  Text(' ',
                      style: TextStyle(color: Colors.black, fontFamily: 'sans-serif')),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gofret 1',
                    style: TextStyle(color: Colors.black, fontFamily: 'sans-serif'),
                  ),
                  Text('2\$',
                      style: TextStyle(color: Colors.black, fontFamily: 'sans-serif')),
                ],
              ),
              SizedBox(width: 16),
              Icon(Icons.arrow_forward, color: Colors.black), // Arrow icon
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gofret 2',
                    style: TextStyle(color: Colors.black, fontFamily: 'sans-serif'),
                  ),
                  Text('1.5\$',
                      style: TextStyle(color: Colors.black, fontFamily: 'sans-serif')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildYellowBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
        color: Colors.yellow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instead of: ',
                    style: TextStyle(color: Colors.black, fontFamily: 'sans-serif'),
                  ),
                  Text('Price',
                      style: TextStyle(color: Colors.black, fontFamily: 'sans-serif')),
                  Text('Save',
                      style: TextStyle(color: Colors.black, fontFamily: 'sans-serif')),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amasya Elması',
                    style: TextStyle(color: Colors.black, fontFamily: 'sans-serif'),
                  ),
                  Text('0.18\$',
                      style: TextStyle(color: Colors.black, fontFamily: 'sans-serif')),
                  Text('0.8\$',
                      style: TextStyle(color: Colors.black, fontFamily: 'sans-serif')),
                ],
              ),
              SizedBox(width: 16),
              Icon(Icons.arrow_forward, color: Colors.black), // Arrow icon
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Normal Elma',
                    style: TextStyle(color: Colors.black, fontFamily: 'sans-serif'),
                  ),
                  Text('0.16\$',
                      style: TextStyle(color: Colors.black, fontFamily: 'sans-serif')),
                  Text('12%',
                      style: TextStyle(color: Colors.black, fontFamily: 'sans-serif')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

}

/*
class SuggestedItems extends StatefulWidget {
  const SuggestedItems({super.key});

  @override
  State<SuggestedItems> createState() => _SuggestedItemsState();
}

class _SuggestedItemsState extends State<SuggestedItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suggested Items Page'),
      ),
      body: const Center(
        child: Text('Suggested Items Content'),
      ),
    );
  }
}*/
