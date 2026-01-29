import 'package:first/core/app_imports.dart';

class CategoriesDisplayWidget extends StatelessWidget {
  final List<CategoryModel> categories;
  final Function(int categoryId)? onCategoryTap;

  const CategoriesDisplayWidget({
    super.key,
    required this.categories,
    this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              if (onCategoryTap != null) {
                onCategoryTap!(category.categoryId);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryViewPage(
                      selectedCategoryId: category.categoryId,
                      categoryName: category.categoryName,
                    ),
                  ),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Column(
                children: [
                  // Category Image Circle
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.backgroundGreyLighter,
                      border: Border.all(
                        color: AppColors.borderGreyLighter,
                        width: 1,
                      ),
                      image:
                          category.categoryImage != null &&
                              category.categoryImage!.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(category.categoryImage!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child:
                        (category.categoryImage == null ||
                            category.categoryImage!.isEmpty)
                        ? const Icon(
                            Icons.category_outlined,
                            color: AppColors.textGreyMedium,
                            size: 40,
                          )
                        : null,
                  ),
                  const SizedBox(height: 8),
                  // Category Name
                  Text(
                    category.categoryName,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlack87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
