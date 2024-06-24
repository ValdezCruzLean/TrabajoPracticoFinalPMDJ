public class SpawnerBalas {
    private int cantidadBalas;
    private Bala[] balas;

    public SpawnerBalas() {}

    public SpawnerBalas(int cantidadBalas) {
        this.cantidadBalas = cantidadBalas;
        balas = new Bala[cantidadBalas];
    }

    public Bala[] getBalas() {
        return this.balas;
    }

    public void setBalas(Bala[] balas) {
        this.balas = balas;
    }

    public void actualizarBalas() {
        for (Bala b : balas) {
            if (b != null) {
                b.move();
                b.display();
                b.danarBoss(boss);
            }
        }
    }

    public void removeBala(Bala bala) {
        for (int i = 0; i < balas.length; i++) {
            if (balas[i] == bala) {
                balas[i] = null;
                break;
            }
        }
    }
}
