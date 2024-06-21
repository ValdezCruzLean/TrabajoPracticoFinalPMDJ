
private SpawnerAlien spawnerAlien;
private float timer;


public void setup() {
  fullScreen ();

spawnerAlien = new SpawnerAlien();//Inicializacion del generador de lapices
spawnerAlien.spawnAliens();
timer = 0;
frameRate (60);
}

public void draw(){

background(0);

 spawnerAlien.actualizarAliens();// Actualiza la creacion de los lapices y sus metodos
timer+=Time.getDeltaTime(frameRate);
fill(255);
textSize(20);
text("Segundos: "+round (timer),20,100);
} 
