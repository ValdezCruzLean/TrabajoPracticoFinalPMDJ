public class BalaEnemigo extends GameObject implements IVisualizable {
    private PVector direccion;
    private float velocidad;
    private PVector velocidadPvector;
    private float size;

    public BalaEnemigo() {}

    public BalaEnemigo(PVector posicion) {
        this.posicion = posicion;
        this.velocidad = 30;
        this.velocidadPvector = new PVector(0, 500);
        this.size = 20;
    }

    public void move() {
        this.posicion.y += this.velocidadPvector.y * Time.getDeltaTime(frameRate);
    }

    public void display() {
        fill(#F7E111);
        ellipse(posicion.x, posicion.y, size, size);
    }

    public void danarTanque(Tanque tanque, SpawnerBalasEnemigo spawner) {
        if (dist(this.posicion.x, this.posicion.y, tanque.getPosicion().x, tanque.getPosicion().y) < (this.size/2 + tanque.getSize()/2)) {
            println("Hay colisión con el tanque");
            tanque.reducirVida(10); // Reduce la vida del tanque
            spawner.removeBalaEnemigo(this); // Remueve la bala enemiga
        }
    }
}
