import 'package:flutter_bloc/flutter_bloc.dart';

import '../tour.dart';
import 'tours_event.dart';
import 'tours_state.dart';

class ToursBloc extends Bloc<ToursEvent, ToursState> {
  ToursBloc() : super(const ToursLoading()) {
    on<ToursLoad>(_onToursLoad);
  }

  void _onToursLoad(
    ToursLoad event,
    Emitter<ToursState> emit,
  ) async {
    emit(const ToursLoading());

    // await Future.delayed(const Duration(seconds: 1));
    bool isLoaded = true;

    List<Tour> tours = [
      Tour(
        title: 'Tour 1',
        description: 'Tour description...',
        distance: 2.3,
        time: 1.5,
        places: [
          Place(title: 'aa', description: ''),
          Place(title: 'bb', description: ''),
          Place(title: 'cc', description: ''),
        ],
      ),
      Tour(
        title: 'Tour 2',
        description: 'w' * 100,
        places: [],
        distance: 0.0,
        time: 0.0,
      ),
    ];

    if (isLoaded) {
      emit(ToursLoaded(tours: tours));
    } else {
      emit(const ToursError(error: 'loading error'));
    }
  }
}
