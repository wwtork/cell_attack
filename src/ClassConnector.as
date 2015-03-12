/**
 * Created by IntelliJ IDEA.
 * User: root
 * Date: 04.02.12
 * Time: 1:11
 * To change this template use File | Settings | File Templates.
 */
package {
import classes.Person;

import views.Grid;

public class ClassConnector {
    public function ClassConnector() {

    }
    public function connect_persons_w_sectors(grid:Grid,person:Person):Boolean{
        var l:Number = person.pos['line'];
        var c:Number = person.pos['cell'];

        var b:Boolean = (grid.sectors[l])&&(grid.sectors[l][c]);

        if(b){
                grid.sectors[l][c].update_visitors(person, true);
                //trace(grid.sectors[l][c].x);
                person.x = grid.sectors[l][c].x;
                person.y = grid.sectors[l][c].y;
        }
        return b;
    }
}
}
