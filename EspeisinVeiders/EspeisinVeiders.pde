private Tanque miTanque;
private GestorJuego gestorJuego; 
private SpawnerBalas spawner;
private SpawnerAlien spawnerAlien;
private float timer;
private Boss boss;
private float distancia = 800;
private ArrayList<Bomba> bombas;
// Variable para controlar el tiempo transcurrido desde el último disparo
float lastShootTimeBala = 0;
float lastShootTimeBomba = 0;

/**Variable para el temporizador que se ejecutara en el juego*/
public Timmer tiempo;
// Tiempo de cooldown entre disparos 
private int cooldownTimeBomba = 2000; //  3 segundo de cooldown
private int cooldownTimeBala = 500; // 1 segundo de cooldown

CollisionDetector collision;

public void setup() {
//fullScreen ();
size(800,700);
boss = new Boss (new PVector (width/2,-100));
spawnerAlien = new SpawnerAlien();//Inicializacion del generador de lapices
spawnerAlien.spawnAliens();
timer = 0;
miTanque = new Tanque();
 spawner = new SpawnerBalas(1000);
 bombas = new ArrayList<Bomba>();
 gestorJuego = new GestorJuego(); // Inicialización del objeto gestor de juego
  tiempo = new Timmer(); // Inicialización del objeto temporizador
collision = new CollisionDetector(spawner, spawnerAlien);
frameRate (60);
}

public void draw() {
    background(0);
    gestorJuego.generarEscenario();

    if (gestorJuego.getNivelJuego() == MaquinaEstados.PANTALLA_INICIANDO) {
        gestorJuego.setNivelJuego(MaquinaEstados.PANTALLA_INICIANDO);
    }

    if (gestorJuego.getNivelJuego() == MaquinaEstados.PANTALLA_JUGANDOLEVELONE) {
        boolean bossDetected = spawnerAlien.areAllAliensDead();

        if (bossDetected) {
            boss.display();
            boss.move();
        } else {
            spawnerAlien.actualizarAliens();
        }

        spawnerAlien.actualizarAliens();
        spawner.actualizarBalas();

        // Actualiza el estado de las balas con respecto a la detección del Boss
        for (Bala bala : spawner.getBalas()) {
            if (bala != null) {
                bala.detectBoss(bossDetected);
            }
        }

        miTanque.readCommand();
        miTanque.calcularVectorJugadorEnemigo(boss);
        tiempo.countDown();

        timer += Time.getDeltaTime(frameRate);

        if (miTanque.getVectorTanqueBoss().getDestino().mag() < distancia) {
            miTanque.spin();
        } else {
            miTanque.display();
        }

        for (Bomba bomba : bombas) {
            bomba.display();
            bomba.move();
        }

        collision.sweepAndPrune();
    }
} 
public void keyPressed() {
    // Verificar si se presionó la tecla "ENTER"
     if (keyCode == ENTER) { // Si se presiona la tecla ENTER se ejecutara la siguiente sentencia
    if (gestorJuego.getNivelJuego() == MaquinaEstados.PANTALLA_INICIANDO) {//Cambia la pantalla de inicio a la de instriccionando
      gestorJuego.setNivelJuego(MaquinaEstados.PANTALLA_INSTRUCCIONANDO);
    }
  }
  
  if (key == 'c' || key == 'C') { // Si se presiona la tecla 'C' o 'c' se ejecutara la siguiente sentencia
    if (gestorJuego.getNivelJuego() == MaquinaEstados.PANTALLA_INSTRUCCIONANDO) {//Cambia la pantalla de intriccionando a la de jugando
      gestorJuego.setNivelJuego(MaquinaEstados.PANTALLA_JUGANDOLEVELONE);
    //  inicioAudio.pause();//Pausamos la musica inicoAudio
   //  jugandoAudio.loop(); //Reproducimos la musica de jugandoAudio en un bucle
    }
  }
  if (gestorJuego.getNivelJuego() == MaquinaEstados.PANTALLA_JUGANDOLEVELONE) {
    if (keyCode == ENTER) {
        // Obtener el tiempo actual en milisegundos
        float currentTime = millis();

        // Verificar si ha pasado el cooldown desde el último disparo con "ENTER"
        if (currentTime - lastShootTimeBala > cooldownTimeBala) {
            // Disparar utilizando la tecla "ENTER"
            miTanque.disparar(spawner);

            // Actualizar el tiempo del último disparo con "ENTER"
            lastShootTimeBala = currentTime;
        }
    }
  }
}
void mousePressed() {
  if (gestorJuego.getNivelJuego() == MaquinaEstados.PANTALLA_JUGANDOLEVELONE) {
     if (tiempo.getTime() < 130) {//Indicamos que si el tiempo es menor a 100 se ejecutaran las siguientes sentencias 
 
   
    // Obtener el tiempo actual en milisegundos
    float currentTime = millis();

    // Verificar si ha pasado el cooldown desde el último disparo
    if (currentTime - lastShootTimeBomba > cooldownTimeBomba) {
        // Verificar distancia y disparar si es válido
        if (miTanque.getVectorTanqueBoss().getDestino().mag() < distancia) {
            // Disparar y agregar la bomba creada por el jugador a la lista de bombas
            bombas.add(miTanque.disparar());

            // Actualizar el tiempo del último disparo al tiempo actual
            lastShootTimeBomba = currentTime;
        }
    }
}
  }
}
