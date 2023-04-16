import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkour_app/data/data_repo.dart';

class SpaceCubit extends Cubit<int> {
  SpaceCubit(this._repository) : super(0)
  {
    _authenticationStatusSubscription = _repository.status.listen((status) {
      i++;
      emit(i);
    });
  }
  final DataRepo _repository;
  int i=0;
  spaceSelection(int row, int column) {
    for (var element in _repository.slots.values) {
      for (var space in element) {
        space.selected = false;
      }
    }
    i++;
    _repository.slots[row]?[column-1].selected = true;//columns start from 1
    emit(i);
  }
  late StreamSubscription<bool> _authenticationStatusSubscription;
}