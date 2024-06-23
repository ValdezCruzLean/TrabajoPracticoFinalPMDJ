class Boss extends GameObject implements IVisualizable {

    private Vector vectorBoss;
    private Vector vectorTanqueBoss;
    private int cantVida;

    private PImage spriteSheet;
    private PImage[] sprites; // Array para almacenar los dos sprites
    private PVector velocidad;
    private int spriteIndex; // Índice para alternar entre los sprites
    private int lastSpriteChangeTime; // Tiempo del último cambio de sprite

    public Boss() {}

    public Boss(PVector posicion) {
        this.posicion = posicion;
        this.velocidad = new PVector(1, height / 20);
        this.spriteSheet = loadImage("Boss.png"); // Carga la imagen que contiene los sprites
        this.sprites = new PImage[2];
        this.sprites[0] = spriteSheet.get(0, 0, 340, spriteSheet.height); // Sprite desde 0 a 340
        this.sprites[1] = spriteSheet.get(345, 0, 338, spriteSheet.height); // Sprite desde 345 a 683
        this.vectorBoss = new Vector(this.posicion, new PVector(1, 0));
        this.vectorTanqueBoss = new Vector();
        this.cantVida = 50; // Asigna la cantidad de vida del jugador por defecto
        this.spriteIndex = 0; // Inicializa el índice de sprites
        this.lastSpriteChangeTime = millis(); // Inicializa el tiempo del último cambio de sprite
    }

    public Vector getVectorBosse() {
        return this.vectorBoss;
    }

    public void setVectorTanque(Vector vectorBoss) {
        this.vectorBoss = vectorBoss;
    }

    public Vector getVectorTanqueBoss() {
        return this.vectorTanqueBoss;
    }

    public void setVectorTanqueBoss(Vector vectorTanqueBoss) {
        this.vectorTanqueBoss = vectorTanqueBoss;
    }

    public void display() {
        imageMode(CENTER);
        image(sprites[spriteIndex], this.posicion.x, this.posicion.y);
        fill(255); // Color del texto
        textSize(40); // Tamaño del texto
        text("Boss Life: " + this.cantVida, 50, 50); // Texto que aparecerá en pantalla
    }

    public void move() {
        this.posicion.y += this.velocidad.y * Time.getDeltaTime(frameRate);
        this.posicion.x = width / 2 + 230 * (cos(timer));

        // Alternar sprites cada 0.5 segundos
        if (millis() - lastSpriteChangeTime >= 500) {
            spriteIndex = (spriteIndex + 1) % sprites.length;
            lastSpriteChangeTime = millis();
        }
    }

    // Método para obtener el vector entre el enemigo y el jugador
    public void calcularVectorEnemigoJugador(GameObject player) {
        this.getVectorTanqueBoss().setOrigen(this.getPosicion());
        this.getVectorTanqueBoss().setDestino(PVector.sub(player.posicion, this.posicion).normalize());
    }
}
