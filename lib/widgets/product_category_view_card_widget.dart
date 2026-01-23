import 'package:first/core/app_imports.dart';

class CategoryViewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ShopMoreCategoriesWidget(
            title: "Popular Categories",
            items: [
              ShopCategoryCardData(
                image: AssetImage("../assets/brands/dell.png"),
                title: "Wireless\nEarbuds",
                onTap: () {},
              ),
              ShopCategoryCardData(
                image: AssetImage("../assets/brands/dell.png"),
                title: "Smart\nWatches",
                onTap: () {},
              ),
              ShopCategoryCardData(
                image: AssetImage("../assets/brands/dell.png"),
                title: "Bluetooth\nSpeakers",
                onTap: () {},
              ),
              ShopCategoryCardData(
                image: AssetImage("../assets/brands/dell.png"),
                title: "Tablets",
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
