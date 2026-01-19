import 'package:flutter/material.dart';

class ShopByPriceWidget extends StatelessWidget {
  // Click hone par kya hona chahiye, uska function yahan pass hoga
  final Function(String price)? onPriceClick;

  ShopByPriceWidget({this.onPriceClick});

  // Price ranges ki list
  final List<String> priceRanges = [
    "Below Rs. 15,000",
    "Rs. 15,000 - Rs. 25,000",
    "Rs. 25,000 - Rs. 40,000",
    "Rs. 40,000 - Rs. 60,000",
    "Rs. 60,000 - Rs. 80,000",
    "Rs. 80,000 - Rs. 100,000",
    "Rs. 100,000 - Rs. 150,000",
    "Above 150,000",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 24, 10, 24),
      color: Color(0xFFFFE66D), // Yellow Background
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Shop by Price",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true, // Grid ko limit karne ke liye
            physics: NeverScrollableScrollPhysics(), // Column ke andar scroll na ho
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 columns
              childAspectRatio: 2.8, // Buttons ki shape set karne ke liye
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
            ),
            itemCount: priceRanges.length,
            itemBuilder: (context, index) {
              return PriceButton(
                label: priceRanges[index],
                // Teesri item (index 2) ko image ki tarah white rakha hai
                isHighlighted: index == 2, 
                onTap: () {
                  if (onPriceClick != null) {
                    onPriceClick!(priceRanges[index]);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class PriceButton extends StatelessWidget {
  final String label;
  final bool isHighlighted;
  final VoidCallback onTap;

  PriceButton({
    required this.label,
    this.isHighlighted = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isHighlighted ? Colors.white : Color(0xFFFF0090), // Pink color
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isHighlighted ? Color(0xFFFF0090) : Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }
}