/*Es una clase que implementa una lista dinámica que puede crecer y reducir su tamaño automaticamente.*/
import java.util.ArrayList;
/*Esta clase proporciona metodos para manipular arreglos arrays como ordenar y buscar.*/
import java.util.Arrays;
/*Es una interfaz funcional que permite definir una forma de comparar dos objetos.*/
import java.util.Comparator;
/*Esta clase detecta colisiones entre objetos Alien y Bala.*/
class CollisionDetector {
  /*Atrubito que hace referencia a la clase que maneja las balas.*/
    private SpawnerBalas spawnerBalas;
      /*Atrubito que hace referencia a la clase que maneja los aliens.*/
    private SpawnerAlien spawnerAlien;
// -----------Zona de Constructores----------------
/*Constructor por defecto*/
  public CollisionDetector() {       
    }
    /*Constructor parametrizado*/
    public CollisionDetector(SpawnerBalas spawnerBalas, SpawnerAlien spawnerAlien) {
        this.spawnerBalas = spawnerBalas;
        this.spawnerAlien = spawnerAlien;
    }
/*Metodo que implementa la logica para detectar y manejar colisiones entre los aliens y las balas.*/
    void sweepAndPrune() {
      /*Se verifica si spawnerAlien o spawnerBalas son null y si es asi imprime unmensaje por consola*/
        if (spawnerAlien == null || spawnerBalas == null) {
            System.out.println("SpawnerBalas or SpawnerAlien is null");
            return;
        }
/*Se obtienen las listas de aliens y balas desde spawnerAlien y spawnerBalas respectivamente.*/
        ArrayList<Alien> aliens = spawnerAlien.getAliens();
        Bala[] balas = spawnerBalas.getBalas();
/*Verificacion si estas listas son null, si alguna lo es, se imprime un mensaje y se retorna.*/
        if (aliens == null) {
            System.out.println("Aliens list is null");
            return;
        }

        if (balas == null) {
            System.out.println("Balas array is null");
            return;
        }

        //System.out.println("Number of aliens: " + aliens.size());
        //System.out.println("Number of balas: " + balas.length);
/*Se eliminan las balas nulas del arreglo de balas utilizando stream y filter.*/
/*Convierte el arreglo balas en un stream.*/
        balas = Arrays.stream(balas)
        /*Filtra el stream los elementos no nulos.*/
                      .filter(b -> b != null)
       /*Convierte el Stream de nuevo en un arreglo*/
                      .toArray(Bala[]::new);

/*Se ordena la lista de aliens en funcion de su posicion x.*/
        aliens.sort(Comparator.comparing(a -> a.posicion.x));
/*se ordena el arreglo de balas en funcion de su posicion x, colocando los null al principio */
        Arrays.sort(balas, Comparator.nullsFirst(Comparator.comparing(b -> b.posicion.x)));

/*Se crean dos listas para almacenar los aliens y balas que deben ser eliminados después de detectar las colisiones.*/
        ArrayList<Alien> aliensToRemove = new ArrayList<>();
        ArrayList<Bala> balasToRemove = new ArrayList<>();
/*Se itera sobre cada alien y, dentro de esta iteracion, se itera sobre cada bala para verificar colisiones.*/
        for (Alien alien : aliens) {
            if (alien == null) {
                System.out.println("Alien is null");
                continue;
            }

            for (Bala bala : balas) {
                if (bala == null) {
                    System.out.println("Bala is null");
                    continue;
                }
   /*Si la posicion x de la bala es mayor que la posición x del alien mas su tamaño, se rompe el bucle interno,
       ya que las balas estan ordenadas y no es posible que las siguientes balas colisionen con este alien.*/
                if (bala.posicion.x > alien.posicion.x + alien.size) break;
/*Si la distancia entre el centro del alien y el centro de la bala es menor que la suma de sus radios (Hay colision),
de manera que se añade el alien y la bala a las listas de eliminacion.*/
                if (dist(alien.posicion.x, alien.posicion.y, bala.posicion.x, bala.posicion.y) < (alien.size / 2 + bala.size / 2)) {
                    fill(255, 0, 0);
                    ellipse(alien.posicion.x, alien.posicion.y, alien.size, alien.size);
                    ellipse(bala.posicion.x, bala.posicion.y, bala.size, bala.size);

                    aliensToRemove.add(alien);
                    balasToRemove.add(bala);
                }
            }
        }
/*Elimina todos los aliens en aliensToRemove de la lista original de aliens.*/
        aliens.removeAll(aliensToRemove);
/*Elimina cada bala en balasToRemove del arreglo de balas en spawnerBalas.*/
        for (Bala bala : balasToRemove) {
            spawnerBalas.removeBala(bala);
        }
    }
}
