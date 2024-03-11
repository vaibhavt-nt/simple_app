import 'package:flutter/cupertino.dart';

class ContainerProvider extends ChangeNotifier{
  final int containerHeight;
  final int containerWidth;

  ContainerProvider(this.containerHeight, this.containerWidth);

}