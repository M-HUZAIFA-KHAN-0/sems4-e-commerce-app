import 'package:first/core/app_imports.dart';
import 'package:first/services/api/user_profile_service.dart';
import 'package:first/models/user_profile_model.dart';
import 'package:first/models/user_model.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, String>? initialUserData;
  final Map<String, String>? initialProfileData;
  final String? initialProfileImagePath;

  const EditProfilePage({
    super.key,
    this.initialUserData,
    this.initialProfileData,
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
  late TextEditingController _bioController;

  CroppedFile? _profileImage;
  bool _isSaveEnabled = false;
  bool _isLoading = false;
  bool _isLoadingData = true;
  String? _errorMessage;

  // Add profile service
  final UserProfileService _profileService = UserProfileService();

  @override
  void initState() {
    super.initState();

    // Initialize text controllers with empty values
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _bioController = TextEditingController();

    _firstNameController.addListener(_onFieldChanged);
    _lastNameController.addListener(_onFieldChanged);
    _emailController.addListener(_onFieldChanged);
    _phoneController.addListener(_onFieldChanged);
    _bioController.addListener(_onFieldChanged);

    // Fetch fresh data from server
    _loadProfileDataForEdit();
  }

  Future<void> _loadProfileDataForEdit() async {
    try {
      final userId = UserSessionManager().userId;
      print('📝 [EditProfilePage] Loading profile data for userId: $userId');

      if (userId == null || userId <= 0) {
        setState(() {
          _errorMessage = 'User not logged in';
          _isLoadingData = false;
        });
        return;
      }

      // Fetch fresh user and profile data
      final results = await Future.wait([
        _profileService.fetchUserData(userId: userId),
        _profileService.fetchUserProfile(userId: userId),
      ], eagerError: true);

      final userData = results[0] as UserModel?;
      final userProfile = results[1] as UserProfileModel?;

      if (mounted) {
        print('✅ [EditProfilePage] Data loaded:');
        print('   • FirstName: ${userData?.firstName}');
        print('   • LastName: ${userData?.lastName}');
        print('   • Email: ${userData?.email}');
        print('   • Phone: ${userData?.phoneNumber}');
        print('   • Bio: ${userProfile?.bio}');
        print('   • Image: ${userProfile?.profileImage}');

        // Set controller values with fetched data
        _firstNameController.text = userData?.firstName ?? '';
        _lastNameController.text = userData?.lastName ?? '';
        _emailController.text = userData?.email ?? '';
        _phoneController.text = userData?.phoneNumber ?? '';
        _bioController.text = userProfile?.bio ?? '';

        // Set profile image if available
        if (userProfile?.profileImage != null &&
            userProfile!.profileImage!.isNotEmpty) {
          // For network image, we'll just keep the URL
          // In production, you might want to download it locally
          print(
            '📸 [EditProfilePage] Profile image: ${userProfile.profileImage}',
          );
        }

        setState(() {
          _isLoadingData = false;
          _errorMessage = null;
        });
      }
    } catch (e) {
      print('❌ [EditProfilePage] Error loading data: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to load profile: ${e.toString()}';
          _isLoadingData = false;
        });
      }
    }
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
      final userId = UserSessionManager().userId;
      if (userId == null || userId <= 0) {
        throw Exception('User not logged in');
      }

      final firstName = _firstNameController.text.trim();
      final lastName = _lastNameController.text.trim();
      final email = _emailController.text.trim();
      final phoneNumber = _phoneController.text.trim();
      final bio = _bioController.text.trim();

      print(
        '💾 [EditProfilePage] Saving full profile - userId: $userId, firstName: $firstName, lastName: $lastName, email: $email, phone: $phoneNumber, bio: $bio',
      );

      // Update full profile (user data + profile data in one request)
      final success = await _profileService.updateFullProfile(
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        bio: bio,
        imagePath: _profileImage?.path,
      );

      if (!success) {
        throw Exception('Failed to update profile');
      }

      if (mounted) {
        print('✅ [EditProfilePage] Profile updated successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Profile updated successfully')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint('Save error: $e');
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _onCancel() => Navigator.pop(context);

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
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
      body: _isLoadingData
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  const Text('Loading profile data...'),
                ],
              ),
            )
          : _errorMessage != null && _errorMessage!.contains('Failed')
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadProfileDataForEdit,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
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
                          border: Border.all(
                            color: AppColors.textBlack,
                            width: 2,
                          ),
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
                  const SizedBox(height: 16),
                  AuthField(
                    hint: 'Last Name',
                    controller: _lastNameController,
                    prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),
                  AuthField(
                    hint: 'Email',
                    controller: _emailController,
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    readOnly: true,
                  ),
                  const SizedBox(height: 16),
                  AuthField(
                    hint: 'Phone Number',
                    controller: _phoneController,
                    prefixIcon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const SizedBox(height: 16),
                  AuthField(
                    hint: 'Bio',
                    controller: _bioController,
                    prefixIcon: Icons.info_outline,
                    // maxLines: 3,
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
                    backgroundColor: _isSaveEnabled
                        ? Colors.black
                        : Colors.grey,
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
