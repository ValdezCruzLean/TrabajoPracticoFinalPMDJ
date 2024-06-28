class Boss extends GameObject implements IVisualizable {

    private Vector vectorBoss;
    private Vector vectorTanqueBoss;
    private int cantVida;

    private PImage spriteSheet;
    private PImage sprite1; // Primer sprite
    private PImage sprite2; // Segundo sprite
    private PVector velocidad;
    private boolean isSprite1; // Booleano para alternar entre los sprites
    private int lastSpriteChangeTime; // Tiempo del último cambio de sprite
    private float anchoCollider;
    private float altoCollider;
    private PVector posCollider;
    
    public Boss() {}

    public Boss(PVector posicion) {
        this.posicion = posicion;
        this.velocidad = new PVector(1, height / 100);
        this.spriteSheet = loadImage("Boss.png"); // Carga la imagen que contiene los sprites
        this.sprite1 = spriteSheet.get(0, 0, 340, spriteSheet.height); // Sprite desde 0 a 340
        this.sprite2 = spriteSheet.get(345, 0, 338, spriteSheet.height); // Sprite desde 345 a 683
        this.vectorBoss = new Vector(this.posicion, new PVector(1, 0));
        this.vectorTanqueBoss = new Vector();
        this.cantVida = 1000; // Asigna la cantidad de vida del jugador por defecto
        this.isSprite1 = true; // Inicializa usando el primer sprite
        this.lastSpriteChangeTime = millis(); // Inicializa el tiempo del último cambio de sprite
        this.anchoCollider=350;
        this.altoCollider=150;
        this.posCollider=new PVector(this.posicion.x,this.posicion.y);
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
        rectMode(CENTER);
        fill(0,0);
        rect(this.posCollider.x,this.posCollider.y,this.anchoCollider,this.altoCollider);
        imageMode(CENTER);
        if (isSprite1) {
            image(sprite1, this.posicion.x, this.posicion.y);
        } else {
            image(sprite2, this.posicion.x, this.posicion.y);
        }
        fill(#95090E); // Color del texto
        textSize(35); // Tamaño del texto
        text("Boss Life: " + this.cantVida, 550, 105); // Texto que aparecerá en pantalla
    }

    public void disparar(SpawnerBalasEnemigo spawnerBalaEnemigo) {
        PVector posicionBoss = new PVector(this.posicion.x, this.posicion.y);
        BalaEnemigo unaBalaEnemigo = new BalaEnemigo(posicionBoss);
        BalaEnemigo[] balasEnemigo = spawnerBalaEnemigo.getBalasEnemigo();
        for (int i = 0; i < balasEnemigo.length; i++) {
            if (balasEnemigo[i] == null) {
                balasEnemigo[i] = unaBalaEnemigo;
                break;
            }
        }
        spawnerBalaEnemigo.setBalasEnemigo(balasEnemigo);
    }

    public void move() {
        this.posicion.y += this.velocidad.y * Time.getDeltaTime(frameRate);
        this.posicion.x = width / 2 + 230 * (cos(timer));
        
        this.posCollider.y += this.velocidad.y * Time.getDeltaTime(frameRate);
        this.posCollider.x = width / 2 + 230 * (cos(timer));
        
        // Alternar sprites cada 0.5 segundos
        if (millis() - lastSpriteChangeTime >= 500) {
            isSprite1 = !isSprite1;
            lastSpriteChangeTime = millis();
        }
    }

    // Método para obtener el vector entre el enemigo y el jugador
    public void calcularVectorEnemigoJugador(GameObject player) {
        this.getVectorTanqueBoss().setOrigen(this.getPosicion());
        this.getVectorTanqueBoss().setDestino(PVector.sub(player.posicion, this.posicion).normalize());
    }
    
    public void reducirVida(int cantidad) {
        this.cantVida -= cantidad;
        if (this.cantVida < 0) {
            this.cantVida = 0;
        }
    }
    
    public PVector getPosCollider() {
        return this.posCollider;
    }

    public void setPosCollider(PVector posCollider) {
        this.posCollider = posCollider;
    }

    public float getAnchoCollider() {
        return this.anchoCollider;
    }

    public float getAltoCollider() {
        return this.altoCollider;
    }

    public int getCantVida() {
        return this.cantVida;
    }

    public void setCantVida(int cantVida) {
        this.cantVida = cantVida;
    }
}
