/*La clase SpawnerBalas se encarga de manejar un conjunto de objetos Bala, permitiendo su creacion, actualizacion y eliminacion.*/
public class SpawnerBalas {
  /*Atributo tipo int que macena la cantidad de balas que el spawner puede manejar.*/
    private int cantidadBalas;
  /*Atributo que es un arreglo de objetos Bala, que contiene todas las balas gestionadas por el spawner.*/  
    private Bala[] balas;
// -----------Zona de Constructores----------------
/*Constructor por defecto*/
    public SpawnerBalas() {}
 /*Constructor parametrizado*/
    public SpawnerBalas(int cantidadBalas) {
        this.cantidadBalas = cantidadBalas;
        balas = new Bala[cantidadBalas];
    }
//-------Metodos get y set los cuales devuelven o permiteen modificar el arreglo de balas
    public Bala[] getBalas() {
        return this.balas;
    }

    public void setBalas(Bala[] balas) {
        this.balas = balas;
    }
/*Metodo para actualizar las balas recorriendo el arreglo de balas.*/
    public void actualizarBalas() {
        for (Bala b : balas) {
            if (b != null) {
                b.move();
                b.display();
            }
        }
    }
/*Metodo para remover bala el cual recorre el arreglo de balas.*/
    public void removeBala(Bala bala) {
      /*Si se encuentra la Bala especificada, la elimina del arreglo asignando null en su lugar.*/
        for (int i = 0; i < balas.length; i++) {
            if (balas[i] == bala) {
                balas[i] = null;
      /*Rompe el ciclo una vez que la Bala ha sido eliminada.*/          
                break;
            }
        }
    }
}
