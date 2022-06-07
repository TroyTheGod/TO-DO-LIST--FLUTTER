import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test_1/providers/item_provider.dart';
import 'package:test_1/utils/setting_share_preferences.dart';
import 'package:test_1/database/firebase_control.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool firebaseSwitch = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValueFromPreference();
    print("run getValueFromPreference()");
  }

  void getValueFromPreference() async {
    bool temp = false;
    temp = SettingPreferences.getFirebaseToggle();
    print("getValueFromPreference() : $firebaseSwitch");
    setState(() {
      firebaseSwitch = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: Colors.white,
            ),
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 160,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Settings'),
              centerTitle: true,
            ),
          ),
          SliverList(
            delegate: _delegate(),
          ),
        ],
      ),
    );
  }

  SwitchListTile firebaseSetting() {
    return (SwitchListTile(
      value: firebaseSwitch,
      onChanged: (bool toggle) async {
        print('toggle : $toggle');
        setState(() {
          firebaseSwitch = toggle;
        });
        await SettingPreferences.setFirebaseEnable(toggle);
        //todo turn on firebase
      },
      title: Text('Firebase'),
      subtitle: Text('Use firebase as storage'),
    ));
  }

  SliverChildBuilderDelegate _delegate() {
    return SliverChildBuilderDelegate(
      (context, index) {
        return Card(
          child: Column(
            children: [
              firebaseSetting(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: firebaseSwitch
                        ? () =>
                            FirebaseHelper().store(context.read<Item>().tomap())
                        : null,
                    child: Text('store'),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      context
                          .read<Item>()
                          .fromMap(await FirebaseHelper().restore());
                    },
                    child: Text('restore'),
                  )
                ],
              )
            ],
          ),
        );
      },
      childCount: 1,
    );
  }
}
