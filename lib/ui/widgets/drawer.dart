import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/bloc/auth/auth.dart';
import 'package:mobile_version/data/config/config.dart';
import 'package:mobile_version/utils/utils.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return Drawer(child: SafeArea(
      // color: Colors.grey[50],
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Colors.blue, Colors.blueAccent]),
                ),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: new NetworkImage(state.image)))),
                      Text(state.username,
                          textScaleFactor: textScaleFactor, maxLines: 1),
                      Text(state.email,
                          textScaleFactor: textScaleFactor, maxLines: 1),
                    ],
                  ),
                ),
              ),
              _createDrawerItem(
                  icon: Icons.collections_bookmark,
                  text: state.menuResponse[3].children[1].name,
                  onTap: () => Navigator.of(context)
                      .popAndPushNamed(ArchSampleRoutes.item),
                  showList: true),
              Divider(),
              _createDrawerItem(
                  icon: Icons.arrow_back,
                  text: "Logout",
                  onTap: () =>
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context).popAndPushNamed("/");
                        authenticationBloc.add(LoggedOut());
                      }),
                  showList: true)
            ],
          );
        }
        return Center(child: CircularProgressIndicator());
      }),
    ));
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap, bool showList}) {
    return Visibility(
      visible: showList,
      child: ListTile(
        title: Row(
          children: <Widget>[
            Icon(icon),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(text),
            )
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
