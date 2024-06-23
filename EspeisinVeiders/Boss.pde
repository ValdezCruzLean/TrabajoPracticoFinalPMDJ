class Boss extends GameObject implements IVisualizable{

   private Vector vectorBoss;
   private Vector vectorTanqueBoss;
   private int cantVida; 

//private PVector velocidad;
private PImage imagen;

public Boss (){}

public Boss (PVector posicion) {
this.posicion= posicion;
this.velocidad= new PVector (1,height/20);
this.imagen = loadImage("Boss.png");
this.imagen.resize (300,300);
this.vectorBoss = new Vector(this.posicion, new PVector(1,0));
this.vectorTanqueBoss = new Vector();
this.cantVida = 50;// Asigna la cantidad de vida del jugador por defecto

}


 public Vector getVectorBosse(){
    return this.vectorBoss;
  }
  
  public void setVectorTanque(Vector vectorBoss){
    this.vectorBoss = vectorBoss;
  }
  
  public Vector getVectorTanqueBoss(){
    return this.vectorTanqueBoss;
  }  
  
  public void setVectorTanqueBoss(Vector vectorTanqueBoss){
    this.vectorTanqueBoss = vectorTanqueBoss;
  }
  
public void display() {
imageMode (CENTER);
image (imagen, this.posicion.x,this.posicion.y);
 fill(255);//Color del texto
  textSize(40);//Tamaño del texto
  text("Boss Life:" + this.cantVida, 50, 50);//Texto que aparecera en pantalla
}
public void move() {
this.posicion.y+=this.velocidad.y*Time.getDeltaTime (frameRate);
//this.posicion.x width/2+ width/2(sin(timer));
//this.posicion.y+=(sin(timer));
this.posicion.x = width/2+230 *(cos(timer));
}

 // Método para obtener el vector entre el enemigo y el jugador
  public void calcularVectorEnemigoJugador(GameObject player){
    this.getVectorTanqueBoss().setOrigen(this.getPosicion());
    this.getVectorTanqueBoss().setDestino(PVector.sub(player.posicion, this.posicion).normalize());
  }
}
