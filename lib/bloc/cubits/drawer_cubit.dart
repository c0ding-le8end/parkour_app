import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerCubit extends Cubit<int>
{
  DrawerCubit():super(0);
  int _currentPage=0;

  int get currentPage=>_currentPage;

  changeCurrentPage(int value)
  {
    _currentPage=value;
    print(currentPage);
    emit(value);
  }
}