import 'package:flutter/foundation.dart';

class Tab{
  final int index;
  final String title;

 const Tab({
  @required  this.index,
  @required  this.title
  }):assert(index >=0,'index can not be negative'),
  assert(title !=null ,'title shouldnt be null');



}