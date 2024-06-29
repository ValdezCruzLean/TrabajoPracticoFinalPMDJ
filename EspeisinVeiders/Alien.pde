/*La clase Alien extiende GameObject e implementa todos los metodos de IVisualizable.
Representa el alien en el juego que tiene una animacion de multiples frames y un movimiento oscilante.*/
class Alien extends GameObject implements IVisualizable {
  /*Atributo Pimagen que contiene todos los frames de la animacion del alien.*/
    private PImage spritesheet;
  /*Atributo tipo arreglo que almacena cada frame de la animacion extraído del spritesheet.*/
    private PImage[] frames;
  /*Índice del frame actual que se está mostrando.*/  
    private int currentFrame;
    /*Atributo tipo entero que representa el numero total de frames en la hoja de sprites.*/
    private int totalFrames;
    /*Atributo tipo entero que representa ancho de cada frame en la hoja de sprites.*/
    private int frameWidth = 115; 
   /*Atributo tipo entero que representa alto de cada frame en la hoja de sprites.*/
    private int frameHeight = 100; 
    /*Atributo tipo entero que representa tiempo en milisegundos desde el ultimo cambio de frame.*/
    private int lastFrameChangeTime;
    /*Atributo tipo entero que representa el intervalo de tiempo en milisegundos para cambiar el frame (1 segundo).*/
    private int frameInterval = 1000; 
    /*Atriburo tipo int que representa tamaño del alien*/
    private float size;
    /*Atributo tipo entero que representa la posicion X inicial del alien para el movimiento oscilante.*/
    private float initialX; 
    
    public Alien(PVector posicion) {
        this.posicion = posicion;
        this.velocidad = new PVector(2, height / 150); 
        this.spritesheet = loadImage("Enemy.png");
        this.totalFrames = 6; 
        this.frames = new PImage[totalFrames];
        this.size = 40;
        /* Extraer cada frame de la hoja de sprites*/
        for (int i = 0; i < totalFrames; i++) {
            frames[i] = spritesheet.get(i * frameWidth, 0, frameWidth, frameHeight);
            frames[i].resize(70, 55); // Redimensionamos cada frame a 60x30
        }
        
        this.currentFrame = 0;
        this.lastFrameChangeTime = millis();
        this.initialX = posicion.x;
    }
 /*Metodo encargado de la representacion visual del alien en la pantalla.*/
    public void display() {
        imageMode(CENTER);
     /*Se dibuja el frame actual en la posicion del alien*/
        image(frames[currentFrame], this.posicion.x, this.posicion.y);
    }
  /*Metodo que se encarga de mover el alien en el juego*/
    public void move() {
        this.posicion.y += this.velocidad.y * Time.getDeltaTime(frameRate);
        /*Se actualiza la posicion en x para crear un movimiento oscilante*/
         this.posicion.x = this.initialX +75 * (cos(timer*0.7)); 
      
        /*Si el tiempo transcurrido desde el ultimo cambio de frame es mayor que el intervalo de frame ,
          se actualiza el frame actual al siguiente frame de manera circular*/
        if (millis() - lastFrameChangeTime > frameInterval) {
            currentFrame = (currentFrame + 1) % totalFrames;
            lastFrameChangeTime = millis();
        }
    }
}
