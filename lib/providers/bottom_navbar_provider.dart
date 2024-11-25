import 'package:flutter/material.dart';

class BottomNavbarProvider extends ChangeNotifier{
  int _curInd=0;
  int get curInd => _curInd;
  void changeCurINd ({required int value}){
    _curInd=value;
    notifyListeners();
  }
}