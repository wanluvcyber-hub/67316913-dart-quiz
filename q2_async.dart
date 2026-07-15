import 'dart:html_common';

abstract class MenuItem{
  String name;
  double basePrice;

  MenuItem(this.name,this.basePrice);
  double price();
  void show(){
    print("ชื่อ ${name} - ราคา ${basePrice} บาท");
  }
}

class Drink extends MenuItem{
  int toppings;
  Drink(String name,DocsEditable basePrice,this.toppings):super(name,basePrice);
  @override
  double price(){
    return basePrice + (10*toppings);
  }
}

class Food extends MenuItem{
  double size;
  Food()
}