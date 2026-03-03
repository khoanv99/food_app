import 'package:flutter/material.dart';
import 'meal.dart';

class HomePage extends StatefulWidget {const HomePage({super.key});

@override
State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 3. Cấu trúc quản lý dữ liệu (Dạng JSON)
  final List<Map<String, dynamic>> _productData = [
    {
      "id": 1,
      "name": "Veg Salad",
      "price": 20.0,
      "image": "images/img1.png",
      "isFavorite": false,
      "isSelected": false,
      "description": "A fresh mix of seasonal vegetables, high in fiber and vitamins.",
      "address": "123 Green Garden St, Food City",
      "deliveryTime": "15-20 min",
      "discount": null
    },
    {
      "id": 2,
      "name": "Rice",
      "price": 30.0,
      "image": "images/img2.jpg",
      "isFavorite": false,
      "isSelected": false,
      "description": "Steamed jasmine rice served with traditional side dishes.",
      "address": "456 Rice Bowl Ave, Food City",
      "deliveryTime": "25-30 min",
      "discount": null
    },
    {
      "id": 3,
      "name": "Fried Chicken",
      "price": 50.0,
      "image": "images/img1.png",
      "isFavorite": false,
      "isSelected": false,
      "description": "Crispy golden fried chicken marinated with secret herbs.",
      "address": "789 Crispy Corner, Food City",
      "deliveryTime": "30-35 min",
      "discount": "10% Off"
    },
    {
      "id": 4,
      "name": "Roasted Mutton",
      "price": 90.0,
      "image": "images/img2.jpg",
      "isFavorite": true,
      "isSelected": false,
      "description": "Slow-roasted tender mutton with aromatic spices.",
      "address": "101 Meat Feast Rd, Food City",
      "deliveryTime": "40-45 min",
      "discount": null
    },
  ];

  List<Map<String, dynamic>> _displayedProducts = [];
  bool _isSearchVisible = false;
  final TextEditingController _searchController = TextEditingController();
  int _selectedTabIndex = 0; // 0: Home, 1: Favorite, 2: Filter

  @override
  void initState() {
    super.initState();
    _displayedProducts = List.from(_productData);
  }

  // 2.1. Event search
  void _handleSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _displayedProducts = List.from(_productData);
      } else {
        _displayedProducts = _productData
            .where((p) => p['name'].toString().toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  // 2.2. Nav tab logic
  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
      if (index == 0) {
        _displayedProducts = List.from(_productData);
      } else if (index == 1) {
        _displayedProducts = _productData.where((p) => p['isFavorite'] == true).toList();
      } else if (index == 2) {
        _displayedProducts = List.from(_productData);
        _displayedProducts.sort((a, b) => (a['price'] as double).compareTo(b['price'] as double));
      }
    });
  }

  // 2.4. Logic tính toán Total
  int get totalItems => _productData.where((p) => p['isSelected'] == true).length;
  double get totalPrice => _productData
      .where((p) => p['isSelected'] == true)
      .fold(0, (sum, p) => sum + (p['price'] as double));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.grey, size: 30),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isSearchVisible = !_isSearchVisible;
                if (!_isSearchVisible) {
                  _searchController.clear();
                  _handleSearch("");
                }
              });
            },
            icon: const Icon(Icons.search, color: Colors.black, size: 30),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_isSearchVisible)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search product name...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onChanged: _handleSearch,
              ),
            ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text("Work Place", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                Icon(Icons.arrow_drop_down, size: 30),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text("Choose your delicious meal", style: TextStyle(color: Colors.grey, fontSize: 16)),
          ),
          const SizedBox(height: 25),

          // Navigation Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTabItem(0, Icons.home),
                _buildTabItem(1, Icons.favorite),
                _buildTabItem(2, Icons.tune),
                _buildTabItem(3, Icons.shopping_cart),
              ],
            ),
          ),
          const SizedBox(height: 25),

          // Product Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: _displayedProducts.length,
              itemBuilder: (context, index) {
                final product = _displayedProducts[index];
                return _buildProductCard(product);
              },
            ),
          ),

          // Bottom Bar
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
            decoration: BoxDecoration(
              color: const Color(0xFF6ED57B),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$totalItems Items', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                Text('\$ ${totalPrice.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, IconData icon) {
    bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () => _onTabSelected(index),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? Colors.green : Colors.grey.shade300, width: 1.5),
        ),
        child: Icon(icon, color: isSelected ? Colors.green : Colors.grey.shade300, size: 28),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage(product['image']),
                    ),
                  ),
                ),
                Text(product['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$ ${product['price'].toStringAsFixed(2)}",
                        style: const TextStyle(color: Color(0xFF6ED57B), fontWeight: FontWeight.bold, fontSize: 18)),
                    // 2.5. Chuyển sang Meal Page
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MealPage(
                              name: product['name'],
                              price: product['price'].toStringAsFixed(0),
                              imgUrl: product['image'],
                              isFavorite: product['isFavorite'],
                              description: product['description'],
                              address: product['address'],
                              deliveryTime: product['deliveryTime'],
                            ),
                          ),
                        );
                      },
                      child: const Icon(Icons.add_circle, color: Color(0xFF6ED57B), size: 32),
                    ),
                  ],
                )
              ],
            ),
          ),
          // 2.4. Checkbox chọn sản phẩm
          Positioned(
            top: 12,
            left: 12,
            child: GestureDetector(
              onTap: () => setState(() => product['isSelected'] = !product['isSelected']),
              child: Icon(
                Icons.radio_button_checked,
                color: product['isSelected'] ? Colors.green : Colors.green.shade100,
                size: 26,
              ),
            ),
          ),
          // 2.3. Icon yêu thích
          Positioned(
            top: 12,
            right: 12,
            child: GestureDetector(
              onTap: () => setState(() => product['isFavorite'] = !product['isFavorite']),
              child: Icon(
                Icons.favorite,
                color: product['isFavorite'] ? Colors.red : Colors.grey.shade300,
                size: 26,
              ),
            ),
          ),
        ],
      ),
    );
  }
}