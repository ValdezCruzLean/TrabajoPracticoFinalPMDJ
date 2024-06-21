private Tanque miTanque;
private SpawnerBalas spawner;
private SpawnerAlien spawnerAlien;
private float timer;
private Boss boss;



public void setup() {
fullScreen ();
boss = new Boss (new PVector (width/2,-100));
spawnerAlien = new SpawnerAlien();//Inicializacion del generador de lapices
spawnerAlien.spawnAliens();
timer = 0;
miTanque = new Tanque();
 spawner = new SpawnerBalas(1000);
frameRate (60);
}

public void draw(){

background(0);
 boss.display();
 boss.move();
 spawnerAlien.actualizarAliens();// Actualiza la creacion de los lapices y sus metodos
 spawner.actualizarBalas();
 miTanque.display();
 miTanque.readCommand();
timer+=Time.getDeltaTime(frameRate);
fill(255);
textSize(20);
text("Segundos: "+round (timer),20,100);
} 
public void keyPressed(){
  
 // println("Entro en el método");
  if(keyCode== ENTER ){
    println("Se presionó la tecla");
    miTanque.disparar(spawner);
  }
}
