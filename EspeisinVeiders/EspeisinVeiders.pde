private Tanque miTanque;
private SpawnerBalas spawner;
private SpawnerAlien spawnerAlien;
private float timer;
private Boss boss;
private float distancia = 800;
private ArrayList<Bomba> bombas;
// Variable para controlar el tiempo transcurrido desde el último disparo
float lastShootTime = 0;

// Tiempo de cooldown entre disparos 
private int cooldownTimeBomba = 3000; //  3 segundo de cooldown
private int cooldownTimeBala = 1000; // 1 segundo de cooldown


public void setup() {
//fullScreen ();
size(800,800);
boss = new Boss (new PVector (width/2,-100));
spawnerAlien = new SpawnerAlien();//Inicializacion del generador de lapices
spawnerAlien.spawnAliens();
timer = 0;
miTanque = new Tanque();
 spawner = new SpawnerBalas(1000);
 bombas = new ArrayList<Bomba>();
frameRate (60);
}

public void draw(){

background(0);
 boss.display();
 boss.move();
 spawnerAlien.actualizarAliens();// Actualiza la creacion de los lapices y sus metodos
 spawner.actualizarBalas();
 miTanque.readCommand();
 miTanque.calcularVectorJugadorEnemigo(boss);
timer+=Time.getDeltaTime(frameRate);
fill(255);
textSize(20);
text("Segundos: "+round (timer),20,100);

 if (miTanque.getVectorTanqueBoss().getDestino().mag() < distancia){
    miTanque.spin();      
  } else {
    miTanque.display();
  }
   for(Bomba bomba: bombas){
    bomba.display();
    bomba.move();
 
  }
} 
public void keyPressed() {
    // Verificar si se presionó la tecla "ENTER"
    if (keyCode == ENTER) {
        // Obtener el tiempo actual en milisegundos
        float currentTime = millis();

        // Verificar si ha pasado el cooldown desde el último disparo con "ENTER"
        if (currentTime - lastShootTime > cooldownTimeBala) {
            // Disparar utilizando la tecla "ENTER"
            miTanque.disparar(spawner);

            // Actualizar el tiempo del último disparo con "ENTER"
            lastShootTime = currentTime;
        }
    }
}
void mousePressed() {
    // Obtener el tiempo actual en milisegundos
    float currentTime = millis();

    // Verificar si ha pasado el cooldown desde el último disparo
    if (currentTime - lastShootTime > cooldownTimeBomba) {
        // Verificar distancia y disparar si es válido
        if (miTanque.getVectorTanqueBoss().getDestino().mag() < distancia) {
            // Disparar y agregar la bomba creada por el jugador a la lista de bombas
            bombas.add(miTanque.disparar());

            // Actualizar el tiempo del último disparo al tiempo actual
            lastShootTime = currentTime;
        }
    }
}
