/**
 * Created by IntelliJ IDEA.
 * User: root
 * Date: 03.02.12
 * Time: 21:48
 * To change this template use File | Settings | File Templates.
 */
package classes {
import flash.display.Sprite;
import flash.events.Event;
import flash.utils.setTimeout;

import interfaces.IPerson;


public class Person implements IPerson{

    public var way_to_walk:Array = [];
    public var way_to_remember:Array = [];
    public var pos:Array = [];
    public var steps_per_round:Number = 5;
    public var speed:Number = 200;
    //private var flags:Array = [];
    //public var free_steps:Number;
    //public var bonuses:Array = [];
    //public var health:Number;
    //public var power:Number;
    private var _still_counting:Boolean = true;
    public var field:Main;
    public var selected:Boolean;
    public function Person(line:Number, cell:Number, field:Main){
        draw_me(false);
        pos['line'] = line;
        pos['cell'] = cell;
        this.field = field;
        //addEventListener(MouseEvent.MOUSE_OVER, on_over);
        //addEventListener(MouseEvent.CLICK, change_status);
    }

    public function change_status(e:Event = null):void{
        this.selected = !this.selected;
        draw_me(this.selected);
    }
    /*public function get_remain_steps():Number{
        return Math.round(way_to_walk.length/steps_per_round) - 1;
    } */
    public function draw_me(sel:Boolean = false):void{
       this.graphics.lineStyle(1,0);
       this.graphics.beginFill(sel ? 0xcccccc : 0x000000,1);
       this.graphics.drawCircle(0,0,15);
       this.graphics.endFill();
    }


    private function change_pos(count:Number, max:Number):Array{

        if(max > way_to_remember.length - 1) max = way_to_remember.length - 1;
        if(!((way_to_remember[max].line == pos['line'])&&(way_to_remember[max].cell == pos['cell']))) {
            pos['line'] = way_to_remember[count].line;
            pos['cell'] = way_to_remember[count].cell;
            var this_level:Number = this.field.grid.sectors[pos['line']][pos['cell']].level;

            this.field.grid.change_level(this,this_level);

            this.x = way_to_remember[count].x;
            this.y = way_to_remember[count].y;

            pos['line'] = way_to_remember[count].line;
            pos['cell'] = way_to_remember[count].cell;

            count++;

            return [change_pos,this.speed, count, max];

        }
        else{
            way_to_remember.splice(0,max);
            field.next.visible = (way_to_remember.length > 1);
            return null;
        }
    }
    public function start_move():void{
        var max:Number;
        var len:Number = way_to_remember.length - 1;
        max = (steps_per_round > len) ? len : steps_per_round;
        setTimeout(change_pos,this.speed, 0 ,max);
    }

    public function get still_counting():Boolean {
        return _still_counting;
    }

    public function set still_counting(value:Boolean):void {
        _still_counting = value;
    }

}
}
