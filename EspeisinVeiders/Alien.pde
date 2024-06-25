class Alien extends GameObject implements IVisualizable {
    private PImage spritesheet;
    private PImage[] frames;
    private int currentFrame;
    private int totalFrames;
    private int frameWidth = 115; // Ancho de cada frame
    private int frameHeight = 100; // Alto de cada frame
    private int lastFrameChangeTime;
    private int frameInterval = 1000; // cambiar frame cada 1000 ms (1 segundo)
    private float size;
    
   // private float timerOffset; // Desplazamiento aleatorio para el movimiento oscilante
    private float initialX; // Posición X inicial
    
    public Alien(PVector posicion) {
        this.posicion = posicion;
        this.velocidad = new PVector(2, height / 100); // Velocidad vertical constante
        this.spritesheet = loadImage("Enemy.png");
        this.totalFrames = 6; // número total de frames en la hoja de sprites
        this.frames = new PImage[totalFrames];
        this.size = 40;
        // Extraer cada frame de la hoja de sprites
        for (int i = 0; i < totalFrames; i++) {
            frames[i] = spritesheet.get(i * frameWidth, 0, frameWidth, frameHeight);
            frames[i].resize(70, 55); // Redimensionamos cada frame a 60x30
        }

        this.currentFrame = 0;
        this.lastFrameChangeTime = millis();
        
          // Inicializar el desplazamiento aleatorio para el movimiento oscilante
        //this.timerOffset = random(TWO_PI);
        // Guardar la posición X inicial
        this.initialX = posicion.x;
    }

    public void display() {
        imageMode(CENTER);
        image(frames[currentFrame], this.posicion.x, this.posicion.y);
    }

    public void move() {
        this.posicion.y += this.velocidad.y * Time.getDeltaTime(frameRate);
        //this.posicion.x = height/2+ 100*(cos(timer));
         //this.posicion.x = width / 2 + 100 * (cos(timer + this.timerOffset)); // Añadir el offset al timer
         this.posicion.x = this.initialX + 200 * (cos(timer*0.5)); // Usar la posición X inicial

      //  this.posicion.x += this.velocidad.x * Time.getDeltaTime(frameRate);

        // Cambiar frame cada segundo
        if (millis() - lastFrameChangeTime > frameInterval) {
            currentFrame = (currentFrame + 1) % totalFrames;
            lastFrameChangeTime = millis();
        }
    }
}
