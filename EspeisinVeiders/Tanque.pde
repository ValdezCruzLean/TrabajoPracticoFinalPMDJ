class Tanque extends GameObject implements IVisualizable{
  private boolean isDetected;
  private Vector vectorTanque;
  private Vector vectorTanqueBoss;
 private PImage imagen; // DeclaraciÃ³n de la variable imagen
  // private PVector velocidad;
  public Tanque() { 
    this.isDetected = false;
    this.vectorTanque = new Vector(this.posicion, new PVector(0,-1,0));
    this.vectorTanqueBoss = new Vector();
    this.posicion = new PVector(width/2,height-20);
    this.imagen = loadImage("Player.png");
    this.velocidad = new PVector(300,0);
  }
  
   public boolean getDetected(){
    return this.isDetected;
  }
  
  public void setDetected(boolean isDetected){
    this.isDetected = isDetected;
  }
  
  public Vector getVectorTanque(){
    return this.vectorTanque;
  }
  
  public void setVectorTanque(Vector vectorTanque){
    this.vectorTanque = vectorTanque;
  }
  
  public Vector getVectorTanqueBoss(){
    return this.vectorTanqueBoss;
  }  
  
  public void setVectorTanqueBoss(Vector vectorTanqueBoss){
    this.vectorTanqueBoss = vectorTanqueBoss;
  }
  
  
  
  
  public void disparar(SpawnerBalas spawner) {
   PVector posicionJugador = new PVector(this.posicion.x, this.posicion.y);
    Bala unaBala = new Bala(posicionJugador, this.getVectorTanqueBoss().getDestino());
    Bala[] balas = spawner.getBalas();
    for (int i = 0; i < balas.length; i++) {
      if (balas[i] == null) {
        balas[i] = unaBala;
        break;
      }
    }
    spawner.setBalas(balas);
  }
  
  public void display() {
    image(imagen, this.posicion.x, this.posicion.y);
    imagen.resize(100, 60);
  }
   public void displayCenter(){
    imageMode(CENTER);
    image(this.imagen, 0, 0, 100, 60);
  }
   // Método para obtener el vector entre el enemigo y el jugador
  public void calcularVectorJugadorEnemigo(GameObject Boss){
    this.getVectorTanqueBoss().setOrigen(this.getPosicion());
    this.getVectorTanqueBoss().setDestino(PVector.sub(Boss.getPosicion(), this.posicion));
  }
  
  // Método para girar al jugador, alineándose con el enemigo
  public void spin(){
    float angle = PVector.angleBetween(this.getVectorTanque().getDestino(), this.getVectorTanqueBoss().getDestino());
    PVector rotacion = this.getVectorTanque().cruz(this.getVectorTanqueBoss());
    
    int direccion = 1;
    if(rotacion.z < 0){
      direccion = -1;
    }
    
    pushMatrix();
    translate(this.posicion.x, this.posicion.y);
    rotate(angle*direccion);
    this.displayCenter();
    popMatrix();    
  }
  public Bomba disparar(){
    // Obtener la posición actual del jugador
    PVector posicionJugador = new PVector(this.posicion.x, this.posicion.y);
    // Crear una bomba con la posición actual del jugador y la dirección hacia el enemigo
    return new Bomba(posicionJugador, this.getVectorTanqueBoss().getDestino());
}
  
  public void readCommand() {
    if (keyPressed) {
      if (keyCode == LEFT) {
        this.posicion.x-=this.velocidad.x*Time.getDeltaTime (frameRate);
      }
      if (keyCode == RIGHT) {
        this.posicion.x+=this.velocidad.x*Time.getDeltaTime (frameRate);
      }
      if (posicion.x > width) {
        posicion = new PVector(-50, posicion.y);
      }
      if (posicion.x < -50) {
        posicion = new PVector(width, posicion.y);
      }
    }
  }
}
