
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkour_app/bloc/cubits/space_cubit.dart';
import 'package:parkour_app/data/data_repo.dart';

//parking area real time map where the user can check for available parking spaces
class Slot extends StatelessWidget {
  const Slot({Key? key, required this.row, required this.set,}) : super(key: key);
  final int row;
  final int set;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 118,
      height: 46,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: const Color(0xFF613EFA), boxShadow: [
        BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
            color: Colors.black.withOpacity(0.25)),
      ]),
      child: Row(
        children: [...RepositoryProvider.of<DataRepo>(context).slots[row]!.sublist(0+3*set,3*set+3).map((e){
          return Flexible(child: SelectionButton(space: e));
        }).toList()],
      ),
    );
  }
}

class SelectionButton extends StatefulWidget {
  const SelectionButton({
    super.key,
    required this.space,
  });

  final Space space;

  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  Map column = {1: "a", 2: "b", 3: "c",4:"d",5:"e",6:"f"};

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35,
      child: InkWell(
        onTap: () {

          if(widget.space.selected==false)
            {
BlocProvider.of<SpaceCubit>(context).spaceSelection(widget.space.rowId, widget.space.colId);
            }
        },
        child: widget.space.selected==true
            ? Container(
                width: 22,
                height: 36,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0xFF16FC72)),
                child: Center(
                  child: Text(
                    widget.space.rowId.toString() + column[widget.space.colId],
                    style: const TextStyle(
                        color: Color(0xFF3B414B),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )
            : ImageIcon(Space.imageProvider,color: widget.space.spaceColor,size: widget.space.size,),
      ),
    );
  }
}

class Space {

  static const ImageProvider imageProvider =
      AssetImage("assets/icons/car.png");
  final int rowId;
   Color spaceColor;
  bool selected = false;
  double size=28;

  Space(this.rowId, this.colId, {this.spaceColor = Colors.grey});

  final int colId;
}




