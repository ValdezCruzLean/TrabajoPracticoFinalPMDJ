class SpawnerBalas{
  private int cantidadBalas;
  private Bala[] balas;
  
  public SpawnerBalas(){
    
  }
  
    public SpawnerBalas(int cantidadBalas){
      this.cantidadBalas = cantidadBalas;
    balas = new Bala[cantidadBalas];
  }
  
  public Bala[] getBalas(){
    return this.balas;
  }
  
  public void setBalas(Bala[] balas){
    this.balas=balas;
  }
  
  public void actualizarBalas(){
    for(Bala b:balas){
      if(b!=null){
        b.move();
        b.display();
      }
    }
  }
  
  
}
