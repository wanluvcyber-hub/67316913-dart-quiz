const vatRate = 0.07;

double calcTotal({required  price,required qty,double? discount}){
  if (discount == null){
    return (price * qty) * (1 + vatRate);
  }else{
    return (price * qty - discount) * (1 + vatRate);
  }
  
}

void main(){
  
  final String shopname = "Dart Cafe"; 
  List<String> categories  = ["เครื่องดืม","ของคาว","ของหวาน"];
  Map<String,int> menu = {
    "ลาเต้": 55,
    "ข้าวผัด":60,
    "กาเเฟ":45,
    "ข้าวผัดกระเพราะ":35
  };
  var menu_len = menu.length;
  var price_menu = menu["ลาเต้"];

  // ราคา
  double dis_price = calcTotal(price: 55,qty: 2,discount: 10);
  double normal_price = calcTotal(price: 55,qty: 2);


  // null
  String? coupon;
  int middle_l = coupon?.length ?? 0;
  coupon ??= "NO-COUPON";

  // output
  // แปลงให้เหลือทศนิยม 1 ตำแหน่ง 
  print("ร้านค้า: $shopname");
  print("อัตราภาษี (vatRate): $vatRate");
  print("---");
  print("หมวดหมู่ : $categories");
  print("จำนวนเมนูทั้งหมด: $menu_len รายการ");
  print("ราคาลาเต้: $price_menu");
  print("---");
  print("ราคาเมนูตั้งเเต่ 50 บาทขึ้นไป");
  for (var i in menu.entries){
    if(i.value > 50){
      print("ชื่อเมนู ${i.key} ราคา ${i.value} บาท");
    }
  }
  print("---");
  print("ยอดสุทธิ (ไม่มีส่วนลด): ${normal_price.toStringAsFixed(1)} บาท");
   print("ยอดสุทธิ (มีส่วนลด 10 บาท): ${dis_price.toStringAsFixed(1)} บาท");
   print("---");
   print("ความยาวคูปอง: $middle_l");
   print("คูปองหลังกำหนดค่า: $coupon");
}