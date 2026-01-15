// import 'package:flutter/material.dart';
// import 'dart:io';
// import '../widgets/widgets.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:flutter/foundation.dart'; // for kIsWeb
// class EditProfilePage extends StatefulWidget {
//   /// Optional: pass existing profile data to pre-fill fields
//   final Map<String, String>? initialData;
//   final File? initialProfileImage;

//   const EditProfilePage({
//     super.key,
//     this.initialData,
//     this.initialProfileImage,
//   });

//   @override
//   State<EditProfilePage> createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   late TextEditingController _firstNameController;
//   late TextEditingController _lastNameController;
//   late TextEditingController _emailController;
//   late TextEditingController _phoneController;

//   File? _profileImage;
//   bool _isSaveEnabled = false;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _profileImage = widget.initialProfileImage;

//     // Initialize controllers with existing data if provided
//     _firstNameController = TextEditingController(
//       text: widget.initialData?['firstName'] ?? '',
//     );
//     _lastNameController = TextEditingController(
//       text: widget.initialData?['lastName'] ?? '',
//     );
//     _emailController = TextEditingController(
//       text: widget.initialData?['email'] ?? '',
//     );
//     _phoneController = TextEditingController(
//       text: widget.initialData?['phone'] ?? '',
//     );

//     // Add listeners to detect changes
//     _firstNameController.addListener(_onFieldChanged);
//     _lastNameController.addListener(_onFieldChanged);
//     _emailController.addListener(_onFieldChanged);
//     _phoneController.addListener(_onFieldChanged);
//   }

//   void _onFieldChanged() {
//     // Enable save button if any field has changed
//     setState(() {
//       _isSaveEnabled = _firstNameController.text.isNotEmpty ||
//           _lastNameController.text.isNotEmpty ||
//           _emailController.text.isNotEmpty ||
//           _phoneController.text.isNotEmpty;
//     });
//   }

// void _onChangeProfilePicture() async {
//    final CroppedFile? pickedImage =
//       await ImagePickerCropperModule.pickAndCropImage(
//     context: context,
//     aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
//   );


//     if (pickedImage != null) {
//       setState(() {
//         _profileImage = pickedImage;
//         _isSaveEnabled = true; // Enable save when image changes
//       });
//     }
//   }

//   void _onSave() async {
//     if (!_isSaveEnabled) return;

//     setState(() => _isLoading = true);

//     try {
//       // Simulate saving data (replace with actual API call)
//       await Future.delayed(const Duration(seconds: 1));

//       // TODO: Send data to backend
//       final profileData = {
//         'firstName': _firstNameController.text,
//         'lastName': _lastNameController.text,
//         'email': _emailController.text,
//         'phone': _phoneController.text,
//         'profileImage': _profileImage?.path,
//       };

//       print('Profile updated: $profileData');

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Profile updated successfully'),
//             duration: Duration(seconds: 2),
//           ),
//         );

//         // Return to previous screen after a short delay
//         await Future.delayed(const Duration(milliseconds: 500));
//         if (mounted) {
//           Navigator.pop(context, profileData);
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error updating profile: $e'),
//             duration: const Duration(seconds: 2),
//           ),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   void _onCancel() {
//     // Discard changes and go back
//     Navigator.pop(context);
//   }

//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: GestureDetector(
//           onTap: _onCancel,
//           child: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black87,
//             size: 20,
//           ),
//         ),
//         title: const Text(
//           'Edit Profile',
//           style: TextStyle(
//             color: Colors.black87,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: false,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//         child: Column(
//           children: [
//             // Profile Image Section
//             Center(
//               child: Stack(
//                 children: [
//                   // Circular Profile Image
//                   Container(
//                     width: 120,
//                     height: 120,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: Colors.black,
//                         width: 2,
//                       ),
//                       color: Colors.grey[200],
//                       image: _profileImage != null
//                           ? DecorationImage(
//                               image: FileImage(_profileImage!),
//                               fit: BoxFit.cover,
//                             )
//                           : null,
//                     ),
//                     child: _profileImage == null
//                         ? Icon(
//                             Icons.person,
//                             size: 60,
//                             color: Colors.grey[400],
//                           )
//                         : null,
//                   ),
//                   // Plus Icon Button
//                   Positioned(
//                     bottom: 0,
//                     left: 0,
//                     child: GestureDetector(
//                       onTap: _onChangeProfilePicture,
//                       child: Container(
//                         width: 36,
//                         height: 36,
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.black,
//                         ),
//                         child: const Icon(
//                           Icons.add,
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 32),

//             // Input Fields Section
//             Column(
//               children: [
//                 // First Name Field
//                 AuthField(
//                   hint: 'First Name',
//                   controller: _firstNameController,
//                   prefixIcon: Icons.person_outline,
//                 ),
//                 const SizedBox(height: 14),

