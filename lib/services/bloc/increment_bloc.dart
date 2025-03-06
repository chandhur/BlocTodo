import 'package:firebase_notification/services/bloc/increment_event.dart';
import 'package:firebase_notification/services/bloc/increment_state.dart';
import 'package:bloc/bloc.dart';

class IncrementBloc extends Bloc<IncrementEvent, IncrementState> {

  IncrementBloc() : super(const IncrementState()) {
    on<AddEvent>((event, emit) => mapAdd(event, emit));
    on<MinEvent>((event, emit) => mapRemove(event, emit));
  }

 void  mapAdd(AddEvent event, Emitter<IncrementState> emit) {
   int updateData = state.count + 1;
   emit(state.copyWith(updateData));
  }

  void mapRemove(MinEvent event , Emitter<IncrementState> emit) {
    int updateData = state.count -1 ;
    if(state.count != 0){
      emit(state.copyWith(updateData));
    }

  }
}
