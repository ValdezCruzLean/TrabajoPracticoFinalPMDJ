/**
  La clase GameObject es una clase abstracta que representa un objeto del juego.
  Contiene atributos y métodos comunes para todos los objetos del juego.
 */
abstract class GameObject {
/** Variable que representa la posicion de la clase GameObject*/
  protected PVector posicion;
  protected PVector velocidad;
  //---------Zona de constructores-------------------
  /**
    Constructor por defecto de GameObject.
   */
  public GameObject() {
    
  }
  //---------------Zona de Metodos--------------------

  /**
    Constructor de GameObject que recibe la posición como parámetro.
    Inicializa el objeto GameObject según los valores proporcionados.
   */
  public GameObject(PVector posicion,PVector velocidad) {
    this.posicion = posicion; //La posición inicial del objeto GameObject.
    this.velocidad=velocidad;
  }

  /**
    Asigna la posición del objeto GameObject.  
   */
  public void setPosicion(PVector posicion) {
    this.posicion = posicion;
  }

  /**
    Obtiene la posición del objeto GameObject.   
   */
  public PVector getPosicion() {
    return this.posicion;
  }
   /**
    Asigna la posición del objeto GameObject.  
   */
  public void setVelocidad(PVector velocidad) {
    this.velocidad = velocidad;
  }

  /**
    Obtiene la posición del objeto GameObject.   
   */
  public PVector getVelocidad() {
    return this.velocidad;
  }

}
