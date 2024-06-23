class Bala extends GameObject implements IVisualizable{
 
    private PVector direccion;
    private float velocidad;
    private PVector velocidadPvector;


 public Bala() {}
  
  public Bala(PVector posicion,PVector direccion){
    this.posicion=posicion;
    this.velocidad = 30;
    this.direccion = direccion;
    this.velocidadPvector = new PVector(0,-500);

    
  } 
  public void move(){
    
    if (tiempo.getTime() < 130) {//Indicamos que si el tiempo es menor a 100 se ejecutaran las siguientes sentencias 
this.setPosicion(this.getPosicion().add(this.direccion.normalize().mult(velocidad)));  
   }else{
   
    this.posicion.y+=this.velocidadPvector.y*Time.getDeltaTime (frameRate);
   }
        
   
  
  }
  
  public void display(){
    fill(#F7E111);
    ellipse(posicion.x,posicion.y,10,10);
  }
  
}
