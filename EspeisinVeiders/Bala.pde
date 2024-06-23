class Bala extends GameObject implements IVisualizable{
 
    private PVector direccion;
    private float velocidad;

 public Bala() {}
  
  public Bala(PVector posicion,PVector direccion){
    this.posicion=posicion;
    this.velocidad = 30;
    this.direccion = direccion;
    
  } 
  public void move(){
        
  this.setPosicion(this.getPosicion().add(this.direccion.normalize().mult(velocidad)));   
  
  }
  
  public void display(){
    fill(#F7E111);
    ellipse(posicion.x,posicion.y,10,10);
  }
  
}
