  
class SpawnerAlien {
Alien[][] aliens;
private int filas;
private int columnas;
private float anchoAlien;
private float altoAlien;
private float espacioX;  // Espacio horizontal entre enemigos
private float espacioY;  // Espacio vertical entre enemigos
  
 public SpawnerAlien(){
this.filas = 5;
this.columnas = 11;
this.anchoAlien = 60;
this.altoAlien = 30;
this.espacioX = 10;  // Espacio horizontal entre enemigos
this.espacioY = 10;  // Espacio vertical entre enemigos
 

  
  }

  public void spawnAliens() {
     aliens = new Alien[filas][columnas];
    for (int i = 0; i < filas; i++) {
        for (int j = 0; j < columnas; j++) {
            float posX = j * (anchoAlien + espacioX) + anchoAlien / 2+20;
            float posY = i * (altoAlien + espacioY) + altoAlien / 2;
            aliens[i][j] = new Alien(new PVector(posX, posY));
        }
    }
}
    
  

  public void actualizarAliens() {    
  for (int i = 0; i < filas; i++) {
        for (int j = 0; j < columnas; j++) {
            aliens[i][j].move();
            aliens[i][j].display();
        }
}

}
}
