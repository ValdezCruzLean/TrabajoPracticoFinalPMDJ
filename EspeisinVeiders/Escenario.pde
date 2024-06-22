
/** 
  La clase Escenario representa un objeto de fondo utilizado en el juego.
  Hereda de GameObject e implementa la interfaz IVisualizable.
 */

class Escenario extends GameObject implements IVisualizable {
  
 /**Variable la cual guarda una imagen dentro de la clase*/
  private PImage imagen;
  /**
    Constructor predeterminado de Escenario.
    Crea un objeto Escenario sin inicializar.
   */
  public Escenario() {
     }
  


  /**
    Constructor de Escenario que recibe un tipo de fondo como parámetro.
    Carga y redimensiona la imagen de fondo según el tipo de fondo especificado.
    
    tipoFondo El tipo de fondo para determinar qué imagen cargar                
    Los posibles valores están definidos en la clase MaquinaEstados.
   */
  public Escenario(int tipoFondo) {
    this.posicion = new PVector(width/2,height/2);//Define la posicion de la imagen
    switch(tipoFondo) {
      case MaquinaEstados.PANTALLA_INICIANDO: {
        this.imagen = loadImage("./menu.jpg"); // Cargar imagen de inicio
       this.imagen.resize(1000, 700); // Redimensionar imagen a 1000x700 píxeles
        break;
      }
     case MaquinaEstados.PANTALLA_JUGANDOLEVELONE: {
        this.imagen = loadImage("./inicio.jpg"); // Cargar imagen de juego
        break;
      }
      case MaquinaEstados.PANTALLA_INSTRUCCIONANDO: {
        this.imagen = loadImage("./instrucciones.jpg"); // Cargar imagen de instrucciones
        this.imagen.resize(1000, 700); // Redimensionar imagen a 1000x700 píxeles
        break;
      }
     /* case MaquinaEstados.PANTALLA_PERDIENDO: {
        this.imagen = loadImage("perdiste.png"); // Cargar imagen de perdiste
        this.imagen.resize(1000, 700); // Redimensionar imagen a 1000x700 píxeles
        break;
      }
      case MaquinaEstados.PANTALLA_GANANDO: {
        this.imagen = loadImage("ganaste.png"); // Cargar imagen de ganaste
        this.imagen.resize(1000, 700); // Redimensionar imagen a 1000x700 píxeles
        break;
      }*/
    }
  }
/**
    Método display para mostrar el objeto Escenario en la pantalla con su imagen y posicion.  
   */
  public void display() {
    imageMode(CENTER);//Define que tomara como posicion el centro de la imagen
    image(imagen, this.posicion.x, this.posicion.y); // Muestra la imagen de fondo en las posiciones x e y 
  }
  
    /**Permite asignarle una imagen a la clase Escenario*/
  public void setImagen(PImage imagen) {
    this.imagen = imagen;
  }

  /**
   Obtiene la imagen de la clase Escenario
   */
  public PImage getImagen() {
    return this.imagen;
  }
}
