import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vp9_database/get/contact_getx_controller.dart';
import 'package:vp9_database/models/contact.dart';
import 'package:vp9_database/provider/contact_provider.dart';
import 'package:vp9_database/utils/helpers.dart';
import 'package:vp9_database/widgets/app_text_field.dart';

class CreateContactScreen extends StatefulWidget {
  const CreateContactScreen({Key? key}) : super(key: key);

  @override
  _CreateContactScreenState createState() => _CreateContactScreenState();
}

class _CreateContactScreenState extends State<CreateContactScreen>
    with Helpers {
  late TextEditingController _nameTextController;
  late TextEditingController _phoneTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTextController = TextEditingController();
    _phoneTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameTextController.dispose();
    _phoneTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Craete Contact'),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          const Text(
            'Enter new contact data..',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          AppTextField(
            textController: _nameTextController,
            hint: 'Name',
            prefixIcon: Icons.person,
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 10),
          AppTextField(
            textController: _phoneTextController,
            hint: 'Phone',
            prefixIcon: Icons.phone_android_outlined,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async => await performSave(),
            child: const Text('SAVE'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 50),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> performSave() async {
    if (checkData()) {
      await save();
    }
  }

  bool checkData() {
    if (_nameTextController.text.isNotEmpty &&
        _phoneTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
        context: context, message: 'Enter required data!', error: true);
    return false;
  }

  Future<void> save() async {
    // bool created = await Provider.of<ContactProvider>(context, listen: false)
    //     .create(contact: contact);
    bool created = await ContactGetxController.to.createContact(contact: contact);
    if (created) clear();
    String message = created ? 'Created successfully' : 'Create failed';
    showSnackBar(context: context, message: message, error: !created);
  }

  Contact get contact {
    Contact contact = Contact();
    contact.name = _nameTextController.text;
    contact.phone = _phoneTextController.text;
    return contact;
  }

  void clear() {
    _nameTextController.text = '';
    _phoneTextController.text = '';
  }
}
