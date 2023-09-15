import 'package:elancer_database_project/bloc/bloc/contact_bloc.dart';
import 'package:elancer_database_project/bloc/events/crud_event.dart';
import 'package:elancer_database_project/bloc/states/crud_state.dart';
import 'package:elancer_database_project/get/contact_getx_controllar.dart';
import 'package:elancer_database_project/get/language_getx_controllar.dart';
import 'package:elancer_database_project/helpers/helpers.dart';
import 'package:elancer_database_project/models/contact.dart';
import 'package:elancer_database_project/provider/contact_provider.dart';
import 'package:elancer_database_project/screens/update_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with Helpers {

  final ContactGetxControllar _contactGetxControllar = Get.put(ContactGetxControllar());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ContactBloc>(context).add(ReadEvent());
   // Provider.of<ContactProvider>(context , listen: false).read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
            AppLocalizations.of(context)!.main,
            style: TextStyle(
              color: Colors.black,
              fontSize: 25.sp,
            ),
        ),

        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushNamed(context, '/create_contact_screen');
              },
              icon:const Icon(
                Icons.add,
              color: Colors.black),
          ),

          IconButton(
            onPressed: (){
              LanguageGetxControllar.to.changeLanguage();
            },
            icon:const Icon(Icons.language),
          ),
          
          IconButton(
              onPressed: ()async{
               await Get.delete<ContactGetxControllar>();
                Navigator.pushReplacementNamed(context, '/login_screen');
              }
              , icon:const Icon(Icons.logout),
          ),


        ],
      ),


       body: BlocConsumer<ContactBloc , CrudState>(
         listenWhen: (previous, current) =>
         current is ProcessState && current.process == Process.delete,
         listener: (context, state) {
           if(state is ProcessState){
             showSnackBar(context: context, message: state.message , error: !state.status);
           }
         },

         buildWhen:(previous, current) =>
           current is LoadingState ||
           current is ReadState ||
           current is ErrorState,

         builder: (context, state) {
        if(state is LoadingState){
          return const Center(child: CircularProgressIndicator(),);
        }
        else if(state is ReadState<Contact>){
          if(state.list.isNotEmpty){
          return ListView.builder(
               padding: EdgeInsetsDirectional.zero,
               itemCount: state.list.length,
               itemBuilder: (context, index) {
                 return  Padding(
                   padding:  EdgeInsetsDirectional.symmetric(horizontal: 20.w , vertical: 20.h),
                   child:  ListTile(
                     onTap: () {
                       Navigator.push(context, MaterialPageRoute(
                         builder: (context) => UpdateContactScreen(contact: state.list[index]),
                       ),);
                     },
                     leading:const Icon(Icons.featured_play_list_outlined , color: Colors.blue,),
                     title: Text(state.list[index].name),
                     subtitle: Text(state.list[index].phone),
                     trailing: IconButton(
                         onPressed: ()  =>  delete(state.list[index].id),
                         icon:const Icon( Icons.delete, color: Colors.red,)
                     ),
                   ),
                 );
               },
             );}
          else{
            return  Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.warning, color: Colors.grey , size: 80.w,),
                       Text(
                        'No Data',
                        style: TextStyle(
                          fontSize: 30.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
          }
        }
        else{
          state as ErrorState;
          return Center(child: Text(state.message),);
        }
       },
       ),





     );
  }
  
  void delete (int id){
    BlocProvider.of<ContactBloc>(context).add(DeleteEvent(id));
  }
}
