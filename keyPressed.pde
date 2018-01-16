/*

// キー入力メソッド ボール落とす用とオチ用
void keyPressed() {
  switch(key){
  case 'z':
    oval1 += 1; // zキーがおされたら値を1増やす。
    sendServo(1, oval1);
    break;
  case 'x':
    oval1 -= 1; // xキーがおされたら値を1減らす。
    sendServo(1, oval1);
    break;
  case 'c':
    oval1 = 15;
    sendServo(1, oval1);
    break;
  case 'v':
    oval1 = 125;
    sendServo(1, oval1);
    break;
  default:
    break;
  }
}
*/