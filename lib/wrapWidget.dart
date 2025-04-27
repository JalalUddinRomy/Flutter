import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) =>myApp()));
}
class myApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Home(),
    );
  }

}
class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData=MediaQuery.of(context);
    print(mediaQueryData.size.width);
    print(mediaQueryData.size.height);
   return Scaffold(
     appBar: AppBar(
       title: Text("Wrap Text"),
     ),
     body: OrientationBuilder(
       builder: (BuildContext context, Orientation orientation) {
         if(orientation==Orientation.portrait){
           return  Column(
             children: [
               Wrap(
                 alignment: WrapAlignment.center,
                 crossAxisAlignment: WrapCrossAlignment.center,
                 spacing: 0.5,
                 children: [
                   Text('Lomrem fioeopdj ojkfo'),
                   Text('Lomrem fioeopdj ojkfo'),
                   Text('Lomrem fioeopdj ojkfo'),
                   Text('Lomrem fioeopdj ojkfo'),
                   Text('Lomrem fioeopdj ojkfo'),
                   SizedBox(height: 32),
                   Text(orientation.name)
                 ],
               ),
             ],
           );
         }
         else{
           return Text(orientation.name);
         }


       },
       
     ),
   );
  }

}