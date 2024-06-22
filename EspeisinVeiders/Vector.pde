class Vector{
  
  private PVector origen;
  private PVector destino;
  
 
  public Vector(){}
  
  // Constructor Parametrizado
  public Vector(PVector origen, PVector destino){
    this.origen = origen;
    this.destino = destino;
  }
  
  // Metodos get y set
  public void setOrigen(PVector origen){
    this.origen = origen;
  }
  public void setDestino(PVector destino){
    this.destino = destino;
  }
  
  public PVector getOrigen(){
    return this.origen;
  }
  public PVector getDestino(){
    return this.destino;
  }
  
  
  //Método para obtener el producto cruz
  public PVector cruz(Vector vector){
    PVector producto = new PVector(0,0);
    producto = this.getDestino().cross(vector.getDestino());
    return producto;
  }
}
