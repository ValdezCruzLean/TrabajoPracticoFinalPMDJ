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
        this.durabilidad = 100; // Número de impactos que puede recibir antes de ser destruido
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
  
  
  public void sacarEscudo(){
          posicion = new PVector(-200,this.posicion.y);

  }

   public void reducirDurabilidad(int cantidad) {
        this.durabilidad -= cantidad;
        if (this.durabilidad < 0) {
            this.durabilidad = 0;
        }
    }
       public int getDurabilidad() {
        return this.durabilidad;
    }

    public void setDurabilidad(int durabilidad) {
        this.durabilidad = durabilidad;
    }
   
}
