/*La clase Bala extiende extiende de GameObject e implementa todos los metodos de IVisualizable.*/
public class Bala extends GameObject implements IVisualizable {
  /*Variable tipo PVector que representa la direccion en la que se mueve la bala.*/
    private PVector direccion;
 /*Variable velocidad tipo float de la bala cuando se esta detectando el Boss.*/    
    private float velocidad;
/*Variable velocidadPvector tipo PVector de la bala cuando se esta detectando el Boss*/    
    private PVector velocidadPvector;
/*Variable float que representa el tamaño de la bala*/    
    private float size;
/*Variable tipo booleana para detectar al Boss*/    
    private boolean bossDetected; 
// -----------Zona de Constructores----------------
/*Constructor por defecto*/
    public Bala() {}
 /*Constructor parametrizado*/
    public Bala(PVector posicion, PVector direccion) {
        this.posicion = posicion;
        this.velocidad = 30;
        this.direccion = direccion;
        this.velocidadPvector = new PVector(0, -500);
        this.size = 10;
        this.bossDetected = false; 
    }
/*Metodo que permite cambiar el estado de bossDetected*/
    public void detectBoss(boolean detected) {
        this.bossDetected = detected; 
    }
/* Metodo que gestiona el movimiento de la bala en funcion de si ha detectado al Boss o no.*/
    public void move() {
      /*Si bossDetected es true, la bala se mueve en la dirección especificada por direccion a una velocidad determinada (velocidad). 
      Ademas, se llama al metodo danarBoss() para causar daño al jefe si hay colisión.*/
        if (bossDetected) {
            this.setPosicion(this.getPosicion().add(this.direccion.normalize().mult(velocidad)));
            danarBoss(boss,spawner);
        } else {
          /* Si bossDetected es false, la bala se mueve verticalmente utilizando velocidadPvector. */
            this.posicion.y += this.velocidadPvector.y * Time.getDeltaTime(frameRate);
        }
        for (Escudo escudo : escudos) {
          danarEscudo(escudo,spawner);
          
       // if (!escudo.isDestroyed() && this.posicion.x > escudo.posicion.x && this.posicion.x < escudo.posicion.x + escudo.ancho && this.posicion.y > escudo.posicion.y && this.posicion.y < escudo.posicion.y + escudo.alto) {
           
           // this.posicion = new PVector(-1000,-1000);
            // Aquí podrías agregar lógica para destruir la bala también
      //  }
      }
    }
/*Metodo encargado de la representacion visual de la bala en la pantalla.*/
    public void display() {
        fill(#F7E111);
        ellipse(posicion.x, posicion.y, 10, 10);
    }
    /*Metodo que maneja la colision de la bala con elBoss. */
    public void danarBoss(Boss boss, SpawnerBalas spawner){
      /*Calcula la posicion mas cercana en el eje X al collider del Boss*/
    float closestX = clamp(this.posicion.x,boss.getPosCollider().x - boss.getAnchoCollider()/2, boss.getPosCollider().x + boss.getAnchoCollider()/2);
    /*Calcula la posicion mas cercana en el eje Y al collider del Boss*/
    float closestY = clamp(this.posicion.y,boss.getPosCollider().y - boss.getAltoCollider()/2, boss.getPosCollider().y + boss.getAltoCollider()/2);
    /*Calcula las distancias en X e Y desde la posicion actual de la bala hasta el punto mas cercano al collider del Boss*/
    float distanciaX = this.posicion.x - closestX;
    float distanciaY = this.posicion.y - closestY;
    /*Se comprueba si la distancia al cuadrado es menor al radio al cuadrado de la bala*/
    if((distanciaX * distanciaX + distanciaY * distanciaY) < (this.size/2 * this.size/2)){
      println("Hay colision");
     // this.posicion = new PVector(-1000,-1000);
     /* Reduce la vida del Boss en 10 puntos*/
      boss.reducirVida(10);
      /*Remueve la bala del Spawner de balas*/
      spawner.removeBala(this);
    }
    }
    /*El metodo clamp es una funcion auxiliar privada utilizada dentro de danarBoss*/
    private float clamp(float value, float min, float max) {
      /* Si value es menor que min, devuelve min*/
      if (value < min) return min;
      /*Si es mayor que max, devuelve max*/
      if (value > max) return max;
      /*Caso contrario devuelve value sin cambios.*/
      return value;
    }
    /*Este método maneja la colisión de la bala con un objeto Escudo*/
    public void danarEscudo(Escudo escudo, SpawnerBalas spawner){
      /*Se verifica si la distancia es menor que la suma de los radios de la bala y el escudo existe colision*/
      if(dist(this.posicion.x,this.posicion.y,escudo.posicion.x, escudo.posicion.y)<(this.size/2+escudo.size/2)){
        escudo.hit();
           println("Hay colision escudo");
           spawner.removeBala(this);
      }
    }
}
