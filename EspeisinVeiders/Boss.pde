/*Clase Boss extiende de GameObject e implementa todos los metodos de IVisualizable.*/
class Boss extends GameObject implements IVisualizable {
  /*Vector que representa la direccion del Boss.*/
    private Vector vectorBoss;
   /*Vector que apunta hacia el tanque.*/
    private Vector vectorTanqueBoss;
   /*Variable entera que representa la cantidad de vida del Boss.*/
    private int cantVida;
  /*Atributo Pimagen que contiene todos los frames de la animacion del alien.*/
    private PImage spriteSheet;
  /*Atributo Pimagen que representa el primer sprite del boss.*/
    private PImage sprite1; 
  /*Atributo Pimagen que representa el segundo sprite del boss.*/
    private PImage sprite2; 
  /*Atributo booleano para alternar entre los sprites.*/  
    private boolean isSprite1; 
  /*Atributo tipo entero que representa el tiempo del último cambio de sprite.*/  
    private int lastSpriteChangeTime; 
  /*Atributo tipo float que representa el ancho del colisionador del boss.*/  
    private float anchoCollider;
  /*Atributo tipo float que representa el ancho del colisionador del boss.*/
    private float altoCollider;
  /*Atributo tipo Pvector que representa la cosicion del colisionador del boss.*/
    private PVector posCollider;
   
    // -----------Zona de Constructores----------------
   /*Constructor por defecto*/
    public Boss() {}
  /*Constructor parametrizado*/
    public Boss(PVector posicion) {
        this.posicion = posicion;
        this.velocidad = new PVector(1, height / 10);
        this.spriteSheet = loadImage("Boss.png"); 
        this.sprite1 = spriteSheet.get(0, 0, 340, spriteSheet.height); 
        this.sprite2 = spriteSheet.get(345, 0, 338, spriteSheet.height); 
        this.vectorBoss = new Vector(this.posicion, new PVector(1, 0));
        this.vectorTanqueBoss = new Vector();
        this.cantVida = 1000; 
        this.isSprite1 = true; 
        this.lastSpriteChangeTime = millis(); 
        this.anchoCollider=350;
        this.altoCollider=150;
        this.posCollider=new PVector(this.posicion.x,this.posicion.y);
    }
//-------Metodos get y set los cuales devuelven o permiten modfificar los atributos del boss
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
/*Metodo encargado de la representacion visual del Boss en la pantalla.*/
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
        text("Boss Life: " + this.cantVida, 600, 175); // Texto que aparecerá en pantalla
    }
  /*Metodo disparar que permite al boss disparar al jugador  */
    public void disparar(SpawnerBalasEnemigo spawnerBalaEnemigo) {
      /*Se crea una nueva BalaEnemigo en la posicion del boss.*/
        PVector posicionBoss = new PVector(this.posicion.x, this.posicion.y);
        BalaEnemigo unaBalaEnemigo = new BalaEnemigo(posicionBoss);
        /*Añade la bala al arreglo de balas en el SpawnerBalasEnemigo*/
        BalaEnemigo[] balasEnemigo = spawnerBalaEnemigo.getBalasEnemigo();
        for (int i = 0; i < balasEnemigo.length; i++) {
            if (balasEnemigo[i] == null) {
                balasEnemigo[i] = unaBalaEnemigo;
                break;
            }
        }
        spawnerBalaEnemigo.setBalasEnemigo(balasEnemigo);
    }
  /*Metodo que se encarga de mover el Boss en el juego de manera oscilante */
    public void move() {
      /*La posicion x e y del boss se actualiza continuamente.*/
        this.posicion.y += this.velocidad.y * Time.getDeltaTime(frameRate);
        this.posicion.x = 550 + 400 * (cos(timer));
        if(this.posicion.y > 100){
       this.velocidad = new PVector(1, height / 90);

        }
        this.posCollider.y += this.velocidad.y * Time.getDeltaTime(frameRate);
        this.posCollider.x = 550 + 400 * (cos(timer));
        
        /* Alternar sprites cada 0.5 segundos*/
        if (millis() - lastSpriteChangeTime >= 500) {
            isSprite1 = !isSprite1;
            lastSpriteChangeTime = millis();
        }
    }

    /*Este metodo calcularVectorEnemigoJugador se utiliza para obtener el vector entre el enemigo y el jugador*/
    public void calcularVectorEnemigoJugador(GameObject player) {
      /*Se establece el origen del vector como la posición del boss*/
        this.getVectorTanqueBoss().setOrigen(this.getPosicion());
      /*Se establece que el destino del vector como la direccion hacia el jugador.*/  
        this.getVectorTanqueBoss().setDestino(PVector.sub(player.posicion, this.posicion).normalize());
    }
    /*Metodo que se encarga de disminuir la cantVida en la cantidad especificada.*/
    public void reducirVida(int cantidad) {
        this.cantVida -= cantidad;
        if (this.cantVida < 0) {
            this.cantVida = 0;
        }
    }
    
 
}
