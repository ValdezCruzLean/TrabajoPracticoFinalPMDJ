import java.util.Arrays;
import java.util.Comparator;
class CollisionDetector{
  private SpawnerBalas spawnerBalas;
  private SpawnerAlien spawnerAlien;
  
  /*public CollisionDetector() {
  }*/
  public CollisionDetector(SpawnerBalas spawnerBalas, SpawnerAlien spawnerAlien) {
    this.spawnerBalas = spawnerBalas;
    this.spawnerAlien = spawnerAlien;
  }

  void sweepAndPrune() {
    
    if (spawnerAlien == null || spawnerBalas == null) {
            System.out.println("SpawnerBalas or SpawnerAlien is null");
            return; // Si alguno es null, salir del método para evitar NullPointerException
        }
    
    ArrayList<Alien> aliens = spawnerAlien.getAliens();
    Bala[] balas = spawnerBalas.getBalas();
    if (aliens == null) {
      System.out.println("Aliens list is null");
      return;
    }
    
    if (balas == null) {
      System.out.println("Balas array is null");
      return;
    }
    System.out.println("Number of aliens: " + aliens.size());
    System.out.println("Number of balas: " + balas.length);
    
    balas = Arrays.stream(balas)
                  .filter(b -> b != null)
                  .toArray(Bala[]::new);
  // Ordenar enemigos y balas por la coordenada x
   aliens.sort((a1, a2) -> Float.compare(a1.posicion.x, a2.posicion.x));
  //balas.sort((b1, b2) -> Float.compare(b.x, b.x));
  // Arrays.sort(balas, Comparator.comparing(b -> b.posicion.x));
  Arrays.sort(balas, Comparator.nullsFirst(Comparator.comparing(b -> b.posicion.x)));
  // Verificar colisiones entre enemigos y balas
  for (Alien alien : aliens) {
    if (alien == null) {
        System.out.println("Alien is null");
        continue; // Si el alien es null, continuar con el siguiente
      }
    for (Bala bala : balas) {
      if (bala == null) {
          System.out.println("Bala is null");
          continue; // Si la bala es null, continuar con la siguiente
        }
        System.out.println("Checking collision between Alien at " + alien.posicion + " and Bala at " + bala.posicion);
        
        if (bala.posicion.x > alien.posicion.x + alien.size) break; // No puede haber colisión más allá de esto
  
        // Verificación precisa
        if (dist(alien.posicion.x, alien.posicion.y, bala.posicion.x, bala.posicion.y) < (alien.size / 2 + bala.size / 2)) {
          // Colisión detectada
          fill(255, 0, 0);
          ellipse(alien.posicion.x, alien.posicion.y, alien.size, alien.size);
          ellipse(bala.posicion.x, bala.posicion.y, bala.size, bala.size);
          bala.setPosicion(new PVector(-1000,-1000));
          alien.setPosicion(new PVector(-1000,-1000));
        }
      
    }
  }
}


}
