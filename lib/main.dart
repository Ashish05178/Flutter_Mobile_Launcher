import 'package:flutter/material.dart';
import 'package:launcher_assist/launcher_assist.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var numberOfInstalledApps;
  var installedApps;
  var wallpaper;

  @override
 void initState() {
    super.initState();

    // Get all apps
    LauncherAssist.getAllApps().then((apps) {
      setState(() {
          numberOfInstalledApps = apps.length;
        installedApps = apps;
      });
    });

    LauncherAssist.getWallpaper().then((imageData) {
      setState(() {
        wallpaper = imageData;
      });
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.white,
             elevation: 0.0,
          ),
          body: 
          GridView.count(
        
          crossAxisCount: 3,
          children: List.generate(numberOfInstalledApps, (index) {
         
              return Container(
              color: Colors.white,
              child: FlatButton(
                color: Colors.white,
                child: Column(
                children: <Widget>[
                  new Image.memory(installedApps[index]["icon"],
                  fit: BoxFit.scaleDown, width: 48.0, height: 48.0),
                  Text(
                    installedApps[index]["label"]
                  ),
                ],  
              ),
               onPressed: () {
                   LauncherAssist.launchApp(installedApps[index]["package"]);         
               })
            );       
          }),
      ),
      ),
    );
  }
}