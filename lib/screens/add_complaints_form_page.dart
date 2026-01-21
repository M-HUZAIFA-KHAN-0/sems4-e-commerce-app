// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:first/widgets/widgets.dart';

// class AddComplaintsFormPage extends StatefulWidget {
//   const AddComplaintsFormPage({super.key});

//   @override
//   State<AddComplaintsFormPage> createState() => _AddComplaintsFormPageState();
// }

// class _AddComplaintsFormPageState extends State<AddComplaintsFormPage> {
//   final _orderNoController = TextEditingController();
//   final _subjectController = TextEditingController();
//   final _messageController = TextEditingController();

//   final ImagePicker _picker = ImagePicker();
//   List<XFile> _images = [];

//   @override
//   void dispose() {
//     _orderNoController.dispose();
//     _subjectController.dispose();
//     _messageController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickImages() async {
//     final pickedImages = await _picker.pickMultiImage();
//     if (pickedImages.isNotEmpty) {
//       setState(() => _images = pickedImages);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],

//       // ================= APP BAR =================
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black87, size: 20),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Add Complaint',
//           style: TextStyle(
//             color: Colors.black87,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),

//       // ================= BODY =================
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Order No
//               buildFormField(
//                 controller: _orderNoController,
//                 label: 'Order No',
//                 icon: Icons.receipt_long,
//                 hintText: 'Enter order number',
//               ),

//               const SizedBox(height: 16),

//               // Subject
//               buildFormField(
//                 controller: _subjectController,
//                 label: 'Subject',
//                 icon: Icons.subject,
//                 hintText: 'Enter subject',
//               ),

//               const SizedBox(height: 16),

//               // Description / Message
//               buildFormField(
//                 controller: _messageController,
//                 label: 'Description',
//                 icon: Icons.message,
//                 hintText: 'Write your message',
//               ),

//               const SizedBox(height: 20),

//               // ================= IMAGE PICKER =================
//               const Text(
//                 'Attach Images',
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black87,
//                 ),
//               ),
//               const SizedBox(height: 8),

//               GestureDetector(
//                 onTap: _pickImages,
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.symmetric(vertical: 18),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey.shade300),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Column(
//                     children: const [
//                       Icon(Icons.photo_library, color: Colors.grey),
//                       SizedBox(height: 6),
//                       Text(
//                         'Tap to select images',
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               if (_images.isNotEmpty) ...[
//                 const SizedBox(height: 12),
//                 SizedBox(
//                   height: 80,
//                   child: ListView.separated(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: _images.length,
//                     separatorBuilder: (_, __) => const SizedBox(width: 8),
//                     itemBuilder: (context, index) {
//                       return ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.file(
//                           File(_images[index].path),
//                           width: 80,
//                           height: 80,
//                           fit: BoxFit.cover,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],

//               const SizedBox(height: 24),

//               // ================= SUBMIT BUTTON =================
//               PrimaryBtnWidget(
//                 buttonText: 'Submit Complaint',
//                 onPressed: () {
//                   // API call / validation yahan aayegi
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:first/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:first/widgets/widgets.dart';

class AddComplaintsFormPage extends StatefulWidget {
  const AddComplaintsFormPage({super.key});

  @override
  State<AddComplaintsFormPage> createState() => _AddComplaintsFormPageState();
}

class _AddComplaintsFormPageState extends State<AddComplaintsFormPage> {
  final _orderNoController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  List<XFile> _images = [];

  @override
  void dispose() {
    _orderNoController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final pickedImages = await _picker.pickMultiImage();
    if (pickedImages.isNotEmpty) {
      setState(() => _images = pickedImages);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Complaint',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ================= BODY =================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order No
              buildFormField(
                controller: _orderNoController,
                label: 'Order No',
                icon: Icons.receipt_long,
                hintText: 'Enter order number',
              ),

              const SizedBox(height: 16),

              // Subject
              buildFormField(
                controller: _subjectController,
                label: 'Subject',
                icon: Icons.subject,
                hintText: 'Enter subject',
              ),

              const SizedBox(height: 16),

              // Auto Expanding Description
              _buildAutoExpandDescriptionField(),

              const SizedBox(height: 20),

              // ================= IMAGE PICKER =================
              const Text(
                'Attach Images',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),

              GestureDetector(
                onTap: _pickImages,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: const [
                      Icon(Icons.photo_library, color: Colors.grey),
                      SizedBox(height: 6),
                      Text(
                        'Tap to select images',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),

              if (_images.isNotEmpty) ...[
                const SizedBox(height: 12),
                SizedBox(
                  height: 80,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _images.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(_images[index].path),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // ================= SUBMIT BUTTON =================
              PrimaryBtnWidget(
                buttonText: 'Submit Complaint',
                onPressed: () {
                  // submit logic / API yahan aayegi
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= AUTO EXPANDING DESCRIPTION FIELD =================
  Widget _buildAutoExpandDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.message, size: 18, color: Colors.grey[600]),
            const SizedBox(width: 8),
            Text(
              'Description',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF999999),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        MultilineTextFieldWidget(
          controller: _messageController,
          labelText: 'Message',
          hintText: 'Write your message',
          maxLines: 10,
          minLines: 1,
          borderColor: Colors.grey.shade300,
        ),
      ],
    );
  }
}
