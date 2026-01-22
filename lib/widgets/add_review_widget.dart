import 'package:first/core/app_imports.dart';

class AddReviewWidget extends StatefulWidget {
  final String productId;
  final String productName;
  final String productImage;
  final VoidCallback? onSubmit;

  const AddReviewWidget({
    super.key,
    required this.productId,
    required this.productName,
    required this.productImage,
    this.onSubmit,
  });

  @override
  State<AddReviewWidget> createState() => _AddReviewWidgetState();
}

class _AddReviewWidgetState extends State<AddReviewWidget> {
  final _reviewController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  int _rating = 0;
  List<XFile> _reviewImages = [];

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final pickedImages = await _picker.pickMultiImage();
    if (pickedImages.isNotEmpty) {
      setState(() => _reviewImages = pickedImages);
    }
  }

  void _removeImage(int index) {
    setState(() => _reviewImages.removeAt(index));
  }

  void _submitReview() {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a rating')),
      );
      return;
    }

    if (_reviewController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write a review')),
      );
      return;
    }

    widget.onSubmit?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        foregroundColor: AppColors.textBlack87,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, size: 20),
        ),
        title: const Text(
          'Add Review',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductInfoCard(),
              const SizedBox(height: 24),

              _buildRatingSection(),
              const SizedBox(height: 20),

              _buildQualityCheckSection(),
              const SizedBox(height: 24),

              _buildReviewDescriptionField(),
              const SizedBox(height: 20),

              /// ✅ IMAGE PICKER (NEW FILE SE CALL)
              ReviewImagePicker(
                images: _reviewImages,
                onPickImages: _pickImages,
                onRemoveImage: _removeImage,
              ),

              const SizedBox(height: 24),

              // SizedBox(
              //   width: double.infinity,
              //   height: 48,
              //   child: ElevatedButton(
              //     onPressed: _submitReview,
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: AppColors.primaryBlue,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //     ),
              //     child: const Text(
              //       'Submit Review',
              //       style: TextStyle(
              //         color: AppColors.backgroundWhite,
              //         fontSize: 16,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //   ),
              // ),
              PrimaryBtnWidget(
                buttonText: 'Submit Review',
                onPressed: _submitReview,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfoCard() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            widget.productImage,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.borderGreyLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.image, color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            widget.productName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Column(
      children: [
        Text(
          _rating > 0
              ? 'Rate: $_rating star${_rating > 1 ? 's' : ''}'
              : 'How would you rate this product?',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _rating > 0 ? Colors.black87 : AppColors.textGreyLight,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () => setState(() => _rating = index + 1),
              child: Icon(
                index < _rating ? Icons.star : Icons.star_outline,
                color: index < _rating
                    ? AppColors.ratingFilled
                    : AppColors.ratingEmpty,
                size: 32,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildQualityCheckSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Quality Check',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.formGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewDescriptionField() {
    return TextField(
      controller: _reviewController,
      minLines: 6,
      maxLines: null,
      decoration: InputDecoration(
        hintText: 'Write Your Product Review Here',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
