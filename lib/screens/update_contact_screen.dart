import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vp9_database/get/contact_getx_controller.dart';
import 'package:vp9_database/models/contact.dart';
import 'package:vp9_database/provider/contact_provider.dart';
import 'package:vp9_database/utils/helpers.dart';
import 'package:vp9_database/widgets/app_text_field.dart';

class UpdateContactScreen extends StatefulWidget {
  const UpdateContactScreen({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final Contact contact;

  @override
  _UpdateContactScreenState createState() => _UpdateContactScreenState();
}

class _UpdateContactScreenState extends State<UpdateContactScreen>
    with Helpers {
  late TextEditingController _nameTextController;
  late TextEditingController _phoneTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTextController = TextEditingController(text: widget.contact.name);
    _phoneTextController = TextEditingController(text: widget.contact.phone);
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
        title: const Text('Update Contact'),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          const Text(
            'Enter updated contact data..',
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
    // bool updated = await Provider.of<ContactProvider>(context, listen: false)
    //     .update(contact: contact);
    bool updated = await ContactGetxController.to.updateContact(contact: contact);
    if (updated) Navigator.pop(context);
    String message = updated ? 'Updated successfully' : 'Update failed';
    showSnackBar(context: context, message: message, error: !updated);
  }

  Contact get contact {
    // Contact contact = Contact();
    // contact.id = widget.contact.id;
    Contact contact = widget.contact;
    contact.name = _nameTextController.text;
    contact.phone = _phoneTextController.text;
    return contact;
  }
}
