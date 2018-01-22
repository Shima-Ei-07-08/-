

// キー入力メソッド ボール落とす用とオチ用
void mousePressed() {
  oval[mousei] = 15;
  sendServo(mousei + 1, oval[mousei]);
  mousei++;
}
  
  /*
  switch(key){
   
    
  case 'z':
    oval[i] += 1; // zキーがおされたら値を1増やす。
    sendServo(2, oval1);
    break;
  case 'x':
    oval[i] -= 1; // xキーがおされたら値を1減らす。
    sendServo(2, oval1);
    break;
  case 'v':
    oval[i] = 15;
    sendServo(2, oval1);
    break;
  case 'c':
    oval[i] = 125;
    sendServo(2, oval1);
    break;
  default:
    break;
  }
*/