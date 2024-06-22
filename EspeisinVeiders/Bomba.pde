class Bomba extends GameObject{  
  private float velocidad;
  private PVector direccion;
  private PImage imagen;

 
  public Bomba (PVector posicion, PVector direccion){
    this.posicion = posicion;
    this.velocidad = 15;
    this.imagen = loadImage("Bomba.png");
    this.direccion = direccion;
  }
  
 
  public void display(){
    imageMode(CENTER);
    image(this.imagen, this.posicion.x, this.posicion.y, 40, 60);
  }
  
 
  public void move(){
    this.setPosicion(this.getPosicion().add(this.direccion.normalize().mult(velocidad)));
  }
}
