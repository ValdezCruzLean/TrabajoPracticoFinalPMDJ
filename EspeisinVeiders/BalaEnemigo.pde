public class BalaEnemigo extends GameObject implements IVisualizable {
    private PVector direccion;
    private float velocidad;
    private PVector velocidadPvector;
    private float size;
    private boolean bossDetected; // Nueva variable para detectar al Boss

    public BalaEnemigo() {}

    public BalaEnemigo(PVector posicion) {
        this.posicion = posicion;
        this.velocidad = 30;
        this.velocidadPvector = new PVector(0, 500);
        this.size = 10;
        this.bossDetected = false; // Inicialmente el Boss no está detectado
    }

    public void detectBoss(boolean detected) {
        this.bossDetected = detected; // Método para actualizar el estado del Boss
    }

    public void move() {
            this.posicion.y += this.velocidadPvector.y * Time.getDeltaTime(frameRate);
        }

    public void display() {
        fill(#F7E111);
        ellipse(posicion.x, posicion.y, 5, 30);
    }
    
    public void danarBoss(Boss boss){
    float closestX = clamp(this.posicion.x,boss.getPosCollider().x - boss.getAnchoCollider()/2, boss.getPosCollider().x + boss.getAnchoCollider()/2);
    float closestY = clamp(this.posicion.y,boss.getPosCollider().y - boss.getAltoCollider()/2, boss.getPosCollider().y + boss.getAltoCollider()/2);
    
    float distanciaX = this.posicion.x - closestX;
    float distanciaY = this.posicion.y - closestY;
    
    if((distanciaX * distanciaX + distanciaY * distanciaY) < (this.size/2 * this.size/2)){
      println("Hay colision");
      this.posicion = new PVector(-1000,-1000);
      boss.reducirVida(1);
    }
    }
    private float clamp(float value, float min, float max) {
      if (value < min) return min;
      if (value > max) return max;
      return value;
    }
}