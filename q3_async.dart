Stream<String> trackOrder() async* {
  await Future.delayed(Duration(seconds: 1));
  yield 'รับออร์เดอร์เเล้ว';
  await Future.delayed(Duration(seconds: 1));
  yield 'กำลังจัดทำ';
  await Future.delayed(Duration(seconds: 1));
  yield 'จัดส่งเรียบร้อบ';
}

Future<Map<String, dynamic>> ferchOrder(int order) async {
  await Future.delayed(Duration(seconds: 2));

  if (order <= 0) {
    throw Exception("รหัสคำสั่งไม่ถูกต้อง");
  }

  return {"id": order, "menu": "ลาเต้", "total": 20};
}

Future<void> main() async {
  try {
    print("เริ่มโหลดข้อมูล...");
    Map<String, dynamic> profile = await ferchOrder(7);
    print(profile);
  } catch (e) {
    print("เกิดข้อผิดพลาด: $e");
  } finally {
    print("จบรายการ");
    print("---");
  }
  try {
    Map<String, dynamic> profile_ = await ferchOrder(0);
    print(profile_);
  } catch (e) {
    print("เกิดข้อผิดพลาด: $e");
  } finally {
    print("จบรายการเเล้ว");
  }

  await for (String order in trackOrder()) {
    print("สถานะ: $order");
  }
  print("ติดตามสถานะเสร็จสิ้น");
}
