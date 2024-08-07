/**Importa archivos de la biblioteca minim*/
import ddf.minim.*;
/**Atributo Minim de la importacion del archivo minim*/
private Minim minim;
/**Reproductor del audio para el inicio del juego*/
private AudioPlayer inicioAudio;
/**Reproductor del audio durante la jugabilidad*/
private AudioPlayer jugandoAudio;
/**Reproductor del audio durante la fase del Jefe*/
private AudioPlayer bossAudio;
/**Reproductor del audio al ganar el juego*/
private AudioPlayer ganandoAudio;
/**Reproductor del audio al perder el juego*/
private AudioPlayer perdiendoAudio;
/**Variable para el temporizador que se ejecutara en el juego*/
/**Reproductor del audio del laser*/
private AudioPlayer laserAudio;
/**Reproductor del audio de la bomba*/
private AudioPlayer bombaAudio;
private Tanque miTanque;
/** Administra los diferentes escenarios */
private GestorJuego gestorJuego; 
private SpawnerBalas spawner;
private SpawnerBalasEnemigo spawnerBalaEnemigo;
private SpawnerAlien spawnerAlien;
/** Variable que representa el DeltaTime */
private float timer;
private Boss boss;
/** Variable que representa la distancia entre el tanque y el boss */
private float distancia = 800;
private ArrayList<Bomba> bombas;
/** Variable para controlar el tiempo transcurrido desde el último disparo*/
private float lastShootTimeBala = 0;
/** Variable para controlar el tiempo transcurrido desde la última bomba*/
private float lastShootTimeBomba = 0;
/** Variable para controlar el tiempo transcurrido desde el último disparo enemigo*/
private float lastShootTimeBalaEnemigo = 0;

/** Tiempo que tarda en habilitarse un nuevo disparo de la bomba */
private int cooldownTimeBomba = 3000; //  3 segundo de cooldown
/** Tiempo que tarda en habilitarse un nuevo disparo de la bala */
private int cooldownTimeBala = 400; // 1 segundo de cooldown
/** Tiempo que tarda en habilitarse un nuevo disparo de la bala enemiga  */
private int cooldownTimeBalaEnemigo = 260; // 1 segundo de cooldown
private SpawnerBossAttack spawnerBossAttack;
/** Variable que representa la colision entre las balas y los aliens usando el sweep and prune*/
private CollisionDetector collision;
/*-------*/
private Escudo escudo1; 
private Escudo escudo2; 
private Escudo escudo3; 
PFont font;

/** Método que inicializa el sketch y sus elementos */
public void setup() {
//fullScreen ();
size(1200,800);
font = loadFont("DePixel-Bold-20.vlw");
textFont(font);
boss = new Boss (new PVector (width/2,-160));
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
collision = new CollisionDetector(spawner, spawnerAlien);
frameRate (60);
escudo1 = new Escudo(new PVector(width / 4, height - 250));
escudo2 = new Escudo(new PVector(width / 2 -50 , height - 250));
escudo3 = new Escudo(new PVector(3*width/4-100 , height - 250));
minim = new Minim(this);//Inicializacion de la biblioteca Minim
inicioAudio = minim.loadFile("Inicio.mp3");//Cargamos la musica para IniocioAudio
jugandoAudio = minim.loadFile("Jugando.mp3");//Cargamos la musica de jugandoAdudio
bossAudio = minim.loadFile("Boss.mp3");//Cargamos la musica de bossAudio
ganandoAudio = minim.loadFile("Ganando.mp3");//Cargamos la musica de ganandoAdudio
perdiendoAudio = minim.loadFile("Perdiendo.mp3");//Cargamos la musica de perdiendoAudio
laserAudio = minim.loadFile("Laser.mp3");//Cargamos el sonido laser
bombaAudio = minim.loadFile("Bomb.mp3");//Cargamos el sonido bomba
inicioAudio.loop();//Reproducimos la muxica de InicioAudio

}

/** Método que se ejcuta continuamente*/
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
            jugandoAudio.pause();//Pausamos la musica jugandoAudio
            bossAudio.play(); //Reproducimos la musica de bossAudio
            bossAudio.setGain(-10.0); //cambia el volumen de la cancion
            
        } else {
            spawnerAlien.actualizarAliens();
             spawnerBossAttack.actualizarBalasEnemigo(miTanque);
        }

        spawnerAlien.actualizarAliens();
        spawner.actualizarBalas();
        float currentTimeBoss = millis();       
        if (currentTimeBoss - lastShootTimeBalaEnemigo > cooldownTimeBalaEnemigo) {
            // Disparar utilizando la tecla "ESPACIO"
            boss.disparar(spawnerBalaEnemigo);
          
            // Actualizar el tiempo del último disparo con "ESPACIO"
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
          bossAudio.pause();//Pausamos la musica bossAudio
          ganandoAudio.play(); //Reproducimos la musica de jugandoAudio
        }
        
      
        
         // Verificar si la posición en Y del Boss es >= 600
        if (boss.getPosicion().y >= 600 || miTanque.getCantVida()== 0) {
            gestorJuego.setNivelJuego(MaquinaEstados.PANTALLA_PERDIENDO);
            bossAudio.pause();//Pausamos la musica bossAudio
            perdiendoAudio.play(); //Reproducimos la musica de perdiendoAudio
            perdiendoAudio.setGain(-10.0); //cambia el volumen de la cancion
        }

        // Verificar si la posición en Y de cualquier Alien es >= 800
        for (Alien alien : spawnerAlien.getAliens()) {
            if (alien.getPosicion().y >= 640) {
                 gestorJuego.setNivelJuego(MaquinaEstados.PANTALLA_PERDIENDO);
                 jugandoAudio.pause();//Pausamos la musica jugandoAudio
                 perdiendoAudio.play(); //Reproducimos la musica de perdiendoAudio
                 perdiendoAudio.setGain(-10.0); //cambia el volumen de la cancion
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
      inicioAudio.pause();//Pausamos la musica inicoAudio
      jugandoAudio.play(); //Reproducimos la musica de jugandoAudio en un bucle
      
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
            laserAudio.rewind(); //reinicia el sonido si ya fue reproducido
            laserAudio.play(); //reproduce el sonido
          

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
            bombaAudio.rewind();
            bombaAudio.play();

            // Actualizar el tiempo del último disparo al tiempo actual
            lastShootTimeBomba = currentTime;
        }
    }
    
  }
}
}
