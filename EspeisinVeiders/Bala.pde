class Bala extends GameObject implements IVisualizable{
 
  
  
 public Bala() {}
  
  public Bala(PVector posicion){
    this.posicion=posicion;
    this.velocidad = new PVector(0,-500);
    
  } 
  public void move(){
        
    this.posicion.y+=this.velocidad.y*Time.getDeltaTime (frameRate);
   
  }
  
  public void display(){
    fill(#F7E111);
    ellipse(posicion.x,posicion.y,10,20);
  }
  
}
