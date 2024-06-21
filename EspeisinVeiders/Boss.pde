class Boss extends GameObject implements IVisualizable{


//private PVector velocidad;
private PImage imagen;

public Boss (){}

public Boss (PVector posicion) {
this.posicion= posicion;
this.velocidad= new PVector (1,height/20);
this.imagen = loadImage("Boss.png");
this.imagen.resize (300,300);
}
public void display() {
imageMode (CENTER);
image (imagen, this.posicion.x,this.posicion.y);
}
public void move() {
this.posicion.y+=this.velocidad.y*Time.getDeltaTime (frameRate);
//this.posicion.x width/2+ width/2(sin(timer));
//this.posicion.y+=(sin(timer));
this.posicion.x = width/2+230 *(cos(timer));
}
}
