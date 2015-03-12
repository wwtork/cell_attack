/**
 * Created with IntelliJ IDEA.
 * User: ivan
 * Date: 29.05.13
 * Time: 16:30
 * To change this template use File | Settings | File Templates.
 */
package classes {
import flash.display.Sprite;

public class Wall extends Sprite {
    public function Wall(w:int,dx:int,dy:int) {
        this.graphics.lineStyle(1,0);
        this.graphics.beginFill(0,1);
        //trace(parseInt(w));
        switch(w){
            case 0:
                this.graphics.drawRect(0,0,50,10);
                //this.graphics.drawRect(0,-100,50,10);
                //this.graphics.drawRect(0,0,50,10);
                this.x = dx - 25;
                this.y = dy - 25;
                break;
            case 2:
                this.graphics.drawRect(0,0,50,10);
                this.x = dx - 25;
                this.y = dy + 15;
                break;
            case 3:
                this.graphics.drawRect(0,0,10,50);
                this.x = dx - 25;
                this.y = dy - 25;
                break;
            case 1:
                this.graphics.drawRect(0,0,10,50);
                this.x = dx + 15;
                this.y = dy - 25;
                break;
        }
        this.graphics.endFill();
        //wall.x = _cell*this.w + this.w/2;
        //wall.y = (_line - lev*10)*h + h/2;
        //grid.addElem(wall, lev);

    }
}
}
