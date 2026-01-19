// import 'package:first/screens/address_drawer_form.dart';
// import 'package:first/widgets/widgets.dart';
// import 'package:flutter/material.dart';

// class AddressScreen extends StatefulWidget {
//   const AddressScreen({super.key});

//   @override
//   _AddressScreenState createState() => _AddressScreenState();
// }

// class _AddressScreenState extends State<AddressScreen> {
//   List<Map<String, String>> addresses = [
//     {
//       'label': 'Home',
//       'tag': 'Default',
//       'address': '61480 Outbrook Park, PC 5679',
//     },
//     {
//       'label': 'Office',
//       'tag': '',
//       'address': '699 Meadow Valley Terra, PC 3637',
//     },
//     {
//       'label': 'Apartment',
//       'tag': '',
//       'address': '2183 Clyde Gallagher, PC 4642',
//     },
//     {
//       'label': "Parent's House",
//       'tag': '',
//       'address': '5299 Blue Bill Park, PC 4627',
//     },
//     {'label': 'Town Square', 'tag': '', 'address': '5373 Summerhouse, PC 4627'},
//   ];

//   void _showAddressForm({Map<String, String>? editingAddr, int? index}) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) {
//         return DraggableScrollableSheet(
//           expand: false,
//           initialChildSize: 0.7,
//           minChildSize: 0.4,
//           maxChildSize: 1.0,
//           builder: (context, scrollController) {
//             return Container(
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//               ),
//               child: ListView(
//                 controller: scrollController,
//                 children: [
//                   // Header
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 8,
//                     ),
//                     child: Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.arrow_back),
//                           onPressed: () => Navigator.pop(context),
//                         ),
//                         Expanded(
//                           child: Text(
//                             editingAddr == null
//                                 ? 'Add New Address'
//                                 : 'Edit Address',
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         if (editingAddr != null) ...[
//                           Center(
//                             child: TextButton(
//                               onPressed: () {},
//                               child: const Text(
//                                 'Delete Address',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.red,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ],
//                     ),
//                   ),
//                   // Form
//                   Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: AddressForm(
//                       existing: editingAddr,
//                       onSave: (newMap, isDefault) {
//                         setState(() {
//                           if (isDefault) {
//                             for (var addr in addresses) {
//                               addr['tag'] = '';
//                             }
//                             newMap['tag'] = 'Default';
//                           } else {
//                             newMap['tag'] = '';
//                           }
//                           if (index != null) {
//                             addresses[index] = newMap;
//                           } else {
//                             addresses.add(newMap);
//                           }
//                         });
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Address')),
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
//             child: SizedBox(
//               width: double.infinity,
//               height: 48,
//               child: ElevatedButton(
//                 onPressed: () {
//                   _showAddressForm();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.black,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(26),
//                   ),
//                 ),
//                 child: const Text(
//                   'Add New Address',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w800,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:first/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  List<Map<String, String>> addresses = [
    {
      'label': 'Home',
      'tag': 'Default',
      // 'number': '1234567890',
      'address': '61480 Outbrook Park, PC 5679',
    },
    {
      'label': 'Office',
      'tag': '',
      // 'number': '1234567890',
      'address': '699 Meadow Valley Terra, PC 3637',
    },
    {
      'label': 'Apartment',
      'tag': '',
      // 'number': '1234567890',
      'address': '2183 Clyde Gallagher, PC 4642',
    },
    {
      'label': "Parent's House",
      'tag': '',
      // 'number': '1234567890',
      'address': '5299 Blue Bill Park, PC 4627',
    },
    {
      'label': 'Town Square',
      'tag': '',
      // 'number': '1234567890',
      'address': '5373 Summerhouse, PC 4627',
    },
  ];

  void _showAddressForm({Map<String, String>? editingAddr, int? index}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AddressFormDialog(
          editingAddr: editingAddr,
          index: index,
          addresses: addresses,
          onSave: () => setState(() {}),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Address Book')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final addr = addresses[index];
                return AddressItem(
                  label: addr['label']!,
                  tag: addr['tag']!,
                  address: addr['address']!,
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
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  _showAddressForm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                child: const Text(
                  'Add New Address',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
