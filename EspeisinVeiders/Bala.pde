public class Bala extends GameObject implements IVisualizable {
    private PVector direccion;
    private float velocidad;
    private PVector velocidadPvector;
    private float size;
    private boolean bossDetected; // Nueva variable para detectar al Boss

    public Bala() {}

    public Bala(PVector posicion, PVector direccion) {
        this.posicion = posicion;
        this.velocidad = 30;
        this.direccion = direccion;
        this.velocidadPvector = new PVector(0, -500);
        this.size = 10;
        this.bossDetected = false; // Inicialmente el Boss no está detectado
    }

    public void detectBoss(boolean detected) {
        this.bossDetected = detected; // Método para actualizar el estado del Boss
    }

    public void move() {
        if (bossDetected) {
            this.setPosicion(this.getPosicion().add(this.direccion.normalize().mult(velocidad)));
        } else {
            this.posicion.y += this.velocidadPvector.y * Time.getDeltaTime(frameRate);
        }
    }

    public void display() {
        fill(#F7E111);
        ellipse(posicion.x, posicion.y, 10, 10);
    }
}
