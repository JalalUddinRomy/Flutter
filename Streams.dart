import 'dart:async';
Stream<int> looping() async* {
  for(int i=0;i<10;i++){
   await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}
Future<void> main() async {
  await looping().listen((value) {
    print(value);
  });
}
//stream e onekgula data aksate deka jay or duration dewa jay
// kintu asynchronus e shudu ekta data duration or await koranu jay