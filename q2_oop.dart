// q2_oop.dart
// ข้อ 2 — OOP: ระบบเมนูและกระเป๋าเงินของลูกค้า (50 คะแนน)

// 2.1 คลาสนามธรรม: ใช้เป็นแม่แบบเท่านั้น สร้างอ็อบเจกต์ตรง ๆ ไม่ได้ -> abstract
abstract class MenuItem {
  // ฟิลด์กำหนดค่าครั้งเดียวตอนสร้างอ็อบเจกต์ แก้ไขไม่ได้ -> final
  final String name;
  final double basePrice;

  // 2.5 สมาชิกแบบสถิต (static) นับจำนวนอ็อบเจกต์ทั้งหมด เข้าถึงได้โดยไม่ต้องสร้างอ็อบเจกต์
  static int itemCount = 0;

  // คอนสตรัคเตอร์แบบย่อ this.x + เพิ่มตัวนับทุกครั้งที่สร้างอ็อบเจกต์
  MenuItem(this.name, this.basePrice) {
    itemCount++;
  }

  // เมธอดนามธรรม (ไม่มีเนื้อหา) เป็นข้อบังคับให้คลาสลูกไปเขียนเอง
  double price();

  // เมธอดปกติ (มีเนื้อหาสมบูรณ์) คลาสลูกใช้ได้เลย เรียก price() ภายใน ไม่คำนวณซ้ำ
  void show() {
    print('$name - ${price()} บาท');
  }
}

// 2.2 การสืบทอด: Drink extends MenuItem
class Drink extends MenuItem {
  final int toppings;

  // ส่งค่า name, basePrice ต่อให้คอนสตรัคเตอร์คลาสแม่ด้วย super
  Drink(String name, double basePrice, this.toppings) : super(name, basePrice);

  // 2.3 พหุสัณฐาน: เขียนทับเมธอด price ของคลาสแม่
  @override
  double price() => basePrice + (10 * toppings);
}

// 2.2 การสืบทอด: Food extends MenuItem
class Food extends MenuItem {
  final String size; // S, M, L

  Food(String name, double basePrice, this.size) : super(name, basePrice);

  @override
  double price() {
    // เลือกตัวคูณด้วย switch (เทียบค่ากับค่าคงที่หลายค่า) ไม่ใช่ if-else ต่อกัน
    double multiplier;
    switch (size) {
      case 'S':
        multiplier = 1.0;
        break;
      case 'M':
        multiplier = 1.2;
        break;
      case 'L':
        multiplier = 1.5;
        break;
      default:
        multiplier = 1.0;
    }
    return basePrice * multiplier;
  }
}

// 2.4 การห่อหุ้ม: ฟิลด์ยอดเงินซ่อนไว้ด้วย _ เข้าถึงจากภายนอกไฟล์ไม่ได้โดยตรง
class Wallet {
  double _balance;

  Wallet(this._balance);

  // เปิดให้อ่านยอดเงินเหมือนเป็นคุณสมบัติ -> getter
  double get balance => _balance;

  // เปิดให้เขียนยอดเงินเหมือนเป็นคุณสมบัติ แต่ตรวจสอบความถูกต้องก่อน -> setter
  set balance(double value) {
    if (value < 0) {
      print('ผิดพลาด: ยอดเงินติดลบไม่ได้');
      return;
    }
    _balance = value;
  }

  // จ่ายเงิน: พอจ่ายให้หักและคืน true, ไม่พอให้แจ้งเตือนและคืน false โดยไม่หักเงิน
  bool pay(double amount) {
    if (_balance >= amount) {
      _balance -= amount;
      return true;
    } else {
      print('ยอดเงินไม่พอ');
      return false;
    }
  }
}

// 2.5 การแจงนับ: ค่าที่เป็นไปได้เพียง 3 ค่า
enum OrderStatus { pending, paid, cancelled }

// ฟังก์ชันรับค่า enum แล้วใช้ switch แสดงข้อความภาษาไทย
void showStatus(OrderStatus status) {
  switch (status) {
    case OrderStatus.pending:
      print('สถานะ: รอชำระเงิน');
      break;
    case OrderStatus.paid:
      print('สถานะ: ชำระเงินแล้ว');
      break;
    case OrderStatus.cancelled:
      print('สถานะ: ยกเลิกคำสั่งซื้อ');
      break;
  }
}

void main() {
  // 2.3 คอลเลกชันประกาศชนิดสมาชิกเป็นคลาสแม่ (MenuItem) แต่บรรจุอ็อบเจกต์คละชนิด
  final List<MenuItem> order = [
    Drink('ลาเต้', 55, 1),
    Food('ข้าวผัด', 60, 'L'),
    Drink('อเมริกาโน่', 45, 0),
  ];

  double sum = 0;
  // เรียกด้วยคำสั่งเดียวกันทั้งลูป ไม่มีการเช็คชนิดอ็อบเจกต์ -> Dynamic Dispatch
  for (final item in order) {
    item.show();
    sum += item.price();
  }
  print('ยอดรวมทั้งสิ้น: $sum บาท');
  print('---');

  // 2.4 ทดสอบ Wallet ครบทั้ง 3 กรณี
  final wallet = Wallet(300);

  wallet.balance = -50; // กรณีที่ 1: ค่าติดลบ ถูกปฏิเสธ

  if (wallet.pay(200)) {
    // กรณีที่ 2: จ่ายสำเร็จ
    print('ชำระเงินสำเร็จ');
    showStatus(OrderStatus.paid);
  }
  print('ยอดคงเหลือ: ${wallet.balance} บาท');

  wallet.pay(500); // กรณีที่ 3: ยอดไม่พอ
  showStatus(OrderStatus.pending);
  print('ยอดคงเหลือ: ${wallet.balance} บาท');
  print('---');

  // 2.5 เข้าถึงตัวนับผ่านชื่อคลาส ไม่ใช่ผ่านตัวแปรอ็อบเจกต์
  print('จำนวนรายการเมนูที่ถูกสร้าง: ${MenuItem.itemCount}');
}
