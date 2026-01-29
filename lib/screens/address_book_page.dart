// import 'package:first/core/app_imports.dart';
// // import 'package:first/screens/address_drawer_form.dart';

// class AddressScreen extends StatefulWidget {
//   const AddressScreen({super.key});

//   @override
//   _AddressScreenState createState() => _AddressScreenState();
// }

// getUserAddresses() async {
//   // Dummy userId for demonstration; replace with actual user session logic
//   int userId = session.userId!;
//   AddressService addressService = AddressService();
//   List<Map<String, dynamic>>? addresses = await addressService.getUserAddresses(userId);

//   if (addresses != null) {
//     print('User Addresses:');
//     for (var address in addresses) {
//       print(address);
//     }
//   } else {
//     print('Failed to fetch addresses.');
//   }
// }

// class _AddressScreenState extends State<AddressScreen> {
//   List<Map<String, String>> addresses = [
//     {
//       'label': 'Home',
//       'tag': 'Default',
//       // 'number': '1234567890',
//       'address': '61480 Outbrook Park, PC 5679',
//     },
//     {
//       'label': 'Office',
//       'tag': '',
//       // 'number': '1234567890',
//       'address': '699 Meadow Valley Terra, PC 3637',
//     },
//     {
//       'label': 'Apartment',
//       'tag': '',
//       // 'number': '1234567890',
//       'address': '2183 Clyde Gallagher, PC 4642',
//     },
//     {
//       'label': "Parent's House",
//       'tag': '',
//       // 'number': '1234567890',
//       'address': '5299 Blue Bill Park, PC 4627',
//     },
//     {
//       'label': 'Town Square',
//       'tag': '',
//       // 'number': '1234567890',
//       'address': '5373 Summerhouse, PC 4627',
//     },
//   ];

//   void _showAddressForm({Map<String, String>? editingAddr, int? index}) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: AppColors.transparent,
//       builder: (context) {
//         return AddressFormDialog(
//           editingAddr: editingAddr,
//           index: index,
//           addresses: addresses,
//           onSave: () => setState(() {}),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Replace session check with a safe return of EmptyStateWidget
//     if (session.userId == null) {
//       return Scaffold(
//         appBar: AppBar(title: const Text('Address Book')),
//         body: Center(
//           child: EmptyStateWidget(
//             icon: Icons.error_outline,
//             emptyMessage: 'Please log in to manage addresses.',
//             buttonText: 'Go to Login',
//             onButtonPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                 return const LoginPage();
//               }));
//             },
//           ),
//         ),
//       );
//     }
//     return Scaffold(
//       appBar: AppBar(title: const Text('Address Book')),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: addresses.length,
//               itemBuilder: (context, index) {
//                 final addr = addresses[index];
//                 return AddressItem(
//                   label: addr['label']!,
//                   tag: addr['tag']!,
//                   address: addr['address']!,
//                   onEdit: () => _showAddressForm(
//                     editingAddr: Map.from(addr),
//                     index: index,
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: PrimaryBtnWidget(
//               buttonText: 'Add New Address',
//               onPressed: () {
//                 _showAddressForm();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:first/core/app_imports.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final AddressService _addressService = AddressService();

  List<Map<String, dynamic>> addresses = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserAddresses();
  }

  Future<void> _fetchUserAddresses() async {
    if (session.userId == null) {
      setState(() => _loading = false);
      return;
    }

    try {
      final userId = session.userId!;
      final result = await _addressService.getUserAddresses(userId);

      if (result != null) {
        print('📦 Addresses received in screen:');
        for (var addr in result) {
          print(addr);
        }

        setState(() {
          addresses = result;
        });
      }
    } catch (e) {
      print('❌ Error loading addresses in screen: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  void _showAddressForm({Map<String, dynamic>? editingAddr, int? index}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (context) {
        return AddressFormDialog(
          editingAddr: editingAddr,
          onSave: (String? message) {
            if (message != null) {
              ScaffoldMessenger.of(this.context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: message.startsWith('✅')
                      ? Colors.green
                      : Colors.red,
                ),
              );
            }
            _fetchUserAddresses();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 🔐 Not logged in
    if (session.userId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Address Book')),
        body: Center(
          child: EmptyStateWidget(
            icon: Icons.error_outline,
            emptyMessage: 'Please log in to manage addresses.',
            buttonText: 'Go to Login',
            onButtonPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Address Book')),

      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : addresses.isEmpty
          ? const Center(child: Text('No addresses found'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      final addr = addresses[index];
                      return AddressItem(
                        label: addr['addressLine2'] ?? 'Address',
                        tag: addr['isDefault'] == true ? 'Default' : '',
                        address: '${addr['addressLine1']}, ${addr['cityName']}',
                        onEdit: () => _showAddressForm(
                          editingAddr: Map.from(addr),
                          index: index,
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: PrimaryBtnWidget(
                    buttonText: 'Add New Address',
                    onPressed: () => _showAddressForm(),
                  ),
                ),
              ],
            ),
    );
  }
}
