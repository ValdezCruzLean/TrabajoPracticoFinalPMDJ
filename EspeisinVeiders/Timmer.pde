/**
  Clase que representa un temporizador.
  Extiende la clase GameObject e implementa la interfaz IVisualizable.
 */
public class Timmer extends GameObject implements IVisualizable {
  /** Variable que representa el tiempo total del temporizador */
  private float time; 
 /**Variable la cual guarda una imagen dentro de la clase*/
 private PImage imagen;
 //-----------Zona de constructores-----------
  /**
    Constructor por defecto de la clase Timmer
     Asigna valores por defecto a los atributos de la clase Timmer
   */
  public Timmer() {
    this.time = 146;//Asigna el tiempo por defecto
    this.posicion = new PVector(1040, 150); //Asigna una posicion por defecto
    imagen = loadImage("reloj.png"); //Asigna una imagen por defecto
  }

/**
    Constructor parametrizado de Timmer que recibe la posición,ruta de imagen y tiempo como parámetros.
    Inicializa los atributos del objeto Timmer según los valores proporcionados.
   */
  public Timmer(PVector posicion, float time, String rutaImagen) {
    this.time = time; //El tiempo total del temporizador.
    this.posicion = posicion; //La posición del temporizador.
    imagen = loadImage(rutaImagen); //La ruta de la imagen del temporizador.
  }
//------------Zona de Metodos-----------    
 
  /**
    Método para realizar la cuenta regresiva del temporizador.
   */
  public void countDown() {
    time = time - 1 /frameRate;//EL tiempo va a ir en cuenta regresiva
    display();//Llama al metodo display para visualizar el temporizador
  }

  /**
    Método para mostrar el temporizador en pantalla.
   */
  public void display() {
    imagen.resize(120, 120);// Redimensionar la imagen a 120x120 píxeles
    image(imagen, this.posicion.x+20, this.posicion.y-10 );//Muestra la imagen del Lapiz en su posición en x +20 y en Y -10
    fill(255);//Asigna el color del texto
    textSize(30);//Asigna el tamaño del texto
    text((int) this.time, this.posicion.x, this.posicion.y);//Muestra el texto como entero
  }
  
/** Permite asignar una nueva imagen a la clase Timmer */
public void setImagen(String rutaImagen) {
  this.imagen = loadImage(rutaImagen); // Carga la nueva imagen desde la ruta proporcionada
}

  /**
   Obtiene la imagen de la clase Timmer
   */
  public PImage getImagen() {
    return this.imagen;
  }


  /**
    Asigna el tiempo del temporizador de la clase Timmer.
   */
  public void setTime(float time) {
    this.time = time;
  }

  /**
    Obtiene el tiempo del temporizador.
   */
  public float getTime() {
    return this.time;
  }

}
