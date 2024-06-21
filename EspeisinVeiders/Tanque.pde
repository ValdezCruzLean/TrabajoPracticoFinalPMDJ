class Tanque extends GameObject implements IVisualizable{

 private PImage imagen; // DeclaraciÃ³n de la variable imagen
  // private PVector velocidad;
  public Tanque() { 
    
   this.posicion = new PVector(width/2,height-20);
    this.imagen = loadImage("Player.png");
    this.velocidad = new PVector(300,0);
  }
  
  
  
  public void disparar(SpawnerBalas spawner) {
    Bala unaBala = new Bala(new PVector(this.posicion.x, this.posicion.y));
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
