import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/models/models.dart';
import '../../../repositories/tours_repository.dart';
import 'tours_event.dart';
import 'tours_state.dart';


class ToursBloc extends Bloc<ToursEvent, ToursState> {
  final ToursRepository toursRepository;

  ToursBloc({required this.toursRepository}) : super(const ToursLoading()) {
    on<ToursLoad>(_onToursLoad);
  }

  void _onToursLoad(
    ToursLoad event,
    Emitter<ToursState> emit,
  ) async {
    emit(const ToursLoading());

    try {
      final List<Tour> allTours = await toursRepository.getAllTours();
      emit(ToursLoaded(tours: allTours));
    } catch (e) {
      emit(ToursError(error: e.toString()));
    }
  }


}