//                 // Last Name Field
//                 AuthField(
//                   hint: 'Last Name',
//                   controller: _lastNameController,
//                   prefixIcon: Icons.person_outline,
//                 ),
//                 const SizedBox(height: 14),

//                 // Email Field
//                 AuthField(
//                   hint: 'Email Address',
//                   controller: _emailController,
//                   prefixIcon: Icons.email_outlined,
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//                 const SizedBox(height: 14),

//                 // Phone Number Field
//                 AuthField(
//                   hint: 'Phone Number',
//                   controller: _phoneController,
//                   prefixIcon: Icons.phone_outlined,
//                   keyboardType: TextInputType.phone,
//                 ),
//               ],
//             ),

//             const SizedBox(height: 40),

//             // Save Button
//             PrimaryBtnWidget(
//               buttonText: 'Save',
//               onPressed: _isSaveEnabled && !_isLoading ? _onSave : () {},
//               backgroundColor: _isSaveEnabled ? Colors.black : Colors.grey[400],
//               height: 50,
//             ),

//             const SizedBox(height: 12),

//             // Cancel Button
//             GestureDetector(
//               onTap: _onCancel,
//               child: Container(
//                 width: double.infinity,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(26),
//                   border: Border.all(
//                     color: Colors.grey[300]!,
//                     width: 1.5,
//                   ),
//                   color: Colors.white,
//                 ),
//                 child: Center(
//                   child: Text(
//                     'Cancel',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w800,
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }







import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // kIsWeb
import 'dart:io' show File; // safe: only used behind !kIsWeb
import 'package:image_cropper/image_cropper.dart';

import '../widgets/widgets.dart';
// import '../widgets/image_picker_cropper_module.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, String>? initialData;
  final String? initialProfileImagePath; // web + mobile safe

  const EditProfilePage({
    super.key,
    this.initialData,
    this.initialProfileImagePath,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  CroppedFile? _profileImage;
  bool _isSaveEnabled = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.initialProfileImagePath != null) {
      _profileImage = CroppedFile(widget.initialProfileImagePath!);
    }

    _firstNameController =
        TextEditingController(text: widget.initialData?['firstName'] ?? '');
    _lastNameController =
        TextEditingController(text: widget.initialData?['lastName'] ?? '');
    _emailController =
        TextEditingController(text: widget.initialData?['email'] ?? '');
    _phoneController =
        TextEditingController(text: widget.initialData?['phone'] ?? '');

    _firstNameController.addListener(_onFieldChanged);
    _lastNameController.addListener(_onFieldChanged);
    _emailController.addListener(_onFieldChanged);
    _phoneController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    setState(() {
      _isSaveEnabled = true;
    });
  }

  // ================= IMAGE PICK =================

  void _onChangeProfilePicture() async {
     final CroppedFile? pickedImage =
      await ImagePickerCropperModule.pickAndCropImage(
        context: context,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      );

    if (pickedImage != null) {
      setState(() {
        _profileImage = pickedImage;
        _isSaveEnabled = true;
      });
    }
  }

  // ================= SAVE =================

  void _onSave() async {
    if (!_isSaveEnabled) return;

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 1));

    final profileData = {
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'profileImagePath': _profileImage?.path,
    };

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
      Navigator.pop(context, profileData);
    }

    setState(() => _isLoading = false);
  }

  void _onCancel() => Navigator.pop(context);

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: _onCancel,
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ================= PROFILE IMAGE =================

            Stack(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                    image: _profileImage != null
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: kIsWeb
                                ? NetworkImage(_profileImage!.path)
                                : FileImage(File(_profileImage!.path))
                                    as ImageProvider,
                          )
                        : null,
                  ),
                  child: _profileImage == null
                      ? const Icon(Icons.person, size: 60)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: GestureDetector(
                    onTap: _onChangeProfilePicture,
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.black,
                      child:
                          Icon(Icons.add, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            AuthField(
              hint: 'First Name',
              controller: _firstNameController,
              prefixIcon: Icons.person_outline,
            ),
            const SizedBox(height: 14),

            AuthField(
              hint: 'Last Name',
              controller: _lastNameController,
              prefixIcon: Icons.person_outline,
            ),
            const SizedBox(height: 14),

            AuthField(
              hint: 'Email',
              controller: _emailController,
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: 14),

            AuthField(
              hint: 'Phone',
              controller: _phoneController,
              prefixIcon: Icons.phone_outlined,
            ),

            const SizedBox(height: 40),

            PrimaryBtnWidget(
              buttonText: 'Save',
              onPressed:
                  _isSaveEnabled && !_isLoading ? _onSave : () {},
              backgroundColor:
                  _isSaveEnabled ? Colors.black : Colors.grey,
              height: 50,
            ),

            const SizedBox(height: 12),

            TextButton(
              onPressed: _onCancel,
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
