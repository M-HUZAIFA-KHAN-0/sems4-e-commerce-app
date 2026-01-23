import 'package:first/screens/add_complaints_form_page.dart';
import 'package:first/screens/complaint_detail_page.dart';
import 'package:first/core/app_imports.dart';

class ComplaintsListPage extends StatelessWidget {
  const ComplaintsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        title: const Text(
          'My Complaints',
          style: TextStyle(
            color: AppColors.textBlack87,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ================= BODY =================
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        children: [
          // ===== Add Complaint Button =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PrimaryBtnWidget(
              buttonText: 'Add Complaint',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddComplaintsFormPage(),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // ===== Complaint Cards =====
          ...List.generate(
            5,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 1),
              child: _ComplaintCard(
                imageUrl: 'https://picsum.photos/200?3',
                orderId: 'ORD-10${index + 1}234',
                date: '12 Jan 2026',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= COMPLAINT CARD =================
class _ComplaintCard extends StatelessWidget {
  final String imageUrl;
  final String orderId;
  final String date;

  const _ComplaintCard({
    required this.imageUrl,
    required this.orderId,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          // Order Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderId,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textBlack87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textGreyDark.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),

          PrimaryBtnWidget(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ComplaintDetailPage(
                    complaintId: 'COMP-12345',
                    orderId: orderId,
                    productName: 'Product Name',
                    productImg: imageUrl,
                    productPrice: 1000,
                    subject: 'Subject of Complaint',
                    description: 'Description of the complaint.',
                    userImages: [
                      "https://picsum.photos/200?1",
                      "https://picsum.photos/200?2",
                      "https://picsum.photos/200?3",
                      "https://picsum.photos/200?4",
                      "https://picsum.photos/200?5",
                    ],
                  ),
                ),
              );
            },
            buttonText: 'View Detail',
            width: 120,
            height: 38,
            fontSize: 12,
          ),

          // View Detail Button
          // TextButton(
          //   onPressed: () {
          //     // View detail
          //   },
          //   style: TextButton.styleFrom(
          //     foregroundColor:  AppColors.primaryBlue,
          //   ),
          //   child: const Text(
          //     'View Detail',
          //     style: TextStyle(
          //       fontSize: 13,
          //       fontWeight: FontWeight.w600,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
