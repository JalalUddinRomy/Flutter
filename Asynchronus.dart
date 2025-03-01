void anynMethod(){
  print('New A');
  Future.delayed(Duration(seconds:  4)).then((_){
    print("New B");// ei line print korar Jonno 4 sec time nibe.
  });
  print('New C');
}
Future<int> sum(int a,int b) async{
  await Future.delayed(Duration(seconds: 5));
  return a+b;
}
Future<void> main() async {
  anynMethod();
  int result= await sum(8, 9);
  print(result);

}