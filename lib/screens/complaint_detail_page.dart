// import 'package:first/screens/complain_chat_page.dart';
// import 'package:flutter/material.dart';
// import 'package:first/widgets/widgets.dart'; // PrimaryBtnWidget

// class ComplaintDetailPage extends StatelessWidget {
//   final String complaintId;
//   final String orderId;
//   final String productName;
//   final String productImg;
//   final double productPrice;
//   final String subject;
//   final String description;
//   final List<String> userImages;

//   const ComplaintDetailPage({
//     super.key,
//     required this.complaintId,
//     required this.orderId,
//     required this.productName,
//     required this.productImg,
//     required this.productPrice,
//     required this.subject,
//     required this.description,
//     required this.userImages,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: GestureDetector(
//           onTap: () => Navigator.pop(context),
//           child: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black87,
//             size: 20,
//           ),
//         ),
//         title: const Text(
//           'Complaint Details',
//           style: TextStyle(
//             color: Colors.black87,
//             fontWeight: FontWeight.w600,
//             fontSize: 18,
//           ),
//         ),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Complain & Order ID
//                 Text(
//                   'Complaint ID: $complaintId',
//                   style: const TextStyle(
//                       fontWeight: FontWeight.w600, fontSize: 14),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Order ID: $orderId',
//                   style: const TextStyle(
//                       fontWeight: FontWeight.w500, fontSize: 14, color: Colors.grey),
//                 ),
//                 const SizedBox(height: 12),

//                 // Product Info Row
//                 Row(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.network(
//                         productImg,
//                         width: 80,
//                         height: 80,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             productName,
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.w600, fontSize: 16),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             'Rs ${productPrice.toStringAsFixed(0)}',
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.w700, fontSize: 14),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),

//                 // Subject
//                 Text(
//                   'Subject',
//                   style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 14,
//                       color: Colors.grey[700]),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   subject,
//                   style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//                 ),
//                 const SizedBox(height: 12),

//                 // Description / Msg
//                 Text(
//                   'Description',
//                   style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 14,
//                       color: Colors.grey[700]),
//                 ),


//                 const SizedBox(height: 4),
//                 Text(
//                   description,
//                   style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//                 ),
//                 const SizedBox(height: 12),

//                 // User Uploaded Images
//                 if (userImages.isNotEmpty) ...[
//                   Text(
//                     'Attached Images',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 14,
//                         color: Colors.grey[700]),
//                   ),
//                   const SizedBox(height: 8),
//                   Wrap(
//                     spacing: 8,
//                     runSpacing: 8,
//                     children: userImages.map((img) {
//                       return ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.network(
//                           img,
//                           width: (MediaQuery.of(context).size.width - 64) / 4,
//                           height: 70,
//                           fit: BoxFit.cover,
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                   const SizedBox(height: 16),
//                 ],

//                 // Note / Msg
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: const Text(
//                     'If you want to chat with us or customer care regarding this complaint, click the button below.',
//                     style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
//                   ),
//                 ),

//                 const SizedBox(height: 16),

//                 // Chat Button
//                 PrimaryBtnWidget(
//                   buttonText: 'Chat with Us',
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen()
//                     ));
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }




















































// import 'package:first/screens/complain_chat_page.dart';
// import 'package:flutter/material.dart';
// import 'package:first/widgets/widgets.dart'; // PrimaryBtnWidget

// class ComplaintDetailPage extends StatelessWidget {
//   final String complaintId;
//   final String orderId;
//   final String productName;
//   final String productImg;
//   final double productPrice;
//   final String subject;
//   final String description;
//   final List<String> userImages;

//   const ComplaintDetailPage({
//     super.key,
//     required this.complaintId,
//     required this.orderId,
//     required this.productName,
//     required this.productImg,
//     required this.productPrice,
//     required this.subject,
//     required this.description,
//     required this.userImages,
//   });

//   void _openImageViewer(BuildContext context, int index) {
//     if (userImages.isEmpty) return;

//     final controller = PageController(initialPage: index);

//     showGeneralDialog(
//       context: context,
//       barrierDismissible: true,
//       barrierLabel: 'ImageViewer',
//       pageBuilder: (ctx, a1, a2) {
//         return GestureDetector(
//           onTap: () => Navigator.of(ctx).pop(),
//           child: Container(
//             color: Colors.black.withOpacity(0.85),
//             child: SafeArea(
//               child: Stack(
//                 children: [
//                   Center(
//                     child: PageView.builder(
//                       controller: controller,
//                       itemCount: userImages.length,
//                       itemBuilder: (context, i) {
//                         final src = userImages[i];
//                         final isNetwork = src.startsWith('http');
//                         final image = isNetwork
//                             ? Image.network(src, fit: BoxFit.contain)
//                             : Image.asset(src, fit: BoxFit.contain);
//                         return InteractiveViewer(
//                           child: Container(
//                             alignment: Alignment.center,
//                             padding: const EdgeInsets.all(12),
//                             child: ConstrainedBox(
//                               constraints: BoxConstraints(
//                                 maxWidth: MediaQuery.of(ctx).size.width * 0.85,
//                                 maxHeight: MediaQuery.of(ctx).size.height * 0.75,
//                               ),
//                               child: image,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   Positioned(
//                     right: 12,
//                     top: 12,
//                     child: IconButton(
//                       icon: const Icon(
//                         Icons.close,
//                         color: Colors.white,
//                         size: 28,
//                       ),
//                       onPressed: () => Navigator.of(ctx).pop(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//       transitionBuilder: (ctx, a1, a2, child) {
//         final curved = Curves.easeInOut.transform(a1.value);
//         return Transform.scale(scale: curved, child: child);
//       },
//       transitionDuration: const Duration(milliseconds: 250),
//     );
//   }

