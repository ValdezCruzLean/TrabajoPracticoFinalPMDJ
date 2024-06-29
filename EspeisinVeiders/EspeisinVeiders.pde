private Tanque miTanque;
private GestorJuego gestorJuego; 
private SpawnerBalas spawner;
private SpawnerBalasEnemigo spawnerBalaEnemigo;
private SpawnerAlien spawnerAlien;
private float timer;
private Boss boss;
private float distancia = 800;
private ArrayList<Bomba> bombas;
// Variable para controlar el tiempo transcurrido desde el último disparo
float lastShootTimeBala = 0;
float lastShootTimeBomba = 0;
float lastShootTimeBalaEnemigo = 0;
/**Variable para el temporizador que se ejecutara en el juego*/
public Timmer tiempo;
// Tiempo de cooldown entre disparos 
private int cooldownTimeBomba = 2000; //  3 segundo de cooldown
private int cooldownTimeBala = 100; // 1 segundo de cooldown
private int cooldownTimeBalaEnemigo = 500; // 1 segundo de cooldown
private SpawnerBossAttack spawnerBossAttack;
CollisionDetector collision;
private Escudo escudo1; 
Escudo escudo2; 
Escudo escudo3; 


public void setup() {
//fullScreen ();
size(1000,900);
boss = new Boss (new PVector (width/2,-150));
spawnerBossAttack= new SpawnerBossAttack(13);
spawnerBossAttack.spawnAttacks();
 spawnerBalaEnemigo = new SpawnerBalasEnemigo(1000);
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
escudo1 = new Escudo(new PVector(width / 4, height - 250));
escudo2 = new Escudo(new PVector(width / 2 -50 , height - 250));
escudo3 = new Escudo(new PVector(3*width/4-100 , height - 250));


}

public void draw() {
    background(0);
    gestorJuego.generarEscenario();

    if (gestorJuego.getNivelJuego() == MaquinaEstados.PANTALLA_INICIANDO) {
        gestorJuego.setNivelJuego(MaquinaEstados.PANTALLA_INICIANDO);
    }

    if (gestorJuego.getNivelJuego() == MaquinaEstados.PANTALLA_JUGANDOLEVELONE) {
        boolean bossDetected = spawnerAlien.areAllAliensDead();
        miTanque.displayLife();
 escudo1.display();
  escudo2.display();
 escudo3.display();
 
 if(escudo1.getDurabilidad() == 0){
   escudo1.sacarEscudo();
 }
  if(escudo2.getDurabilidad() == 0){
   escudo2.sacarEscudo();
 }
  if(escudo3.getDurabilidad() == 0){
   escudo3.sacarEscudo();
 }

        if (bossDetected) {
            boss.display();
            boss.move();
            spawnerBalaEnemigo.actualizarBalasEnemigo(miTanque);
        } else {
            spawnerAlien.actualizarAliens();
        }
        if(tiempo.getTime()>90){
                  spawnerBossAttack.actualizarBalasEnemigo(miTanque);

        }
        spawnerAlien.actualizarAliens();
        spawner.actualizarBalas();
        float currentTimeBoss = millis();       
        if (currentTimeBoss - lastShootTimeBalaEnemigo > cooldownTimeBalaEnemigo) {
            // Disparar utilizando la tecla "ENTER"
            boss.disparar(spawnerBalaEnemigo);
          

            // Actualizar el tiempo del último disparo con "ENTER"
            lastShootTimeBalaEnemigo = currentTimeBoss;
        }

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
             for (Bomba bomba : bombas) {
            bomba.display();
            bomba.move();
        }
        } else {
            miTanque.display();
        }

       
     

        collision.sweepAndPrune();
     //   bala.danarEscudo();
    }
        if (gestorJuego.getNivelJuego() == MaquinaEstados.PANTALLA_JUGANDOLEVELONE && boss.getCantVida()== 0) {
          gestorJuego.setNivelJuego(MaquinaEstados.PANTALLA_GANANDO);
        }
        
        if ( boss.getPosicion().x >= height) {
          gestorJuego.setNivelJuego(MaquinaEstados.PANTALLA_GANANDO);
        }
        
         // Verificar si la posición en Y del Boss es >= 800
        if (boss.getPosicion().y >= 800 || miTanque.getCantVida()== 0) {
            gestorJuego.setNivelJuego(MaquinaEstados.PANTALLA_PERDIENDO);
        }

        // Verificar si la posición en Y de cualquier Alien es >= 800
        for (Alien alien : spawnerAlien.getAliens()) {
            if (alien.getPosicion().y >= 800) {
                gestorJuego.setNivelJuego(MaquinaEstados.PANTALLA_PERDIENDO);
                break; // No es necesario seguir verificando si uno ya cumple la condición
            }
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
    if (keyCode == ' ') {
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
    
    if (keyCode == CONTROL ){
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
