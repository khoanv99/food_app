import 'package:flutter/material.dart';
import 'meal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 1. Khởi tạo danh sách dữ liệu món ăn để có thể thay đổi trạng thái
  final List<Map<String, dynamic>> _foodItems = [
    {
      'name': 'Veg Salad',
      'price': 20.0,
      'image': 'images/img1.png',
      'isFav': true,
      'isSelected': false,
      'discount': null
    },
    {
      'name': 'Rice',
      'price': 30.0,
      'image': 'images/img2.jpg',
      'isFav': false,
      'isSelected': false,
      'discount': null
    },
    {
      'name': 'Fried Chicken',
      'price': 50.0,
      'image': 'images/3.jpg',
      'isFav': false,
      'isSelected': false,
      'discount': '10% Off'
    },
    {
      'name': 'Roasted Mutton',
      'price': 90.0,
      'image': 'images/4.jpg',
      'isFav': true,
      'isSelected': false,
      'discount': null
    },
  ];

  // 2. Hàm tính toán tổng số lượng item đã chọn
  int get totalItems => _foodItems.where((item) => item['isSelected']).length;

  // 3. Hàm tính toán tổng số tiền
  double get totalPrice => _foodItems
      .where((item) => item['isSelected'])
      .fold(0, (sum, item) => sum + item['price']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header: Menu and Search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.menu, size: 30, color: Colors.grey),
                  IconButton(
                    icon: const Icon(Icons.search, size: 30, color: Colors.grey),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Title and Location
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        'Work Place',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                  const Text(
                    'Choose your delicious meal',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Category Icons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  _buildCategoryItem(Icons.home, true),
                  _buildCategoryItem(Icons.favorite, false),
                  _buildCategoryItem(Icons.filter_alt, false),
                  _buildCategoryItem(Icons.shopping_cart, false),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 4. Food Grid (Sử dụng dữ liệu từ List _foodItems)
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _foodItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  return _buildFoodCard(index);
                },
              ),
            ),

            // 5. Bottom Floating Bar (Cập nhật logic hiển thị tiền)
            if (totalItems > 0) // Chỉ hiện khi có ít nhất 1 item được chọn
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFF6ED57B),
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$totalItems Items',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$ ${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: isActive ? Colors.green : Colors.grey.shade300, width: 2),
      ),
      child: Icon(icon, color: isActive ? Colors.green : Colors.grey),
    );
  }

  // Cập nhật hàm xây dựng card với Logic tương tác
  Widget _buildFoodCard(int index) {
    final item = _foodItems[index];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealPage(
              name: item['name'],
              price: item['price'].toString(),
              imgUrl: item['image'],
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: item['isSelected'] ? Colors.green : Colors.grey.shade200,
                width: item['isSelected'] ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    item['image'],
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.fastfood, size: 50),
                  ),
                ),
                const SizedBox(height: 10),
                Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('\$ ${item['price']}',
                        style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(width: 10),
                    // Nút bấm chọn sản phẩm (Cập nhật số tiền & số item)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          item['isSelected'] = !item['isSelected'];
                        });
                      },
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: item['isSelected'] ? Colors.green : const Color(0xFFEEEEEE),
                        child: Icon(
                          item['isSelected'] ? Icons.check : Icons.add,
                          size: 16,
                          color: item['isSelected'] ? Colors.white : Colors.green,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          // Nút Radio (Chỉnh màu khi chọn)
          Positioned(
            top: 10,
            left: 10,
            child: Icon(
              item['isSelected'] ? Icons.radio_button_checked : Icons.radio_button_off,
              color: item['isSelected'] ? Colors.green : Colors.grey.shade400,
              size: 20,
            ),
          ),
          // Nút Yêu thích (Thay đổi màu đỏ/xám khi click)
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  item['isFav'] = !item['isFav'];
                });
              },
              child: Icon(
                item['isFav'] ? Icons.favorite : Icons.favorite_border,
                color: item['isFav'] ? Colors.red : Colors.grey,
                size: 20,
              ),
            ),
          ),
          if (item['discount'] != null)
            Positioned(
              top: 0,
              left: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(10)),
                child: Text(item['discount'], style: const TextStyle(color: Colors.white, fontSize: 10)),
              ),
            )
        ],
      ),
    );
  }
}