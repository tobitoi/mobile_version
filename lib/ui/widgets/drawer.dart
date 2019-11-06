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
    return Drawer(
      child: SafeArea(   
        // color: Colors.grey[50],
        child: ListView(
          children: <Widget>[
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context,state){
                  if (state is AuthenticationAuthenticated){
                    return ListTile(
                      leading: SizedBox(
                        child: Image.network(state.image),
                      ),
                      title: Text(
                        state.username,
                        textScaleFactor: textScaleFactor,
                        maxLines: 1,
                      ),
                      subtitle: Text(
                        state.email,
                        textScaleFactor: textScaleFactor,
                        maxLines: 1,
                      ),
                    );
                    
                  }
                  return Center(child: CircularProgressIndicator());
                }
            ),
            
            Divider(),
             ListTile(
              leading: Icon(Icons.collections_bookmark),
              title: Text(
                'Item',
                textScaleFactor: textScaleFactor,
              ),
              onTap: () {
                Navigator.of(context).popAndPushNamed( ArchSampleRoutes.item);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.arrow_back),
              title: Text(
                'Logout',
                textScaleFactor: textScaleFactor,
              ),
              onTap: () => 
               SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).popAndPushNamed("/");
                authenticationBloc.add(LoggedOut());
              })
            ),
          ],
        ),
      ),
    );
  }
}
