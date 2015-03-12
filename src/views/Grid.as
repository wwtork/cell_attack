/**
 * Created by IntelliJ IDEA.
 * User: root
 * Date: 03.02.12
 * Time: 21:48
 * To change this template use File | Settings | File Templates.
 */
package views {
import classes.Person;
import classes.Sector;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class Grid extends Sprite{
    public var line_len:Number = 20;
    public var sec_count:Number = 400;
    public var levels:Array = [];
    public var persons:Array = [];
    public var sectors:Array = [];
    public var field:Main;
    public function Grid(f:Main) {

        var l:String;
        field = f;

        for(var i:String in field.config.level_conf){
            levels.push(new Level(parseInt(i),sec_count,this));
        }

        for(l in levels){
            addChild(levels[l]);
        }
        set_neibours();
        //addEventListener(Event.ADDED_TO_STAGE,changed);
        addEventListener(MouseEvent.CLICK,click_me);
        addEventListener(MouseEvent.MOUSE_OVER, search_in_me);
    }
    public function set_neibours():void{
        var max:Number = this.line_len;
        var max_l:Number = max*this.levels.length;
        var s:String;
        var i:Number;
        var j:Number;
        //var k:String;
        var b1:Boolean;
        var current:Sector;
        var next:Sector;
        var mx:int;
        var my:int;
        var variants:Array;
        var variant:int = 0;
        var m:String;
        for(s in sectors){
            for(m in sectors[s]){
                mx = parseInt(s);
                my = parseInt(m);
                current = sectors[mx][my];
                if(current != null) {
                    i = -1;
                    j = -1;
                    for(i = -1;i<2;i++){
                        for(j = -1;j<2;j++){
                            if(!((j == 0) && (i == 0))){
                                if((mx+i >= 0)&&(mx+i < max_l)&&(my+j >= 0)&&(my+j < max)){
                                    next =  sectors[mx+i][my+j];
                                    if(next != null){
                                        variants = [((j < 0) && (i == 0)),
                                            ((j == 0) && (i < 0)),
                                            ((j > 0) && (i == 0)),
                                            ((j == 0) && (i > 0)),
                                            ((j < 0) && (i > 0)),
                                            ((j < 0) && (i < 0)),
                                            (j > 0) && (i > 0),
                                            (j > 0) && (i < 0)];
                                        variant = variants.indexOf(true);

                                        b1 = false;
                                        switch(variant){
                                            case 1:
                                                b1 = (current.walls[0]||next.walls[2]);
                                                break;
                                            case 0:

                                                b1 = (current.walls[3]||next.walls[1]);
                                                break;
                                            case 3:

                                                b1 = (current.walls[2]||next.walls[0]);
                                                break;
                                            case 2:

                                                b1 = (current.walls[1]||next.walls[3]);
                                                break;
                                            case 7:

                                                b1 = ((current.walls[0]||current.walls[1])||(next.walls[2]||next.walls[3]));
                                                break;
                                            case 5:

                                                b1 = ((current.walls[0]||current.walls[3])||(next.walls[2]||next.walls[1]));
                                                break;
                                            case 6:

                                                b1 = ((current.walls[1]||current.walls[2])||(next.walls[3]||next.walls[0]));
                                                break;
                                            case 4:

                                                b1 = ((current.walls[2]||current.walls[3])||(next.walls[0]||next.walls[1]));
                                                break;
                                            default:
                                                b1 = false;
                                                break;
                                        }
                                        if(!b1){
                                            current.neibours.push([mx+i, my+j]);
                                        }
                                        else{

                                        }
                                    }
                                }
                            }
                        }
                    }
                    if(current.climb){
                        if(int(mx + Math.sqrt(sec_count) < max_l)&&(sectors[mx+Math.sqrt(sec_count)][m].climb)){
                            current.neibours.push([mx + max,my]);
                        }
                        if((mx - Math.sqrt(sec_count) >= 0)&&(sectors[mx-Math.sqrt(sec_count)][m].climb)){
                            current.neibours.push([mx - max,my]);
                        }
                    }
                }
            }
        }
    }
    public function addElem(elem:*, lev:Number):void{
        lev < levels.length && (this.levels[lev] as Level).addChild(elem);

    }
    public function change_level(prs:Person,lvl:Number):void{

        var i:String;
        for(i in levels){
            if(parseInt(i) != lvl){
                if(levels[i].contains(prs)){
                    levels[i].removeChild(prs);
                    levels[lvl].addChild(prs);
                }
            }
        }
    }
    private function click_me(e:Event = null):void{
        var i:String;
        var active:String = '';
        if((!(e.target is Person))&&(e.target is Sector)){
            if(!e.target.closed){
                for(i in persons){
                    if(persons[i].selected){
                        active = i;
                    }
                }
            }
            if(active != ''){
                persons[active].way_to_remember = persons[active].way_to_walk;
                field.next.visible = true;
            }
        }
        else if(e.target is Person){
           for(i in persons){
              persons[i].selected = false;
              persons[i].draw_me(false);
           }
           (e.target as Person).change_status();
        }
    }
    private function search_in_me(e:Event = null):void{
        removeEventListener(MouseEvent.MOUSE_OVER, search_in_me);

        if((!(e.target is Person))&&(e.target is Sector)){

            var i:String;
            var j:String;
            var active:String;

            for(i in persons){
                if(persons[i].selected){
                    active = i;
                }
            }
            if(active){

                persons[active].still_counting = true;
                for(i in sectors){
                    for(j in sectors[i]){
                        if(sectors[i][j] != null){
                            (sectors[i][j] as Sector).flag = false;

                            (sectors[i][j] as Sector).weight = 365000;
                        }
                    }
                }

                if(!((persons[active].pos['line'] == e.target.line) &&(persons[active].pos['cell'] == e.target.cell))){
                    persons[active].search(persons[active].pos,[e.target.line,e.target.cell]);
                }
            }
        }
        addEventListener(MouseEvent.MOUSE_OVER, search_in_me);
    }

}
}
