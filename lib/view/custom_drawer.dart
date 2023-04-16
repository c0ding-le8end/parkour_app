import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:parkour_app/bloc/cubits/drawer_cubit.dart';
import 'package:parkour_app/data/auth_repo.dart';
import 'package:parkour_app/view/history.dart';
import 'package:parkour_app/view/home/booking/available_spaces.dart';
import 'package:parkour_app/view/home/booking/booking.dart';
import 'package:parkour_app/view/home/booking/booking_root.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}
class CustomDrawerItems {
  static const home=SingleCustomDrawerItem("Home", Icons.home);
  static const history = SingleCustomDrawerItem("History", Icons.history);


  static const all = <SingleCustomDrawerItem>[
    home,
   history
  ];
}
class SingleCustomDrawerItem {
  final String title;

  const SingleCustomDrawerItem(this.title, this.icon);

  final IconData icon;
}
class _CustomDrawerState extends State<CustomDrawer> {
  SingleCustomDrawerItem currentItem=CustomDrawerItems.home;
  @override
  Widget build(BuildContext context) {
    final provider=BlocProvider.of<DrawerCubit>(context);
    return  ZoomDrawer(
      menuBackgroundColor:  Colors.white,
      menuScreen: const MenuScreen(),
      mainScreen: buildMenu(),
      angle: 0,
      showShadow: false,
      shadowLayer1Color: const Color(0xFF124E8E),
      shadowLayer2Color: Colors.transparent,
      mainScreenScale: 0.2,
    );
  }

  Widget buildMenu() {
    return BlocBuilder<DrawerCubit,int>(builder: (context,state)
    {
      switch(state)
      {
        case 0:
          return const BookingRoot();
        case 1:
          return const History();
        default:
          return const AvailableSpaces();
      }
    });
  }
}





class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor:  Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 25.0, left: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  ZoomDrawer.of(context)!.close();
                },
                child: Container(
                  height: 42,
                  width: 44,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                  child: const Icon(
                    Icons.clear,
                    color: Colors.black,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFF613EEA)),
                  ),
                  const Spacer(
                    flex: 10,
                  ),
                  Text(
                    "Hamdaan Sawar",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily:"OpenSans",
                        fontSize: 18),
                  ),
                  const Spacer(
                    flex: 10,
                  ),
                ],
              ),
              const SizedBox(height: 45,),
              for(int i=0;i<CustomDrawerItems.all.length;i++)
                makeTile(CustomDrawerItems.all[i],i,context),
              const Spacer(),
              Divider(color: Colors.black.withOpacity(0.6),),
              Container(height: 48,width: 219,
                margin: const EdgeInsets.only(bottom: 15),
                child: ListTile(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  onTap: (){
                    RepositoryProvider.of<AuthRepo>(context).logOut();
                  },
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Log Out",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),horizontalTitleGap: -10,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget makeTile(SingleCustomDrawerItem item,int index,BuildContext context) {
    final provider=BlocProvider.of<DrawerCubit>(context);
    return Builder(
      builder: (context) {
        return Container(height: 48,width: 219,
          margin: const EdgeInsets.only(bottom: 15),
          child: ListTile(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            onTap: (){
              switch(item.title)
              {
                case 'Home':
                  provider.changeCurrentPage(0);
                  ZoomDrawer.of(context)!.close();

                  break;
                case 'History':
                  provider.changeCurrentPage(1);
                  ZoomDrawer.of(context)!.close();
                  break;
              }
              setState(() {
                
              });
            },
            leading: Icon(
              item.icon,
              color: Colors.black,
            ),
            title: Text(
              item.title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),horizontalTitleGap: -10,
            tileColor: CustomDrawerItems.all.indexOf(item)==provider.currentPage?Colors.black.withOpacity(0.3):Colors.transparent,
          ),
        );
      }
    );
  }
}