import 'package:elancer_database_project/bloc/events/crud_event.dart';
import 'package:elancer_database_project/bloc/states/crud_state.dart';
import 'package:elancer_database_project/database/controllars/contact_db_controllar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/contact.dart';

class ContactBloc extends Bloc<CrudEvent, CrudState> {
  final ContactDbControllar _contactDbControllar = ContactDbControllar();
  List<Contact> _contacts = <Contact>[];

  ContactBloc(CrudState initialState) : super(initialState) {
    on<CreateEvent<Contact>>(_onCreate);
    on<ReadEvent>(_onRead);
    on<UpdateEvent<Contact>>(_onUpdate);
    on<DeleteEvent>(_onDelete);
  }

  void _onCreate(CreateEvent<Contact> event, Emitter emit) async {
    int newRowId = await _contactDbControllar.create(event.newObject);
    if (newRowId != 0) {
      event.newObject.id = newRowId;
      _contacts.add(event.newObject);
      emit(ReadState<Contact>(_contacts));
    }
    emit(
      ProcessState(
        Process.create,
        newRowId != 0,
        newRowId != 0 ? 'Created successfully' : 'Create Field !',
      ),
    );
  }

  void _onRead(ReadEvent event, Emitter emit) async {
    _contacts = await _contactDbControllar.read();
    emit(ReadState<Contact>(_contacts));
  }

  void _onUpdate(UpdateEvent<Contact> event, Emitter emit) async {
    bool updated = await _contactDbControllar.update(event.UpdateObject);
    if (updated) {
      int index = _contacts
          .indexWhere((element) => element.id == event.UpdateObject.id);
      _contacts[index] = event.UpdateObject;
      emit(ReadState<Contact>(_contacts));
    }
    emit(ProcessState(
      Process.update,
      updated,
      updated ? 'Updated successfully' : 'Updated Field !',
    ));
  }

  void _onDelete(DeleteEvent event, Emitter emit) async {
    bool deleted = await _contactDbControllar.delete(event.id);
    if (deleted) {
      _contacts.removeWhere((element) => element.id == event.id);
      emit(ReadState<Contact>(_contacts));
    }
    emit(
      ProcessState(
        Process.delete,
        deleted,
        deleted ? 'Deleted Successfully' : 'Deleted Field !',
      ),
    );
  }
}
