import 'package:flutter/material.dart';

class MealPage extends StatefulWidget {
  final String name;
  final String price;
  final String imgUrl;
  final bool isFavorite;
  final String description;
  final String address;
  final String deliveryTime;
  final int initialQuantity;

  const MealPage({
    super.key,
    required this.name,
    required this.price,
    required this.imgUrl,
    required this.isFavorite,
    required this.description,
    required this.address,
    required this.deliveryTime,
    this.initialQuantity = 1,
  });

  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  late int quantity;
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
    isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    double unitPrice = double.tryParse(widget.price) ?? 0.0;

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
                    image: AssetImage(widget.imgUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 25),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              Positioned(
                bottom: 25,
                right: 25,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: isFavorite ? Colors.red : Colors.grey.shade300,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // 2. Thông tin chi tiết
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  widget.name,
                                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Icon(Icons.radio_button_checked, color: Colors.green, size: 22),
                            ],
                          ),
                        ),
                        // Bộ tăng giảm số lượng
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (quantity > 1) setState(() => quantity--);
                              },
                              child: _buildQtyBtn(Icons.remove, Colors.grey.shade200, Colors.black),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Text("$quantity", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() => quantity++);
                              },
                              child: _buildQtyBtn(Icons.add, const Color(0xFF6ED57B), Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "\$ ${widget.price}",
                      style: const TextStyle(fontSize: 24, color: Color(0xFF6ED57B), fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 25),
                    const Text("Description", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(
                      widget.description,
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 15, height: 1.5),
                    ),
                    const SizedBox(height: 30),

                    // Location & Delivery Time
                    _buildInfoTile(Icons.location_on, "Location", widget.address),
                    const SizedBox(height: 20),
                    _buildInfoTile(Icons.access_time_filled, "Delivery Time", widget.deliveryTime),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          // 3. Bottom Bar - Hiển thị Tổng tiền
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            decoration: BoxDecoration(
              color: const Color(0xFF6ED57B),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Items in cart', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                Text('\$ ${(unitPrice * quantity).toStringAsFixed(0)}',
                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon, Color bgColor, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: iconColor, size: 20),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String subTitle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Icon(icon, color: Colors.grey.shade400, size: 26),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              const SizedBox(height: 2),
              Text(subTitle, style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
            ],
          ),
        )
      ],
    );
  }
}
