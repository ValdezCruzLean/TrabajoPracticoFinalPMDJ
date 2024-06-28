/*La clase Vector representa un vector en el espacio utilizando dos puntos PVector para definir su origen y su destino.*/
class Vector{
/*PVector que representa el punto de origen del vector.*/  
  private PVector origen;
  /*PVector que representa el punto de destino del vector.*/
  private PVector destino;
  
 // -----------Zona de Constructores----------------
/*Constructor por defecto*/
  public Vector(){}
  
    /*Constructor parametrizado*/
  public Vector(PVector origen, PVector destino){
    this.origen = origen;
    this.destino = destino;
  }
  
  /*Metodos get y set permiten establecer (set) y obtener (get) los valores de origen y destino.*/
  /*Establece el valor del atributo origen*/
  public void setOrigen(PVector origen){
    this.origen = origen;
  }
  /*Establece el valor del atributo destino*/
  public void setDestino(PVector destino){
    this.destino = destino;
  }
  /*Devuelve el valor del atributo origen*/
  public PVector getOrigen(){
    return this.origen;
  }
  /*Devuelve el valor del atributo destino*/
  public PVector getDestino(){
    return this.destino;
  }
  
  
  /*Metodo para obtener el producto cruz, calcula el producto cruz de dos vectores.*/
  public PVector cruz(Vector vector){
    PVector producto = new PVector(0,0);
/*Calcula el producto cruzado de este vector con otro vector proporcionado como argumento.*/
/*Utiliza el metodo cross del objeto PVector para realizar esta operacion*/
    producto = this.getDestino().cross(vector.getDestino());
/*Devuelve un nuevo PVector que representa el resultado del producto cruz.*/
    return producto;
  }
}
