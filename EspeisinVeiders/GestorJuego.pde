/**
  La clase GestorJuego se encarga de administrar el juego.
 */
class GestorJuego {
  /** Variable para almacenar el nivel actual del juego*/
  private int nivelJuego; 
  /** Variable para almacenar el escenario del juego*/
  private Escenario escenario; 
//-------Zona de contructores--------------  

  /**
    Constructor por defecto de GestorJuego.
    Establece el nivel del juego como pantalla inicial por defecto.
   */
  public GestorJuego() {
    this.nivelJuego = MaquinaEstados.PANTALLA_INICIANDO;//Asigna como nivel juego PANTALLA_INICIANDO
  }
//--------Zona de Metodos-------------
  /**
    Genera un nuevo escenario y lo muestra en pantalla.
    El escenario se crea con el nivel actual del juego.
   */
  public void generarEscenario() {
    this.escenario = new Escenario(this.nivelJuego);//Asigna que escenario se va a crear dependiendo el nivel del juego
    this.escenario.display();//Visiualiza el escenario
  }



  /**
    Asigna el nivel del juego con el valor proporcionado.
   */
  public void setNivelJuego(int nivelJuego) {
    this.nivelJuego = nivelJuego;
  }
  
    /**
    Obtiene el nivel actual del juego.
   */ public int getNivelJuego() {
    return this.nivelJuego;
  }
}
