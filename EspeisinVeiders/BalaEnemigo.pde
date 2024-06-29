/*La clase BalaEnemigo extiende GameObject e implementa todos los metodos de IVisualizable. 
Representa una bala disparada por un Boss en el juego.*/
public class BalaEnemigo extends GameObject implements IVisualizable {
  /*Atributo tipo Pvector que representa el tamaño de la bala.*/
      private float size;
// -----------Zona de Constructores----------------
/*Constructor por defecto*/
    public BalaEnemigo() {}
 /*Constructor parametrizado*/
    public BalaEnemigo(PVector posicion) {
        this.posicion = posicion;
        this.velocidad = new PVector(0, 500);
        this.size = 20;
    }
/*Metodo move que se encarga de mover la bala del Boss*/
    public void move() {
        this.posicion.y += this.velocidad.y * Time.getDeltaTime(frameRate);
    }
    /*Metodo encargado de la representacion visualizar la bala del Boss en la pantalla.*/
    public void display() {
        fill(#D81414);
        ellipse(posicion.x, posicion.y, size, size);
         danarEscudo(escudo1);
         danarEscudo(escudo2);
         danarEscudo(escudo3);
    }
/*Metodo el cual se encarga que comprueba si hay colisión con el tanque y le resta vida*/
    public void danarTanque(Tanque tanque, SpawnerBalasEnemigo spawner) {
      /*Se calcula la distancia entre la posicion del ataque y la del tanque.*/
      /*Si la distancia es menor que la suma de los radios del ataque y del tanque se considera una colision.*/
        if (dist(this.posicion.x, this.posicion.y, tanque.getPosicion().x, tanque.getPosicion().y) < (this.size/2 + tanque.getSize()/2)) {
            println("Hay colisión con el tanque");
             /*Se reduce la vida del tanque en 10 unidades.*/
            tanque.reducirVida(10); 
            /*Se remueve la bala enemiga*/
            spawner.removeBalaEnemigo(this); 
        }
    }
    /*Este método maneja la colisión de la bala con un objeto Escudo*/
    public void danarEscudo(Escudo escudo){
      /*Se verifica si la distancia es menor que la suma de los radios de la bala y el escudo existe colision*/
      if(dist(this.posicion.x,this.posicion.y,escudo.posicion.x, escudo.posicion.y)<(this.size/2+escudo.size/2)){
        escudo.reducirDurabilidad(100);
           println("Hay colision escudo");
      }
    }
}
