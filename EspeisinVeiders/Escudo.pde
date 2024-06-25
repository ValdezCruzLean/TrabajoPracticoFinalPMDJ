class Escudo extends GameObject implements IVisualizable {
    private int ancho;
    private int alto;
    private int durabilidad;
    private PImage imagen;
    private float size;

    public Escudo(PVector posicion) {
        this.posicion = posicion;
        this.size = 100; 
        //this.ancho =100; // Ancho del escudo
       // this.alto = 80; // Alto del escudo
        this.durabilidad = 5; // Número de impactos que puede recibir antes de ser destruido
        this.imagen = loadImage("./escudo.png");

    }

    public void display() {
        fill(0,0);
        strokeWeight(0);
       // rectMode(CENTER);
      //  rect(posicion.x, posicion.y, ancho, alto);
      ellipse(this.posicion.x, this.posicion.y, size, size);
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
    public void removeEscudo(Escudo escudo) {
        for (int i = 0; i < escudos.size(); i++) {
            if (escudos.get(i) == escudo) {
                escudos.remove(i);
                break;
            }
        }
    }
}
