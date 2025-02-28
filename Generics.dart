num sum<T extends num>(T num1,T num2) {
  return num1 + num2;
}
  void doSomething<T,V>(T value1,V value2){
    print('$value1,$value2');
  }

void main(){
   num total=sum<int>(9, 8);
   print(total);
   num doubletotal=sum<double>(9.8, 7.9);
   print(doubletotal);
   doSomething<String,int>('Jalal', 670);
}
//Generics use to increase code readibility,eikane function
// a T/V dara bujanu hoice dui doroner data type eitar maddome
// amra akta funtion er bibinno data type dia call kora jay