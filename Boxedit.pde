void Boxedit(int x, int y, int z,int boxsize, int boxwidth, int boxheight, int boxZ){
  pushMatrix();
  translate(x, y, z);
  box(boxsize - boxwidth, boxsize - boxheight, boxsize - boxZ);
  popMatrix();
}