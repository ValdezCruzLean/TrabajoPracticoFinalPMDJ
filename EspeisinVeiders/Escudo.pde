class Escudo extends GameObject implements IVisualizable {
    private int ancho;
    private int alto;
    private int durabilidad;
    private PImage imagen;

    public Escudo(PVector posicion) {
        this.posicion = posicion;
        this.ancho = 80; // Ancho del escudo
        this.alto = 40; // Alto del escudo
        this.durabilidad = 5; // Número de impactos que puede recibir antes de ser destruido
        this.imagen = loadImage("./escudo.png");

    }

    public void display() {
        fill(0,0);
        strokeWeight(0);
        rectMode(CENTER);
        rect(posicion.x, posicion.y, ancho, alto);
        image(imagen, this.posicion.x, this.posicion.y);
        imagen.resize(100, 80);
    }
     public void displayCenter(){
    imageMode(CENTER);
   image(this.imagen, 0, 0, 100, 60);
  }

    public void hit() {
        durabilidad--;
    }

    public boolean isDestroyed() {
        return durabilidad <= 0;
    }
}
