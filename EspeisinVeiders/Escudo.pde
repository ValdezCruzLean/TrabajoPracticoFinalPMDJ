/*La clase Escudo extiende GameObject e implementa todos los metodos de IVisualizable.
Representa un escudo en el juego, que puede ser dañado y mostrado en la pantalla.*/
class Escudo extends GameObject implements IVisualizable {
   /*Variable entera que representa la cantidad de durabilidad del escudo.*/
    private int durabilidad;
  /*Variable Pimage que representa magen del escudo.*/
    private PImage imagen;
  /*Variable entera que representa el tamaño del Boss.*/  
    private float size;
// -----------Zona de Constructores----------------

 /*Constructor parametrizado*/
    public Escudo(PVector posicion) {
        this.posicion = posicion;
        this.size = 100; 
        this.durabilidad = 100; 
        this.imagen = loadImage("./escudo.png");

    }
/*Este metodo se encarga de mostrar la imagen del escudo en la pantalla.*/  
    public void display() {
      /*Se dibuja un elipse en la posicion actual del ataque con el tamaño especificado.*/
        fill(0,0);
        strokeWeight(0);       
      ellipse(this.posicion.x, this.posicion.y, size, size);
        image(imagen, this.posicion.x, this.posicion.y);
        imagen.resize(100, 80);
    }
  
 /*Metodo para sacar el escudo fuera de escena*/ 
  public void sacarEscudo(){
          posicion = new PVector(-200,this.posicion.y);

  }
/*Metodo que reduce la cantidad de durabilidad del escudo.*/
   public void reducirDurabilidad(int cantidad) {
        this.durabilidad -= cantidad;
  /*Si la vida del tanque es menor a 0, se establece a 0 para evitar valores negativos.*/      
        if (this.durabilidad < 0) {
            this.durabilidad = 0;
        }
    }
  //---- Metodos get y set los cuales devuelven o permiten modfificar los atributos de la durabilidad  
       public int getDurabilidad() {
        return this.durabilidad;
    }

    public void setDurabilidad(int durabilidad) {
        this.durabilidad = durabilidad;
    }
   
}
