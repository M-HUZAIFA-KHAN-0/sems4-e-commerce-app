import 'package:first/core/app_imports.dart';

class LogoutDrawer extends StatelessWidget {
  final VoidCallback onLogout;

  const LogoutDrawer({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min, // jitna content hai utni height
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Heading
          const Text(
            'Logout',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),
          const Divider(), // hr line

          const SizedBox(height: 12),
          const Text(
            'Are you sure you want to log out?',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          // Buttons row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Cancel button
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // close drawer
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.backgroundGreyLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),

              // Logout button
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // close drawer
                  onLogout(); // perform logout
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(color: AppColors.backgroundWhite),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
