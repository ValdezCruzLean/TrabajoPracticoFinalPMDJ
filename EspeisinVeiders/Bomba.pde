class Bomba extends GameObject{  
  private float velocidad;
  private PVector velocidadPvector;
  private PVector direccion;
  private PImage imagen;
  private float size;
  private boolean bossDetected;
  public Bomba (PVector posicion, PVector direccion){
    this.posicion = posicion;
    this.velocidad = 15;
    this.imagen = loadImage("Bomba.png");
    this.direccion = direccion;
    this.velocidadPvector = new PVector(0, -500);
    this.size = 50;
    this.bossDetected = false;
  }
  
 public void detectBoss(boolean detected) {
        this.bossDetected = detected; // Método para actualizar el estado del Boss
    }
    
  public void display(){
    ellipse(posicion.x, posicion.y, size, size);
    imageMode(CENTER);
    image(this.imagen, this.posicion.x, this.posicion.y, 40, 60);
  }
  
 
  public void move(){
    //this.setPosicion(this.getPosicion().add(this.direccion.normalize().mult(velocidad)));
    if (bossDetected) {
            this.setPosicion(this.getPosicion().add(this.direccion.normalize().mult(velocidad)));
            danarBoss(boss);
        } 
        else {
            this.posicion.y += this.velocidadPvector.y * Time.getDeltaTime(frameRate);
        }
  }
  
    public void danarBoss(Boss boss){
    float closestX = clamp(this.posicion.x,boss.getPosCollider().x - boss.getAnchoCollider()/2, boss.getPosCollider().x + boss.getAnchoCollider()/2);
    float closestY = clamp(this.posicion.y,boss.getPosCollider().y - boss.getAltoCollider()/2, boss.getPosCollider().y + boss.getAltoCollider()/2);
    
    float distanciaX = this.posicion.x - closestX;
    float distanciaY = this.posicion.y - closestY;
    
    if((distanciaX * distanciaX + distanciaY * distanciaY) < (this.size/2 * this.size/2)){
      println("Hay colision");
      this.posicion = new PVector(-1000,-1000);
      boss.reducirVida(5);
    }
    }
    private float clamp(float value, float min, float max) {
      if (value < min) return min;
      if (value > max) return max;
      return value;
    }
}
