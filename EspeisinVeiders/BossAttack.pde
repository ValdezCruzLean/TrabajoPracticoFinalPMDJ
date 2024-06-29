public class BossAttack extends GameObject implements IVisualizable {
/*Variable tipo PVector que representa la direccion en la que se mueve la bala.*/
    //private PVector direccion;
 /*Variable velocidad tipo float de la bala cuando se esta detectando el Boss.*/    
   //private float velocidad;
/*Variable velocidadPvector tipo PVector de la bala cuando se esta detectando el Boss*/    
    private PVector velocidadPvector;
/*Variable float que representa el tamaño de la bala*/    
    private float size;
   

    public BossAttack() {
        this.posicion = new PVector(random(200,width-200), random(-200)); //Asigna la posicion de la clase lapiz por defecto        this.velocidad = 30;
        this.velocidadPvector = new PVector(0, 500);
        this.size = 15;
        this.velocidad = new PVector(10, 30);

    }

    public void move() {
          posicion.add(velocidad);
         if (posicion.y < -200 || posicion.y > height-150 ) {
    // Calcular el vector normal para el borde vertical
    PVector normalVertical = new PVector(0, 1);
    // Calcular el producto punto entre la velocidad y el vector normal
    float productoPuntoVertical = velocidad.dot(normalVertical);
    // Reflexionar la velocidad sobre el vector normal
    velocidad.sub(PVector.mult(normalVertical, 2 * productoPuntoVertical));
  }
  if (this.posicion.y > height-150){
  this.posicion.y= -100;
    this.posicion.x= random(200,width-200);

  }
  if (posicion.x < 100 || posicion.x > width - 190) {
    // Calcular el vector normal para el borde horizontal
    PVector normalHorizontal = new PVector(1, 0);
    // Calcular el producto punto entre la velocidad y el vector normal
    float productoPuntoHorizontal = velocidad.dot(normalHorizontal);
    // Reflexionar la velocidad sobre el vector normal
    velocidad.sub(PVector.mult(normalHorizontal, 2 * productoPuntoHorizontal));
  }
     
  }
    

    public void display() {
        fill(#25C1A1);
        ellipse(posicion.x, posicion.y, size, size);
        danarEscudo(escudo1);
         danarEscudo(escudo2);
         danarEscudo(escudo3);
    }

    public void danarTanque(Tanque tanque, SpawnerBossAttack spawner) {
        if (dist(this.posicion.x, this.posicion.y, tanque.getPosicion().x, tanque.getPosicion().y) < (this.size/2 + tanque.getSize()/2)) {
            println("Hay colisión con el tanque");
            tanque.reducirVida(3); // Reduce la vida del tanque
           // spawner.removeBalaEnemigo(this); // Remueve la bala enemiga
        }
    }
    
    /*Este método maneja la colisión de la bala con un objeto Escudo*/
    public void danarEscudo(Escudo escudo){
      /*Se verifica si la distancia es menor que la suma de los radios de la bala y el escudo existe colision*/
      if(dist(this.posicion.x,this.posicion.y,escudo.posicion.x, escudo.posicion.y)<(this.size/2+escudo.size/2)){
        escudo.reducirDurabilidad(1);
          // Calcular el vector normal para el borde vertical
    PVector normalVertical = new PVector(0, 1);
    // Calcular el producto punto entre la velocidad y el vector normal
    float productoPuntoVertical = velocidad.dot(normalVertical);
    // Reflexionar la velocidad sobre el vector normal
    velocidad.sub(PVector.mult(normalVertical, 2 * productoPuntoVertical));
      }
    }
}
