import 'package:flutter/material.dart';
import '../widgets/faq_widget.dart';
import '../app_colors.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  late List<FAQItem> _faqs;

  @override
  void initState() {
    super.initState();
    _faqs = [
      FAQItem(
        id: '1',
        question: 'How can I contact customer support?',
        answer:
            'You can contact our customer support team through email, live chat, or the contact form available in the app. Our team is available to assist you with any queries or issues.',
      ),
      FAQItem(
        id: '2',
        question: 'What is the customer support working hours?',
        answer:
            'Our customer support team is available from Monday to Saturday, 9:00 AM to 8:00 PM. Queries received outside working hours will be responded to on the next business day.',
      ),
      FAQItem(
        id: '3',
        question: 'How long does it take to get a response?',
        answer:
            'We usually respond within 24 hours. In case of urgent issues, live chat is the fastest way to get immediate assistance.',
      ),
      FAQItem(
        id: '4',
        question: 'Can I contact support for order-related issues?',
        answer:
            'Yes, you can contact us for any order-related concerns such as order tracking, cancellations, refunds, or delivery issues. Please keep your order ID ready for faster assistance.',
      ),
      FAQItem(
        id: '5',
        question: 'Where can I find your email address?',
        answer:
            'You can find our official email address in the app under the Contact Us section or on our website. Feel free to email us anytime with your questions or feedback.',
      ),
      FAQItem(
        id: '6',
        question: 'Is live chat support available?',
        answer:
            'Yes, live chat support is available during working hours. It allows you to directly communicate with our support team for quick resolutions.',
      ),
      FAQItem(
        id: '7',
        question: 'Can I give feedback or suggestions?',
        answer:
            'Absolutely! We value your feedback and suggestions. You can share them via email or through the feedback option available in the app.',
      ),
      FAQItem(
        id: '8',
        question: 'What should I do if I face a technical issue?',
        answer:
            'If you experience any technical issues, please contact our support team with details such as screenshots or error messages. This will help us resolve the issue more efficiently.',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.textBlack87,
            size: 20,
          ),
        ),
        title: const Text(
          'Contact Us',
          style: TextStyle(
            color: AppColors.textBlack87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FAQWidget(faqs: _faqs, title: "FAQ's"),
            const SizedBox(height: 32),
            _buildGetInTouchSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildGetInTouchSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Get in Touch Header
          const Text(
            'Get in touch',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppColors.textBlack87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Still Need Help?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack87,
            ),
          ),
          const SizedBox(height: 20),

          // Contact Information
          const Text(
            'Contact Us:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack87,
            ),
          ),
          const SizedBox(height: 16),

          // Phone
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.phone, color: AppColors.backgroundWhite, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '051-111-693-693',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlack87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '9:00AM to 5:00PM [Mon-Sun]',
                    style: TextStyle(fontSize: 12, color: AppColors.formGrey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Email
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.email, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'hello@priceeye.pk',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlack87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '9:00AM to 5:00PM [Mon-Sat]',
                    style: TextStyle(fontSize: 12, color: AppColors.formGrey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Our Locations
          const Text(
            'Our Locations',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack87,
            ),
          ),
          const SizedBox(height: 16),

          Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderGrey),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[50],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2196F3).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.location_on,
                        color: AppColors.primaryBlue,
                        size: 42,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // 🔑 THIS IS THE FIX
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Karachi',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textBlack87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '456, Shahrah-e-Faisal, Karachi, Pakistan',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textBlack87,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'contact@laptophorbour.com',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textBlack87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '1234567890',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textBlack87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 12),
              // Container(
              //   width: double.infinity,
              //   padding: const EdgeInsets.all(20),
              //   decoration: BoxDecoration(
              //     border: Border.all(color: const Color(0xFFE0E0E0)),
              //     borderRadius: BorderRadius.circular(12),
              //     color: Colors.grey[50],
              //   ),
              //   child: Column(
              //     children: [
              //       Container(
              //         width: 50,
              //         height: 50,
              //         decoration: BoxDecoration(
              //           color: const Color(0xFF2196F3).withOpacity(0.1),
              //           borderRadius: BorderRadius.circular(8),
              //         ),
              //         child: const Icon(
              //           Icons.apartment,
              //           color: Color(0xFF2196F3),
              //           size: 28,
              //         ),
              //       ),
              //       const SizedBox(height: 12),
              //       const Text(
              //         '3 Warehouses\nacross Pakistan',
              //         textAlign: TextAlign.start,
              //         style: TextStyle(
              //           fontSize: 13,
              //           fontWeight: FontWeight.w600,
              //           color: Colors.black87,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),

          const SizedBox(height: 32),

          // Updates Section
          // const Text(
          //   'Updates',
          //   style: TextStyle(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w600,
          //     color: Colors.black87,
          //   ),
          // ),
          // const SizedBox(height: 16),
          // const Text(
          //   'To stay up to date on what\'s new, please subscribe to our media channels:',
          //   style: TextStyle(
          //     fontSize: 13,
          //     color: Color(0xFF666666),
          //     height: 1.5,
          //   ),
          // ),
          // const SizedBox(height: 20),

          // // Social Media Icons
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     _buildSocialIcon(Icons.facebook, const Color(0xFF1877F2)),
          //     const SizedBox(width: 12),
          //     _buildSocialIcon(Icons.camera_alt, const Color(0xFFE4405F)),
          //     const SizedBox(width: 12),
          //     _buildSocialIcon(Icons.music_note, const Color(0xFF000000)),
          //   ],
          // ),
          // const SizedBox(height: 32),

          // Footer with Priceøye branding
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF2196F3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Laptop Harbour',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIconWhite(Icons.facebook),
                      const SizedBox(width: 12),
                      _buildSocialIconWhite(Icons.camera_alt),
                      const SizedBox(width: 12),
                      _buildSocialIconWhite(Icons.music_note),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 22),
    );
  }

  Widget _buildSocialIconWhite(IconData icon) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}
