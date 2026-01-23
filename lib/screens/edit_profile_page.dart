import 'package:first/core/app_imports.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, String>? initialData;
  final String? initialProfileImagePath;

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
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    if (widget.initialProfileImagePath != null &&
        widget.initialProfileImagePath!.isNotEmpty) {
      _profileImage = CroppedFile(widget.initialProfileImagePath!);
    }

    _firstNameController = TextEditingController(
      text: widget.initialData?['firstName'] ?? '',
    );
    _lastNameController = TextEditingController(
      text: widget.initialData?['lastName'] ?? '',
    );
    _emailController = TextEditingController(
      text: widget.initialData?['email'] ?? '',
    );
    _phoneController = TextEditingController(
      text: widget.initialData?['phone'] ?? '',
    );

    _firstNameController.addListener(_onFieldChanged);
    _lastNameController.addListener(_onFieldChanged);
    _emailController.addListener(_onFieldChanged);
    _phoneController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    if (!_isSaveEnabled) {
      setState(() => _isSaveEnabled = true);
    }
  }

  Future<void> _onChangeProfilePicture() async {
    final CroppedFile? pickedImage =
        await ImagePickerCropperModule.pickAndCropImage(
          context: context,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        );

    if (pickedImage != null) {
      setState(() {
        _profileImage = pickedImage;
        _isSaveEnabled = true;
        _errorMessage = null;
      });
    } else {
      setState(() {
        _errorMessage = 'Image selection cancelled or failed.';
      });
    }
  }

  Future<void> _onSave() async {
    if (!_isSaveEnabled || _isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
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
    } catch (e) {
      debugPrint('Save error: $e');
      setState(() {
        _errorMessage = 'Failed to save profile. Please try again.';
      });
    } finally {
      if (mounted) _isLoading = false;
      setState(() {});
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
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
            Stack(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.textBlack, width: 2),
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
                      backgroundColor: AppColors.textBlack,
                      child: Icon(
                        Icons.add,
                        color: AppColors.backgroundWhite,
                        size: 20,
                      ),
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
            if (_errorMessage != null)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            PrimaryBtnWidget(
              buttonText: _isLoading ? 'Saving...' : 'Save',
              onPressed: _isSaveEnabled && !_isLoading ? _onSave : () {},
              backgroundColor: _isSaveEnabled ? Colors.black : Colors.grey,
              height: 50,
            ),
            const SizedBox(height: 12),
            TextButton(onPressed: _onCancel, child: const Text('Cancel')),
          ],
        ),
      ),
    );
  }
}
