import 'package:flutter/material.dart';

class MealPage extends StatelessWidget {
  final String name;
  final String price;
  final String imgUrl;

  const MealPage({
    super.key,
    required this.name,
    required this.price,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 1. Hình ảnh món ăn với nút Back và Tim
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imgUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 20,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const Positioned(
                bottom: 20,
                right: 20,
                child: Icon(Icons.favorite, color: Colors.white, size: 30),
              ),
            ],
          ),

          // 2. Thông tin chi tiết
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.radio_button_checked, color: Colors.green, size: 20),
                        ],
                      ),
                      // Bộ tăng giảm số lượng
                      Row(
                        children: [
                          _buildQtyBtn(Icons.remove, Colors.grey.shade300),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text("2", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          _buildQtyBtn(Icons.add, const Color(0xFF6ED57B)),
                        ],
                      )
                    ],
                  ),
                  Text(
                    "\$ $price",
                    style: const TextStyle(fontSize: 22, color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text("Recipe", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text(
                    "This holds the description of this particular meal more..",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 30),

                  // Location & Delivery Time
                  _buildInfoTile(Icons.location_on_sharp, "Location", "Description of location.."),
                  const SizedBox(height: 15),
                  _buildInfoTile(Icons.access_time_filled, "Delivery Time", "30 Minutes"),
                ],
              ),
            ),
          ),

          // 3. Bottom Bar
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            decoration: BoxDecoration(
              color: const Color(0xFF6ED57B),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('2 Items', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text('\$ 200', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String subTitle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Icon(icon, color: Colors.grey.shade400),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(subTitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        )
      ],
    );
  }
}