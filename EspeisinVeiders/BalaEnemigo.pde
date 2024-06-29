public class BalaEnemigo extends GameObject implements IVisualizable {
      private float size;

    public BalaEnemigo() {}

    public BalaEnemigo(PVector posicion) {
        this.posicion = posicion;
        this.velocidad = new PVector(0, 500);
        this.size = 20;
    }

    public void move() {
        this.posicion.y += this.velocidad.y * Time.getDeltaTime(frameRate);
    }

    public void display() {
        fill(#D81414);
        ellipse(posicion.x, posicion.y, size, size);
         danarEscudo(escudo1);
         danarEscudo(escudo2);
         danarEscudo(escudo3);
    }

    public void danarTanque(Tanque tanque, SpawnerBalasEnemigo spawner) {
        if (dist(this.posicion.x, this.posicion.y, tanque.getPosicion().x, tanque.getPosicion().y) < (this.size/2 + tanque.getSize()/2)) {
            println("Hay colisión con el tanque");
            tanque.reducirVida(10); // Reduce la vida del tanque
            spawner.removeBalaEnemigo(this); // Remueve la bala enemiga
        }
    }
    public void danarEscudo(Escudo escudo){
      /*Se verifica si la distancia es menor que la suma de los radios de la bala y el escudo existe colision*/
      if(dist(this.posicion.x,this.posicion.y,escudo.posicion.x, escudo.posicion.y)<(this.size/2+escudo.size/2)){
        escudo.reducirDurabilidad(100);
           println("Hay colision escudo");
      }
    }
}
