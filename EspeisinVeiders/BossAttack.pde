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
        this.posicion = new PVector(random(width), random(-300)); //Asigna la posicion de la clase lapiz por defecto        this.velocidad = 30;
        this.velocidadPvector = new PVector(0, 500);
        this.size = 10;
    }

    public void move() {
        this.posicion.y += this.velocidadPvector.y * Time.getDeltaTime(frameRate);
        
         if (posicion.y > height) {//Condicional si la posicion en y es mayor al alto de la pantalla
      posicion.y = random(-400); // Si se encuentra fuera de la pantalla, se reinicia su posición en y de forma aleatoria
      posicion.x = random(width);// Si se encuentra fuera de la pantalla, se reinicia su posición en x de forma aleatoria
    }
  }
    

    public void display() {
        fill(#25C1A1);
        ellipse(posicion.x, posicion.y, size, size);
    }

    public void danarTanque(Tanque tanque, SpawnerBossAttack spawner) {
        if (dist(this.posicion.x, this.posicion.y, tanque.getPosicion().x, tanque.getPosicion().y) < (this.size/2 + tanque.getSize()/2)) {
            println("Hay colisión con el tanque");
            tanque.reducirVida(3); // Reduce la vida del tanque
           // spawner.removeBalaEnemigo(this); // Remueve la bala enemiga
        }
    }
}