//   Widget _buildImage(BuildContext context, String src, int index, int displayIndex, int total) {
//     final isNetwork = src.startsWith('http');
//     final image = isNetwork
//         ? Image.network(src, fit: BoxFit.cover)
//         : Image.asset(src, fit: BoxFit.cover);

//     Widget child = ClipRRect(
//       borderRadius: BorderRadius.circular(6),
//       child: SizedBox(width: 75, height: 75, child: image),
//     );

//     if (displayIndex == 3 && total > 4) {
//       final remaining = total - 4;
//       child = Stack(
//         children: [
//           child,
//           Container(
//             width: 75,
//             height: 75,
//             decoration: BoxDecoration(
//               color: Colors.black.withOpacity(0.45),
//               borderRadius: BorderRadius.circular(6),
//             ),
//             alignment: Alignment.center,
//             child: Text(
//               '+$remaining',
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       );
//     }

//     return GestureDetector(
//       onTap: () => _openImageViewer(context, index),
//       child: child,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: GestureDetector(
//           onTap: () => Navigator.pop(context),
//           child: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black87,
//             size: 20,
//           ),
//         ),
//         title: const Text(
//           'Complaint Details',
//           style: TextStyle(
//             color: Colors.black87,
//             fontWeight: FontWeight.w600,
//             fontSize: 18,
//           ),
//         ),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Complaint & Order ID
//                 Text(
//                   'Complaint ID: $complaintId',
//                   style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Order ID: $orderId',
//                   style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.grey),
//                 ),
//                 const SizedBox(height: 12),

//                 // Product Info
//                 Row(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.network(
//                         productImg,
//                         width: 80,
//                         height: 80,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             productName,
//                             style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             'Rs ${productPrice.toStringAsFixed(0)}',
//                             style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),

//                 // Subject
//                 Text(
//                   'Subject',
//                   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey[700]),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(subject, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
//                 const SizedBox(height: 12),

//                 // Description / Msg
//                 Text(
//                   'Description',
//                   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey[700]),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(description, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
//                 const SizedBox(height: 12),

//                 // User Images (using your _buildImage widget)
//                 if (userImages.isNotEmpty) ...[
//                   Text(
//                     'Attached Images',
//                     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey[700]),
//                   ),
//                   const SizedBox(height: 8),
//                   Wrap(
//                     spacing: 8,
//                     runSpacing: 8,
//                     children: List.generate(userImages.length, (i) {
//                       return _buildImage(context, userImages[i], i, i, userImages.length);
//                     }),
//                   ),
//                   const SizedBox(height: 16),
//                 ],

//                 // Note / Message
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: const Text(
//                     'If you want to chat with us or customer care regarding this complaint, click the button below.',
//                     style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 // Chat Button
//                 PrimaryBtnWidget(
//                   buttonText: 'Chat with Us',
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => const ChatScreen()));
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }













































import 'package:first/screens/complain_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:first/widgets/widgets.dart'; // PrimaryBtnWidget

class ComplaintDetailPage extends StatelessWidget {
  final String complaintId;
  final String orderId;
  final String productName;
  final String productImg;
  final double productPrice;
  final String subject;
  final String description;
  final List<String> userImages;

  const ComplaintDetailPage({
    super.key,
    required this.complaintId,
    required this.orderId,
    required this.productName,
    required this.productImg,
    required this.productPrice,
    required this.subject,
    required this.description,
    required this.userImages,
  });

  void _openImageViewer(BuildContext context, int index) {
    if (userImages.isEmpty) return;

    final controller = PageController(initialPage: index);

    showDialog(
      context: context,
      builder: (ctx) {
        return GestureDetector(
          onTap: () => Navigator.of(ctx).pop(),
          child: Container(
            color: Colors.black.withOpacity(0.85),
            child: Stack(
              children: [
                PageView.builder(
                  controller: controller,
                  itemCount: userImages.length,
                  itemBuilder: (context, i) {
                    return InteractiveViewer(
                      child: Center(
                        child: Image.network(
                          userImages[i],
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return const CircularProgressIndicator();
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.broken_image, size: 100, color: Colors.white);
                          },
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  right: 14,
                  top: 20,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImage(BuildContext context, String src, int index, int displayIndex, int total) {
    Widget image = ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image.network(
        src,
        width: 70,
        height: 70,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            width: 80,
            height: 80,
            color: Colors.grey[300],
            child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 80,
            height: 80,
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image, color: Colors.red),
          );
        },
      ),
    );

    return GestureDetector(
      onTap: () => _openImageViewer(context, index),
      child: image,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: 20,
          ),
        ),
        title: const Text(
          'Complaint Details',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Complaint ID: $complaintId', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 4),
                Text('Order ID: $orderId', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 12),

                // Product Info
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(productImg, width: 80, height: 80, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(productName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                          const SizedBox(height: 4),
                          Text('Rs ${productPrice.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Text('Subject', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey[700])),
                const SizedBox(height: 4),
                Text(subject, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                const SizedBox(height: 12),

                Text('Description', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey[700])),
                const SizedBox(height: 4),
                Text(description, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                const SizedBox(height: 12),

                // User Images
                if (userImages.isNotEmpty) ...[
                  Text('Attached Images', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey[700])),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(userImages.length, (i) => _buildImage(context, userImages[i], i, i, userImages.length)),
                  ),
                  const SizedBox(height: 16),
                ],

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
                  child: const Text(
                    'If you want to chat with us or customer care regarding this complaint, click the button below.',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 16),

                PrimaryBtnWidget(
                  buttonText: 'Chat with Us',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
