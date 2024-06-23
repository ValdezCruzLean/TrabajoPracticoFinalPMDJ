class Alien extends GameObject implements IVisualizable {
    private PImage spritesheet;
    private PImage[] frames;
    private int currentFrame;
    private int totalFrames;
    private int frameWidth = 115; // Ancho de cada frame
    private int frameHeight = 100; // Alto de cada frame
    private int lastFrameChangeTime;
    private int frameInterval = 1000; // cambiar frame cada 1000 ms (1 segundo)

    public Alien(PVector posicion) {
        this.posicion = posicion;
        this.velocidad = new PVector(2, height / 20); // Velocidad vertical constante
        this.spritesheet = loadImage("Enemy.png");
        this.totalFrames = 6; // número total de frames en la hoja de sprites
        this.frames = new PImage[totalFrames];

        // Extraer cada frame de la hoja de sprites
        for (int i = 0; i < totalFrames; i++) {
            frames[i] = spritesheet.get(i * frameWidth, 0, frameWidth, frameHeight);
            frames[i].resize(60, 40); // Redimensionamos cada frame a 60x30
        }

        this.currentFrame = 0;
        this.lastFrameChangeTime = millis();
    }

    public void display() {
        imageMode(CENTER);
        image(frames[currentFrame], this.posicion.x, this.posicion.y);
    }

    public void move() {
        this.posicion.y += this.velocidad.y * Time.getDeltaTime(frameRate);
      //  this.posicion.x += this.velocidad.x * Time.getDeltaTime(frameRate);

        // Cambiar frame cada segundo
        if (millis() - lastFrameChangeTime > frameInterval) {
            currentFrame = (currentFrame + 1) % totalFrames;
            lastFrameChangeTime = millis();
        }
    }
}
