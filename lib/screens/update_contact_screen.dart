import 'package:elancer_database_project/bloc/bloc/contact_bloc.dart';
import 'package:elancer_database_project/bloc/events/crud_event.dart';
import 'package:elancer_database_project/bloc/states/crud_state.dart';
import 'package:elancer_database_project/get/contact_getx_controllar.dart';
import 'package:elancer_database_project/helpers/helpers.dart';
import 'package:elancer_database_project/models/contact.dart';
import 'package:elancer_database_project/provider/contact_provider.dart';
import 'package:elancer_database_project/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateContactScreen extends StatefulWidget {
   UpdateContactScreen({Key? key , required this.contact}) : super(key: key);

  final Contact contact ;

  @override
  State<UpdateContactScreen> createState() => _UpdateContactScreenState();
}

class _UpdateContactScreenState extends State<UpdateContactScreen>  with Helpers{

 late TextEditingController _nameEditingController;
 late TextEditingController _numberEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameEditingController = TextEditingController(text: widget.contact.name);
    _numberEditingController = TextEditingController(text: widget.contact.phone);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _numberEditingController.dispose();
    _nameEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
            AppLocalizations.of(context)!.update,
          style:  TextStyle(
            color: Colors.black,
            fontSize: 25.sp,
          ),
        ),
        centerTitle: true,
      ),

      body: BlocListener<ContactBloc , CrudState>(
        listenWhen: (previous, current) => current is ProcessState && current.process == Process.update,
        listener: (context, state) {
          if(state is ProcessState){
            showSnackBar(context: context, message: state.message , error: !state.status);
          }
        },
        child: ListView(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
          physics:const NeverScrollableScrollPhysics(),
          children: [
            SizedBox(height: 200.h,),
               AppTextField(
                   textEditingController: _nameEditingController,
                   hint: widget.contact.name,
                   prefixIcon: Icons.person,
               ),

               SizedBox(height: 50.h,),

               AppTextField(
                   textEditingController: _numberEditingController,
                   hint: widget.contact.phone,
                   prefixIcon: Icons.phone,
               ),

              SizedBox(height: 80.h,),

            ElevatedButton(
                onPressed: ()   =>   performUpdate(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan
              ),
                child: Text(
                    AppLocalizations.of(context)!.save,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ),
          ],
        ),
      ),

    );
  }


  void performUpdate()  {
  if(checkData()){
     update();
  }
  }

  bool checkData (){
    if(_nameEditingController.text.isNotEmpty &&
    _numberEditingController.text.isNotEmpty){
      return true;
    }
    showSnackBar(context: context, message: 'Enter Required Data' , error: true);
    return false;
  }

  void update ()  {
    //bool updated = await Provider.of<ContactProvider>(context , listen: false).update(contact);
   BlocProvider.of<ContactBloc>(context).add(UpdateEvent(contact));
   Navigator.pop(context);
  }

 Contact get contact{
    Contact contact = widget.contact;
    contact.name = _nameEditingController.text;
    contact.phone = _numberEditingController.text;
    return contact ;
 }


}


