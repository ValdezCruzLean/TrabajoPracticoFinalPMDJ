/*Clase SpawnerAlien que se encarga de gestionar la creacion y actualizacion de objetos Alien en el juego. */ //<>// //<>//
class SpawnerAlien {
  /*Atributo que representa una lista de aliens que se gestionan en el juego.*/
    private ArrayList<Alien> aliens = new ArrayList<Alien>();
    /*Atributo entero que representa el numero de filas de los aliens.*/
    private int filas;
    /*Atributo entero que representa el numero de columnas de los aliens.*/
    private int columnas;
    /*Atributo float que representa el ancho de cada alien.*/   
    private float anchoAlien;
    /*Atributo float que representa el alto de cada alien.*/   
    private float altoAlien;
    /*Atributo float que representa sspacio horizontal entre aliens.*/   
    private float espacioX;
    /*Atributo float que representa sspacio vertical entre aliens.*/   
    private float espacioY;
 // -----------Zona de Constructores----------------
/*Constructor por defecto*/
    public SpawnerAlien() {
        this.filas =5;
        this.columnas = 8 ;
        this.anchoAlien = 60;
        this.altoAlien = 30;
        this.espacioX = 10;
        this.espacioY = 10;
    }
/*Metodo que crea aliens y los agrega a la lista aliens*/
    public void spawnAliens() {
      /*Se itera a travss del número de filas y columnas.*/
        for (int i = 0; i < filas; i++) {
            for (int j = 0; j < columnas; j++) {
      /*posX y posY calculan las posiciones de cada alien, considerando el tamaño de los aliens y el espacio entre ellos.*/
                float posX = j * (anchoAlien + espacioX) + anchoAlien / 2 +190;
                float posY = i * (altoAlien + espacioY) + altoAlien / 2;
          /*Se crea un nuevo objeto Alien en cada posicion calculada y se agrega a la lista aliens.*/      
                aliens.add(new Alien(new PVector(posX, posY)));
            }
        }
    }
/*Metodo actualiza cada alien en la lista aliens*/
    public void actualizarAliens() {
      /*Recorre cada objeto Alien en la lista.*/
        for (Alien a : aliens) {
      /*Llama a los metodos display y move de cada Alien para actualizar su visualización y movimiento.*/    
          a.display();
            a.move();
            //a.display();
        }
    }
/*Metodo getAliensdevuelve la lista de aliens. Si la lista es null, se inicializa como una nueva ArrayList<Alien>.*/
    public ArrayList<Alien> getAliens() {
        if (aliens == null) {
            aliens = new ArrayList<Alien>();
        }
        return aliens;
    }
/*Metodo setAliens(ArrayList<Alien> aliens)establece una nueva lista de aliens.*/
    public void setAliens(ArrayList<Alien> aliens) {
        this.aliens = aliens;
    }
/*Metodo areAllAliensDead()* verifica si todos los aliens han sido eliminados, devolviendo true si la lista de aliens esta vacía.*/
    public boolean areAllAliensDead() {
        return aliens.isEmpty();
    }
}
