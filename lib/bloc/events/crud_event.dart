

abstract class CrudEvent {}

class CreateEvent<T> extends CrudEvent{

  T newObject ;

  CreateEvent(this.newObject);
}

class ReadEvent extends CrudEvent{}

class UpdateEvent<T> extends CrudEvent{
  T UpdateObject ;

  UpdateEvent(this.UpdateObject);
}

class DeleteEvent extends CrudEvent{
  int id ;

  DeleteEvent(this.id);
}