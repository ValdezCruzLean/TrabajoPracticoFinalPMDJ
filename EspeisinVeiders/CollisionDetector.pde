import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;

class CollisionDetector {
    private SpawnerBalas spawnerBalas;
    private SpawnerAlien spawnerAlien;

    public CollisionDetector(SpawnerBalas spawnerBalas, SpawnerAlien spawnerAlien) {
        this.spawnerBalas = spawnerBalas;
        this.spawnerAlien = spawnerAlien;
    }

    void sweepAndPrune() {
        if (spawnerAlien == null || spawnerBalas == null) {
            System.out.println("SpawnerBalas or SpawnerAlien is null");
            return;
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

        aliens.sort(Comparator.comparing(a -> a.posicion.x));
        Arrays.sort(balas, Comparator.nullsFirst(Comparator.comparing(b -> b.posicion.x)));

        ArrayList<Alien> aliensToRemove = new ArrayList<>();
        ArrayList<Bala> balasToRemove = new ArrayList<>();

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

                if (bala.posicion.x > alien.posicion.x + alien.size) break;

                if (dist(alien.posicion.x, alien.posicion.y, bala.posicion.x, bala.posicion.y) < (alien.size / 2 + bala.size / 2)) {
                    fill(255, 0, 0);
                    ellipse(alien.posicion.x, alien.posicion.y, alien.size, alien.size);
                    ellipse(bala.posicion.x, bala.posicion.y, bala.size, bala.size);

                    aliensToRemove.add(alien);
                    balasToRemove.add(bala);
                }
            }
        }

        aliens.removeAll(aliensToRemove);
        for (Bala bala : balasToRemove) {
            spawnerBalas.removeBala(bala);
        }
    }
}
