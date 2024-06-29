/*La clase SpawnerBalas se encarga de manejar un conjunto de objetos BalasEnemigo, permitiendo su creacion, actualizacion y eliminacion.*/
public class SpawnerBalasEnemigo {
   /*Atributo tipo int que macena la cantidad de balasEnemigo que el spawner puede manejar.*/ 
    private int cantidadBalasEnemigo;
    /*Atributo que es un arreglo de objetos BalaEnemigo, que contiene todas las balas gestionadas por el spawner.*/    
    private BalaEnemigo[] balasEnemigo;
// -----------Zona de Constructores----------------
/*Constructor por defecto*/
    public SpawnerBalasEnemigo() {}
 /*Constructor parametrizado*/
    public SpawnerBalasEnemigo(int cantidadBalasEnemigo) {
        this.cantidadBalasEnemigo = cantidadBalasEnemigo;
        balasEnemigo = new BalaEnemigo[cantidadBalasEnemigo];
    }
//-------Metodos get y set los cuales devuelven o permiten modificar el arreglo de balasenemigo
    public BalaEnemigo[] getBalasEnemigo() {
        return this.balasEnemigo;
    }
 public void setBalasEnemigo(BalaEnemigo[] balasEnemigo) {
        this.balasEnemigo = balasEnemigo;
    }
/*Metodo para actualizar las balas recorriendo el arreglo de balas.*/
  public void actualizarBalasEnemigo(Tanque tanque) {
        for (BalaEnemigo b : balasEnemigo) {
            if (b != null) {
                b.move();
                b.display();
                b.danarTanque(tanque, this); // Verificar colisión y dañar tanque si es necesario
            }
        }
    }
/*Metodo para remover balaenemigo el cual recorre el arreglo de balas.*/
    public void removeBalaEnemigo(BalaEnemigo balaEnemigo) {
     /*Si se encuentra la Balasenemigo especificada, la elimina del arreglo asignando null en su lugar.*/  
        for (int i = 0; i < balasEnemigo.length; i++) {
            if (balasEnemigo[i] == balaEnemigo) {
                balasEnemigo[i] = null;
            /*Rompe el ciclo una vez que la Bala ha sido eliminada.*/      
                break;
            }
        }
    }
}
