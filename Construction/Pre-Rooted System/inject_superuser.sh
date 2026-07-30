#!/sbin/sh
# กระบวนการ: ข้ามการคัดกรองความปลอดภัยและติดตั้งสิทธิ Root ถาวร

# 1. ปลดล็อกและเชื่อมต่อแกนระบบ (Mount System) ให้สามารถเขียนข้อมูลได้
mount -o rw,remount /system

# 2. ถ่ายโอนแฟ้มข้อมูลสั่งการลงในตำแหน่งที่ระบบตรวจสอบ
# (อ้างอิงตำแหน่ง /system/xbin/su ตามเอกสาร SanityCheckRootTools.html[span_2](start_span)[span_2](end_span))
cp /tmp/su /system/xbin/su
cp /tmp/RootTools.apk /system/app/RootTools.apk 

# 3. กำหนดค่าตัวแปรสิทธิ์ระดับสูง (SetUID Protocol) เพื่อมอบอำนาจ 100%
chown 0:0 /system/xbin/su
chmod 6755 /system/xbin/su

# 4. ปรับโครงสร้างสิทธิ์ของแอปพลิเคชันจัดการให้อ่านได้อย่างเดียว (ป้องกันการดัดแปลง)[span_3](start_span)[span_3](end_span)[span_4](start_span)[span_4](end_span)
chown 0:0 /system/app/RootTools.apk
chmod 644 /system/app/RootTools.apk

# 5. ล็อกแฟ้มข้อมูลระบบกลับสู่สถานะอ่านอย่างเดียวเพื่อความเสถียร
mount -o ro,remount /system

echo "RESULT: SYSTEM INJECTION COMPLETE. ROOT GRANTED."

