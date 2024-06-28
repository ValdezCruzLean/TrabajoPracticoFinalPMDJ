/*Clase Tanque extiende de GameObject e implementa todos los metodos de IVisualizable.*/
class Tanque extends GameObject implements IVisualizable{
  /*Booleano que indica si el tanque ha sido detectado.*/
  private boolean isDetected;
  /*Vector que representa la direccion del tanque.*/
  private Vector vectorTanque;
  /*Vector que apunta hacia el jefe (boss).*/
  private Vector vectorTanqueBoss;
  /*Variable Pimage que representa magen del tanque.*/
 private PImage imagen; 
 /*Variable entera que representa la cantidad de vida del tanque.*/
   private int cantVida; 
    /*Variable entera que representa el tamaño del tanque.*/
   private int size;
  
  // -----------Zona de Constructores----------------
/*Constructor por defecto*/
  public Tanque() { 
    this.vectorTanque = new Vector(this.posicion, new PVector(0,-1,0));
    this.vectorTanqueBoss = new Vector();
    this.posicion = new PVector(width/2,height-160);
    this.imagen = loadImage("Player.png");
    this.velocidad = new PVector(300,0);
    this.cantVida = 100; // Vida inicial del tanque
    this.size = 40;


  }
  /*Metodos get y set permiten establecer (set) y obtener (get) .*/
  
  /*Establece el valor del atributo isDetected*/
  public void setDetected(boolean isDetected){
    this.isDetected = isDetected;
  }
  /*Establece el valor del atributo cantVida*/
     public void setCantVida(int cantVida) {
        this.cantVida = cantVida;
    }
  /*Establece el valor del atributo size*/
  public void setSize(int size) {
    this.size = size;
  }
  /*Establece el valor del atributo vectorTanque*/
  public void setVectorTanque(Vector vectorTanque){
    this.vectorTanque = vectorTanque;
  }
  /*Establece el valor del atributo vectorTanqueBoss*/
  public void setVectorTanqueBoss(Vector vectorTanqueBoss){
    this.vectorTanqueBoss = vectorTanqueBoss;
  }
  /*Establece el valor del atributo cantVida*/  
  public void setVida(int cantVida) {
        this.cantVida=cantVida;
    } 
  /*Devuelve el valor del atributo isDetected*/  
   public boolean getDetected(){
    return this.isDetected;
  }
  /*Devuelve el valor del atributo cantVida*/
   public int getCantVida(){
      return this.cantVida;
    }
  /*Devuelve el valor del atributo size*/
     public int getSize() {
    return this.size;
  }
  /*Devuelve el valor del atributo vectorTanque*/
  public Vector getVectorTanque(){
    return this.vectorTanque;
  }
  /*Devuelve el valor del atributo vectorTanqueBoss*/  
  public Vector getVectorTanqueBoss(){
    return this.vectorTanqueBoss;
  } 
  /*Devuelve el valor del atributo cantVida*/  
public int getVida() {
        return cantVida;
    }  
  

  
  
/*Metodo disparar se encarga de crear una nueva bala en la posición del tanque y añadirla al arreglo de balas manejado por el SpawnerBalas.*/  
  public void disparar(SpawnerBalas spawner) {
/*Se crea un nuevo vector posicionJugador con la posicion actual del tanque (this.posicion), lo que establece quela posicion inicial de la bala en la misma que el tanque.*/    
   PVector posicionJugador = new PVector(this.posicion.x, this.posicion.y);
 /*Se crea el objeto Bala llamado unaBala recibiendo por parametro la posicionJugador y la direccion que debe moverse,apuntando hacia el Boss*/  
    Bala unaBala = new Bala(posicionJugador, this.getVectorTanqueBoss().getDestino());
 /*Se obtiene el arreglo de balas del SpawnerBalas utilizando el metodo getBalas(). Este arreglo contiene todas las balas del tanque en el juego.*/   
    Bala[] balas = spawner.getBalas();
/*Se itera sobre el arreglo de balas para encontrar una posicion vacia luego se asigna la nueva bala unaBala a esa posicion y se rompe el bucle.
Esto asegura que la bala se añade al primer espacio disponible en el arreglo.*/    
    for (int i = 0; i < balas.length; i++) {
      if (balas[i] == null) {
        balas[i] = unaBala;
        break;
      }
    }
/*Se actualiza el arreglo de balas en el SpawnerBalas utilizando el método setBalas(), asegurando que el SpawnerBalas tenga la referencia actualizada del arreglo con la nueva bala añadida.*/    
    spawner.setBalas(balas);
  }

/*Este metodo se encarga de mostrar la imagen del tanque en la pantalla.*/  
  public void display() {
   /*Dibuja la imagen del tanque en la posicion actual del tanque.*/ 
    image(imagen, this.posicion.x, this.posicion.y);
 /*Redimensiona la imagen del tanque .*/   
    imagen.resize(100, 60);
   //ellipse(this.posicion.x,this.posicion.y,size,size);

  }
/*Este metodo muestra la cantidad de vida del jugador en la pantalla.*/  
   public void displayLife() {
      /*Color del texto*/   
       fill(255); 
      /*Tamaño del texto*/ 
        textSize(20); 
     /*Texto que aparecerá en pantalla y su ubicacion*/   
        text("Player Life: " + this.cantVida, 600, 200); 
  }
  
