/**
   La clase SpawnerBossAttack se encarga de crear y administrar el conjunto de objetos BossAttack
*/   
class SpawnerBossAttack {
  /* Declara un arreglo de objetos BossAttack llamados "bossAttacks" y almacena dichos objetos generados por el spawner*/
  private BossAttack [] bossAttacks; 
  /*Declara una variable entera que representa el número de ataques que seran generados*/
  private int cantidadAtaques;  
  //---------------Zona de constructores----------------
  
  
 public SpawnerBossAttack(){
 }
/**
   Constructor parametrizado de SpawnerBossAttack que permite asignar la cantidad de ataques del boss*/
   /*Se asigna el valor del parametro "cantidadAtaques"*/
   /*Se crea un arreglo de objetos "BossAttack" con el tamaño especificado por "cantidadAtaques"*/
  public SpawnerBossAttack(int cantidadAtaques) {
    this.cantidadAtaques = cantidadAtaques;
    bossAttacks = new BossAttack[cantidadAtaques];
    
  }
//-----------------Zona de metodos---------------------
/**
  Define el metodo para generar ataques y almacenarlos en el arreglo "bossAttacks"
*/
  public void spawnAttacks() {
    /*Establece un bucle for que se ejecuta desde 0 hasta la cantidad de ataques */
    for (int i = 0; i < cantidadAtaques; i++) {
    /*En cada iteracion del bucle, se crea un nuevo objeto "BossAttack" y lo asigna a la posicion i del arreglo*/  
      bossAttacks[i] = new BossAttack();
    }
  }

/* Se define el metodo que se encarga de actualizar y mostrar los objetos "BossAttack" generados*/
 public void actualizarBalasEnemigo(Tanque tanque) {
        for (BossAttack b : bossAttacks) {
            if (b != null) {
                b.move();
                b.display();
                b.danarTanque(tanque); 
            }
        }
    }

 
}
