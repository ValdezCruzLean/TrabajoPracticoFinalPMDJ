/**
   La clase SpawnerLapiz se encarga de crear y administrar el conjunto de objetos "Lapiz"
*/   
class SpawnerBossAttack {
  private BossAttack [] bossAttacks; // Declara un arreglo de objetos "Lapiz" llamados "lapices" y almacena dichos objetos generados por el spawner
  private int cantidadLapices; //Declara una variable entera que representa el número de lapices que seran generados 
  //---------------Zona de constructores----------------
  
  
 public SpawnerBossAttack(){
 }
/**
   Constructor parametrizado de SpawnerLapiz que permite asignar la cantidad de lapices
*/
  public SpawnerBossAttack(int cantidadLapices) {
    this.cantidadLapices = cantidadLapices;//Asigna el valor del parametro "cantidadlapices" a la variable "cantidadlapices del objeto"
    bossAttacks = new BossAttack[cantidadLapices];// Crea un arreglo de objetos "Lapiz" con el tamaño especificado por "cantidadLapices"
    
  }
//-----------------Zona de metodos---------------------
/**
  Define el metodo para generar lapices y almacenarlos en el arreglo "lapices"
*/
  public void spawnAttacks() {
    for (int i = 0; i < cantidadLapices; i++) {//Establece un bucle for que se ejecuta desde 0 hasta la cantidad de lapices 
      bossAttacks[i] = new BossAttack();//En cada iteracion del bucle, se crea un nuevo objeto "Lapiz" y lo asigna a la posicion i del arreglo
    }
  }
/**
  Define el metodo que se encarga de actualizar y mostrar los objetos "Lapiz" generados
*/
 public void actualizarBalasEnemigo(Tanque tanque) {
        for (BossAttack b : bossAttacks) {
            if (b != null) {
                b.move();
                b.display();
                b.danarTanque(tanque, this); // Verificar colisión y dañar tanque si es necesario
            }
        }
    }

    public void removeBalaEnemigo(BossAttack bossAttack) {
        for (int i = 0; i < bossAttacks.length; i++) {
            if (bossAttacks[i] == bossAttack) {
                bossAttacks[i] = null;
                break;
            }
        }
    } 
}
