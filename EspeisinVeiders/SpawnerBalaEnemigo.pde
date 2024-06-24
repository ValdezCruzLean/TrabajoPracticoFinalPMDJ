public class SpawnerBalasEnemigo {
    private int cantidadBalasEnemigo;
    private BalaEnemigo[] balasEnemigo;

    public SpawnerBalasEnemigo() {}

    public SpawnerBalasEnemigo(int cantidadBalasEnemigo) {
        this.cantidadBalasEnemigo = cantidadBalasEnemigo;
        balasEnemigo = new BalaEnemigo[cantidadBalasEnemigo];
    }

    public BalaEnemigo[] getBalasEnemigo() {
        return this.balasEnemigo;
    }

    public void setBalasEnemigo(BalaEnemigo[] balasEnemigo) {
        this.balasEnemigo = balasEnemigo;
    }

    public void actualizarBalasEnemigo() {
        for (BalaEnemigo b : balasEnemigo) {
            if (b != null) {
                b.move();
                b.display();
                //b.disparar(this.);
            }
        }
    }

    public void removeBalaEnemigo(BalaEnemigo balaEnemigo) {
        for (int i = 0; i < balasEnemigo.length; i++) {
            if (balasEnemigo[i] == balaEnemigo) {
                balasEnemigo[i] = null;
                break;
            }
        }
    }
}
