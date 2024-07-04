/*La clase BossAttack extiende GameObject e implementa todos los metodos de IVisualizable.. 
Representa un ataque inicial del jefe en el juego.*/
public class BossAttack extends GameObject implements IVisualizable {
  /*Atributo tipo PVevtor que epresenta el tamaño del ataque del jefe.*/
    private float size;
   
 // -----------Zona de Constructores----------------
/*Constructor por defecto*/
    public BossAttack() {
        this.posicion = new PVector(random(200,width-200), random(-200)); 
        this.size = 15;
        this.velocidad = new PVector(5, 15);

    }
     /*Metodo encarga de lograr mover los ataques en la pantalla.*/
    public void move() {
      /*Se actualiza la posicion sumando la velocidad actual.*/
          posicion.add(velocidad);
     /*Se verifica si la posicion esta fuera de los limites verticales especificados*/
         if (posicion.y < -200 || posicion.y > height-150 ) {
        /* Se define un vector normal al borde vertical.*/   
    PVector normalVertical = new PVector(0, 1);
    /*Se calcula el producto punto entre la velocidad y el vector normal*/
    float productoPuntoVertical = velocidad.dot(normalVertical);
    /*Se reflexionaa la velocidad sobre el vector normal*/
    velocidad.sub(PVector.mult(normalVertical, 2 * productoPuntoVertical));
  }
  /*Si la posicion y esta por encima de height -150 se modifica la posicion del ataque*/
  if (this.posicion.y > height-150){
  this.posicion.y= -100;
    this.posicion.x= random(200,width-200);

  }
   /*Se verifica si la posicion esta fuera de los limites horizontale especificados*/
  if (posicion.x < 100 || posicion.x > width - 190) {
    /* Se calcula el vector normal para el borde horizontal*/
    PVector normalHorizontal = new PVector(1, 0);
    /* Se calcula el producto punto entre la velocidad y el vector normal*/
    float productoPuntoHorizontal = velocidad.dot(normalHorizontal);
    /* Se reflexiona la velocidad sobre el vector normal*/
    velocidad.sub(PVector.mult(normalHorizontal, 2 * productoPuntoHorizontal));
  }
     
  }
    
/*Metodo display que permite dibujar el ataque del jefe en la pantalla*/
    public void display() {
      /*Se dibuja un elipse en la posicion actual del ataque con el tamaño especificado.*/
        fill(#25C1A1);
        ellipse(posicion.x, posicion.y, size, size);
        /*Se llama al metodo danarEscudo() para comprobar y manejar la colisión con tres escudos.*/
         danarEscudo(escudo1);
         danarEscudo(escudo2);
         danarEscudo(escudo3);
    }
/*Metodo el cual se encarga que comprueba si hay colisión con el tanque y le resta vida*/
    public void danarTanque(Tanque tanque) {
      /*Se calcula la distancia entre la posicion del ataque y la del tanque.*/
      /*Si la distancia es menor que la suma de los radios del ataque y del tanque se considera una colision.*/
        if (dist(this.posicion.x, this.posicion.y, tanque.getPosicion().x, tanque.getPosicion().y) < (this.size/2 + tanque.getSize()/2)) {
            println("Hay colisión con el tanque");
            /*Se reduce la vida del tanque en 3 unidades.*/
            tanque.reducirVida(3); 
        }
    }
    
    /*Este método maneja la colisión de la bala con el Escudo*/
    public void danarEscudo(Escudo escudo){
      /*Se verifica si la distancia es menor que la suma de los radios de la bala y el escudo existe colision*/
      if(dist(this.posicion.x,this.posicion.y,escudo.posicion.x, escudo.posicion.y)<(this.size/2+escudo.size/2)){
       /*Se reduce la durabilidad del escudo en 1 unidad.*/
        escudo.reducirDurabilidad(1);
       /*Calcula la reflexion de la velocidad sobre el eje vertical.*/
    PVector normalVertical = new PVector(0, 1);
    /*Se calcula el producto punto entre la velocidad y el vector normal*/
    float productoPuntoVertical = velocidad.dot(normalVertical);
    /*Se reflexiona la velocidad sobre el vector normal*/
    velocidad.sub(PVector.mult(normalVertical, 2 * productoPuntoVertical));
      }
    }
}
