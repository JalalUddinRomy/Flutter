class Worker{
  String Company='XYZ';
  String Designation='Developer';
  double _sallary=9000;
  double get getSallary{ //Getter Method
    return _sallary;
  }
  void set setSallary(double newSallary){//setterMethod
    if((newSallary > _sallary) && (newSallary < (_sallary+4000)))
    {
      _sallary=newSallary;
    }
  }
}
