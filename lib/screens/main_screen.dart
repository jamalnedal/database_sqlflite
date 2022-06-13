import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vp9_database/get/contact_getx_controller.dart';
import 'package:vp9_database/provider/contact_provider.dart';
import 'package:vp9_database/screens/update_contact_screen.dart';
import 'package:vp9_database/utils/helpers.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with Helpers {
  final ContactGetxController _contactGetxController =
      Get.put<ContactGetxController>(ContactGetxController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Provider.of<ContactProvider>(context, listen: false).read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, '/create_contact_screen'),
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () async{
              await Get.delete<ContactGetxController>();
              Navigator.pushReplacementNamed(context, '/login_screen');
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Obx(() {
        if (ContactGetxController.to.loading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (ContactGetxController.to.contacts.isNotEmpty) {
          return ListView.builder(
            itemCount: ContactGetxController.to.contacts.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateContactScreen(
                          contact: ContactGetxController.to.contacts[index]),
                    ),
                  );
                },
                leading: const Icon(Icons.contacts),
                title: Text(ContactGetxController.to.contacts[index].name),
                subtitle: Text(ContactGetxController.to.contacts[index].phone),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red.shade700,
                  ),
                  onPressed: () async =>
                      delete(ContactGetxController.to.contacts[index].id),
                ),
              );
            },
          );
        } else {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.warning,
                  size: 85,
                  color: Colors.grey,
                ),
                Text(
                  'NO DATA',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                )
              ],
            ),
          );
        }
      }),
      // body: GetX<ContactGetxController>(
      //   builder: (ContactGetxController controller) {
      //     if (controller.loading.value) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (controller.contacts.isNotEmpty) {
      //       return ListView.builder(
      //         itemCount: controller.contacts.length,
      //         itemBuilder: (context, index) {
      //           return ListTile(
      //             onTap: () {
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) => UpdateContactScreen(
      //                       contact: controller.contacts[index]),
      //                 ),
      //               );
      //             },
      //             leading: const Icon(Icons.contacts),
      //             title: Text(controller.contacts[index].name),
      //             subtitle: Text(controller.contacts[index].phone),
      //             trailing: IconButton(
      //               icon: Icon(
      //                 Icons.delete,
      //                 color: Colors.red.shade700,
      //               ),
      //               onPressed: () async =>
      //                   delete(controller.contacts[index].id),
      //             ),
      //           );
      //         },
      //       );
      //     } else {
      //       return Center(
      //         child: Column(
      //           mainAxisSize: MainAxisSize.min,
      //           children: const [
      //             Icon(
      //               Icons.warning,
      //               size: 85,
      //               color: Colors.grey,
      //             ),
      //             Text(
      //               'NO DATA',
      //               style: TextStyle(
      //                 color: Colors.grey,
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: 24,
      //               ),
      //             )
      //           ],
      //         ),
      //       );
      //     }
      //   },
      // ),
      // body: GetBuilder<ContactGetxController>(
      //   //init: ContactGetxController(),
      //   // id: 'main',
      //   builder: (ContactGetxController controller) {
      //     if (controller.contacts.isNotEmpty) {
      //       return ListView.builder(
      //         itemCount: controller.contacts.length,
      //         itemBuilder: (context, index) {
      //           return ListTile(
      //             onTap: () {
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) => UpdateContactScreen(
      //                       contact: controller.contacts[index]),
      //                 ),
      //               );
      //             },
      //             leading: const Icon(Icons.contacts),
      //             title: Text(controller.contacts[index].name),
      //             subtitle: Text(controller.contacts[index].phone),
      //             trailing: IconButton(
      //               icon: Icon(
      //                 Icons.delete,
      //                 color: Colors.red.shade700,
      //               ),
      //               onPressed: () async =>
      //                   delete(controller.contacts[index].id),
      //             ),
      //           );
      //         },
      //       );
      //     } else {
      //       return Center(
      //         child: Column(
      //           mainAxisSize: MainAxisSize.min,
      //           children: const [
      //             Icon(
      //               Icons.warning,
      //               size: 85,
      //               color: Colors.grey,
      //             ),
      //             Text(
      //               'NO DATA',
      //               style: TextStyle(
      //                 color: Colors.grey,
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: 24,
      //               ),
      //             )
      //           ],
      //         ),
      //       );
      //     }
      //   },
      // ),
    );
  }

  Future<void> delete(int id) async {
    // bool deleted =
    //     await Provider.of<ContactProvider>(context, listen: false).delete(id);
    //ContactGetxController controller = Get.find<ContactGetxController>();
    bool deleted = await ContactGetxController.to.deleteContact(id);
    String message = deleted ? 'Deleted successfully' : 'Delete failed!';
    showSnackBar(context: context, message: message, error: !deleted);
  }
}
