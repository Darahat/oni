import 'package:flutter/material.dart';

ageiconChanger(age, _selectedGender) {
  if (age <= 12) {
    if (_selectedGender == 'Male') {
      return Image.asset(
        'assets/icons/boy.png',
      );
    } else if (_selectedGender == 'Female') {
      return Image.asset('assets/icons/girl.png');
    } else {
      return Image.asset('assets/icons/transgender.png');
    }
  } else if (age >= 13 && age <= 19) {
    if (_selectedGender == 'Male') {
      return Image.asset('assets/icons/teenageboy.png');
    } else if (_selectedGender == 'Female') {
      return Image.asset('assets/icons/teenagegirl.png');
    } else {
      return Image.asset('assets/icons/transgender.png');
    }
  } else if (age >= 20 && age <= 35) {
    if (_selectedGender == 'Male') {
      return Image.asset('assets/icons/man.png');
    } else if (_selectedGender == 'Female') {
      return Image.asset('assets/icons/woman.png');
    } else {
      return Image.asset('assets/icons/transgender.png');
    }
  } else if (age >= 36 && age <= 55) {
    if (_selectedGender == 'Male') {
      return Image.asset('assets/icons/middleageman.png');
    } else if (_selectedGender == 'Female') {
      return Image.asset('assets/icons/middleagewoman.png');
    } else {
      return Image.asset('assets/icons/transgender.png');
    }
  } else {
    if (_selectedGender == 'Male') {
      return Image.asset('assets/icons/grandfather.png');
    } else if (_selectedGender == 'Female') {
      return Image.asset('assets/icons/grandmother.png');
    } else {
      return Image.asset('assets/icons/transgender.png');
    }
  }
}
