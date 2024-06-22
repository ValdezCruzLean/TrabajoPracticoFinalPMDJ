class Alien extends GameObject implements IVisualizable {
    private PImage spritesheet;
    private PImage[] frames;
    private int currentFrame;
    private int totalFrames;
    private int frameHeight = 168; // Alto de cada frame
    private int lastFrameChangeTime;
    private int frameInterval = 1000; // cambiar frame cada 1000 ms (1 segundo)

    public Alien(PVector posicion) {
        this.posicion = posicion;
        this.velocidad = new PVector(2, height / 20);  // Velocidad vertical constante
        this.spritesheet = loadImage("Enemy.png");
        this.spritesheet.resize(1583, 168); // Redimensionamos la hoja de sprites si es necesario
        this.totalFrames = 6; // número total de frames en la hoja de sprites (excluyendo el último que es un punto)
        this.frames = new PImage[totalFrames];

        // Coordenadas de los frames y sus anchos
        int[] xPositions = {1, 232, 462, 692, 922, 1152};
        int[] widths = {201 - 1, 432 - 232, 662 - 462, 892 - 692, 1122 - 922, 1352 - 1152}; // Ancho de cada frame

        for (int i = 0; i < totalFrames; i++) {
            frames[i] = spritesheet.get(xPositions[i], 0, widths[i], frameHeight);
            frames[i].resize(60, 30); // Redimensionamos cada frame a 60x30
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
        this.posicion.x += this.velocidad.x * Time.getDeltaTime(frameRate);

        // Cambiar frame cada segundo
        if (millis() - lastFrameChangeTime > frameInterval) {
            currentFrame = (currentFrame + 1) % totalFrames;
            lastFrameChangeTime = millis();
        }
    }
}
