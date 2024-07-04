/*La clase Bomba extiende extiende de GameObject e implementa todos los metodos de IVisualizable.
representa una bomba que dispara el tanque hacia la direccion del boss*/
class Bomba extends GameObject implements IVisualizable{ 
  /*Atributo tipo float que representa la velocidad de la bomba.*/
  private float velocidad;
  /*Atributo tipo tipo PVector que representa la dirección en la que se mueve la bomba.*/
  private PVector direccion;
  /*Atributo tipo PImage que representa Imagen que representa visualmente a la bomba. */
  private PImage imagen;
  /*Atributo tipo PVector que representa el tamaño de la bomba.*/
  private float size;
  
  // -----------Zona de Constructores----------------
/*Constructor parametrizado*/
  public Bomba (PVector posicion, PVector direccion){
    this.posicion = posicion;
    this.velocidad = 15;
    this.imagen = loadImage("Bomba.png");
    this.direccion = direccion;
    this.size = 50;
  }
  
    /*Metodo encargado de la representacion visual de la bomba en la pantalla.*/
  public void display(){
    /*Se dibuja un elipse transparente en la posicion de la bomba*/
    fill(0,0);
    ellipse(posicion.x, posicion.y, size, size);
    /*Se dibuja la imagen de la bomba en su posicion actual*/
    imageMode(CENTER);
    image(this.imagen, this.posicion.x, this.posicion.y, 40, 60);
  }
  
     /*Metodo encargado de lograr mover la bomba en la pantalla.*/
  public void move(){
    /*Se actualiza la posicion de la bomba sumando a su posicion actual la direccion normalizada multiplicada por la velocidad.*/
            this.setPosicion(this.getPosicion().add(this.direccion.normalize().mult(velocidad)));
    /*Se llama al metodo danarBoss() para comprobar si la bomba colisiona con el jefe.*/
            danarBoss(boss);
       
  }
       /*Metodo comprueba si la bomba colisiona con el boss*/
    public void danarBoss(Boss boss){
      /*Se encuentra el punto mas cercano en el colisionador del jefe a la posicion de la bomba */
    float closestX = clamp(this.posicion.x,boss.getPosCollider().x - boss.getAnchoCollider()/2, boss.getPosCollider().x + boss.getAnchoCollider()/2);
    float closestY = clamp(this.posicion.y,boss.getPosCollider().y - boss.getAltoCollider()/2, boss.getPosCollider().y + boss.getAltoCollider()/2);
    /*Se calcula las distancias en X e Y desde la posicion de la bomba a este punto cercano.*/
    float distanciaX = this.posicion.x - closestX;
    float distanciaY = this.posicion.y - closestY;
    /*Si la distancia al cuadrado esta dentro del radio de la bomba, se considera una colision*/
    if((distanciaX * distanciaX + distanciaY * distanciaY) < (this.size/2 * this.size/2)){
      println("Hay colision");
      /*Se mueve la bomba fuera del escenario */
      this.posicion = new PVector(-1000,-1000);
      /*Se reduce la vida del jefe en 100 unidades.*/
      boss.reducirVida(100);
    }
    }
    /*Se limita el valor de value para que este dentro del rango min, max*/
    private float clamp(float value, float min, float max) {
      if (value < min) return min;
      if (value > max) return max;
      return value;
    }
}
