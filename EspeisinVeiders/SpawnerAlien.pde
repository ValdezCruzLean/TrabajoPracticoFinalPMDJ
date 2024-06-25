class SpawnerAlien {
    private ArrayList<Alien> aliens = new ArrayList<Alien>();
    private int filas; //<>//
    private int columnas;
    private float anchoAlien;
    private float altoAlien;
    private float espacioX;
    private float espacioY;

    public SpawnerAlien() {
        this.filas =6;
        this.columnas = 8 ;
        this.anchoAlien = 60;
        this.altoAlien = 30;
        this.espacioX = 10;
        this.espacioY = 10;
    }

    public void spawnAliens() {
        for (int i = 0; i < filas; i++) {
            for (int j = 0; j < columnas; j++) {
                float posX = j * (anchoAlien + espacioX) + anchoAlien / 2;
                float posY = i * (altoAlien + espacioY) + altoAlien / 2;
                aliens.add(new Alien(new PVector(posX, posY)));
            }
        }
    }

    public void actualizarAliens() {
        for (Alien a : aliens) {
            a.move();
            a.display();
        }
    }

    public ArrayList<Alien> getAliens() {
        if (aliens == null) {
            aliens = new ArrayList<Alien>();
        }
        return aliens;
    }

    public void setAliens(ArrayList<Alien> aliens) {
        this.aliens = aliens;
    }

    public boolean areAllAliensDead() {
        return aliens.isEmpty();
    }
}
