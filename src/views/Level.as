/**
 * Created with IntelliJ IDEA.
 * User: ivan
 * Date: 29.05.13
 * Time: 15:57
 * To change this template use File | Settings | File Templates.
 */
package views {
import classes.Sector;

import flash.display.Sprite;

public class Level extends Sprite{
    public var sectors:Array = [];
    public function Level(num:int,sec_count:int,grid:Grid) {

        var i:Number;
        var cell:Number = 0;
        var sec:Sector;
        var line:Number = -1;
        var closed:Boolean = false;
        var min:Number;
        var max:Number;
        var climb:Boolean;
        var conf:String;
        this.y = -num*100;

        min = num*sec_count;
        max = (num+1)*sec_count;
        for(i = min; i < max;i++){
            cell = i%20;
            if (cell == 0) line++;

            conf = grid.field.config.level_conf[num][line][cell];
            if(!(sectors[line] is Array)) sectors[line] = [];
            if(!(grid.sectors[line+num*20] is Array)) grid.sectors[line+num*20] = [];
            if(conf != '0'){

                closed = false;//(Math.random() > 0.7);
                climb = ((conf == 'u')||(conf == 'd'));
                sec = new Sector(line+num*20,cell,closed,grid, climb, num);

                var wall_num:Array;
                sec.walls = [false,false,false,false];
                if(parseInt(conf) > 0){

                    wall_num = conf.split('');
                    for each(var w:String in wall_num){
                        sec.walls[parseInt(w)-1] = true;
                    }
                }

                sec.add_wall();
                this.addChild(sec);
                sec.set_coords(num);
                sectors[line][cell] = sec;
                grid.sectors[line+num*20][cell] = sec;
            }
            else{
                sectors[line][cell] = null;
                grid.sectors[line+num*20][cell] = null;
            }

        }
    }
}
}