   public void displayCenter(){
    imageMode(CENTER);
    image(this.imagen, 0, 0, 100, 60);
  }
   /*Metodo para obtener el vector entre el enemigo y el jugador*/
  public void calcularVectorJugadorEnemigo(GameObject Boss){
    /* Se establece el origen del vector tanqueBoss en la posicion actual del tanque.*/
    this.getVectorTanqueBoss().setOrigen(this.getPosicion());
    /* Se establece el destino del vector tanqueBoss como la posicion del jefe menos la posicion del tanque.*/
    this.getVectorTanqueBoss().setDestino(PVector.sub(Boss.getPosicion(), this.posicion));
  }
  
  /*Metodo para girar al jugador, alineandose en la direccion del Boss*/
  public void spin(){
    /*Calcula el angulo entre el vector del tanque y el vector hacia el jefe.*/
    float angle = PVector.angleBetween(this.getVectorTanque().getDestino(), this.getVectorTanqueBoss().getDestino());
    /*Calcula el vector de rotacion cruzando los dos vectores.*/
    PVector rotacion = this.getVectorTanque().cruz(this.getVectorTanqueBoss());
    int direccion = 1;
    /*Determina la direccion de la rotacion segun la componente z del vector de rotacion.*/
    if(rotacion.z < 0){
      direccion = -1;
    }
    /*Aplica las transformaciones de matriz para rotar el tanque y dibujarlo centrado.*/
    pushMatrix();
    translate(this.posicion.x, this.posicion.y);
    rotate(angle*direccion);
    this.displayCenter();
    popMatrix();    
  }
  /*Metodo que crea una nueva bomba en la posición del tanque y la dirige hacia el enemigo.*/
  public Bomba disparar(){
    /*Se crea un nuevo vector posicionJugador con la posicion actual del tanque.*/
    PVector posicionJugador = new PVector(this.posicion.x, this.posicion.y);
   /*Se crea y devuelve una nueva Bomba con la posicion del tanque y la direccion hacia el Boss.*/
    return new Bomba(posicionJugador, this.getVectorTanqueBoss().getDestino());
}

/*Metodo que reduce la cantidad de vida del tanque.*/
    public void reducirVida(int cantidad) {
        this.cantVida -= cantidad;
 /*Si la vida del tanque es menor a 0, se establece a 0 para evitar valores negativos.*/
        if (this.cantVida < 0) {
            this.cantVida = 0;
        }
    }
  /*Metodo que lee los comandos del teclado para mover el tanque.*/
  public void readCommand() {
    if (keyPressed) {
      if (keyCode == LEFT) {
        this.posicion.x-=this.velocidad.x*Time.getDeltaTime (frameRate);
      }
      if (keyCode == RIGHT) {
        this.posicion.x+=this.velocidad.x*Time.getDeltaTime (frameRate);
      }
      if (posicion.x > 800) {
        this.posicion.x = 800;
      }
      if (posicion.x < 150) {
        this.posicion.x = 150;
      }
    }
  }
}
