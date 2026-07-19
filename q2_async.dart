import 'dart:html_common';

// 2.1
abstract class MenuItem{
  String name;
  double basePrice;

  MenuItem(this.name,this.basePrice);
  double price();
  void show(){
    print("ชื่อ ${name} - ราคา ${basePrice} บาท");
  }
}

// 2.2 and 2.3
class Drink extends MenuItem{
  int toppings;
  Drink(String name,DocsEditable basePrice,this.toppings):super(name,basePrice);
  @override
  // เขียนทับ price ให้มาเป็นของตัวเอง
  double price(){
    return basePrice + (10*toppings);
  }
}

// class Food extends MenuItem{
//   double size;
//   Food()
// }

void main(){
  
}
