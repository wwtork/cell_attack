package classes {

import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import interfaces.ISector;

import views.Grid;

public class Sector extends Sprite implements ISector{
    public var weight:Number = 365000;

    public var w:Number = 50;
    public var h:Number = 50;
    public var neibours:Array = [];
    public var grid:Grid;
    private var moving_object:Sprite;
    public var flag:Boolean = false;
    private var _visitors:Array;
    public var cell:Number;
    public var line:Number;
    public var level:Number;
    public var walls:Array;
    public var closed:Boolean = false;
    public var climb:Boolean = false;
    public var text:TextField;
    public var back:uint = 0xffffff;
    public var light:uint = 0xff6600;
    public var n_light:uint = 0xff9900;
    private var _border:uint = 0x000000;
    public function change_text(str:String):void{
        text.text = str;
    }

    private function add_climbs():void{
        if(climb){
            var c:Sprite = new Sprite();
            c.graphics.lineStyle(1,0);
            c.graphics.beginFill(0xffffff,1);
            c.graphics.drawRect(0,0,30,30);
            c.graphics.moveTo(0,10);
            c.graphics.lineTo(30,10);
            c.graphics.moveTo(0,20);
            c.graphics.lineTo(30,20);
            c.graphics.endFill();
            c.x = -15;
            c.y = -15;
            c.mouseEnabled = false;
            addChild(c);
        }
    }
    public function add_wall():void{
        var w:String;

        var dx:Number = 0;
        var dy:Number = 0;
        for(w in walls){
            if(walls[w]){
                var wall:Wall = new Wall(parseInt(w),dx,dy);
                this.addChild(wall);
            }
        }
    }
    public function Sector(line:Number, cell:Number, closed:Boolean, grid:Grid, climb:Boolean, level:Number) {
        this.cell = cell;
        this.line = line;
        this.level = level;
        this.grid = grid;
        this.climb = climb;
        sec_out();
        //weight = 10;
        text = new TextField();
        text.mouseEnabled = false;
        text.x = 0;
        text.y = 0;
        text.textColor = 0x000000;
        addChild(text);
        this.closed = closed;
        change_text(cell+'-'+line+'-'+level);
        add_climbs();
        addEventListener(MouseEvent.MOUSE_OVER,sec_over);
        addEventListener(MouseEvent.MOUSE_OUT,sec_out);

    }
    public function show_target(target:Graphics):void{
        moving_object = new Sprite();
        moving_object.graphics.copyFrom(target);
        moving_object.alpha = 0.5;
        moving_object.mouseEnabled = false;
        addChildAt(moving_object, 1);
    }
    public function clear_target():void{
        if(moving_object){
            if(contains(moving_object)){
                removeChild(moving_object);
            }
        }
    }

    public function update_visitors(added:Person, clear:Boolean = false):void {
        if(clear)
            this._visitors = new Array(added);
        else{
            this._visitors.push(added);
        }
    }
    public function get_visitors(type:Number):Array{
        return this._visitors;
    }
    public function set_coords(lev:Number):void{

        this.x = cell*w + w/2;
        this.y = (line-lev*20)*h + h/2;
    }
    public function sec_out(e:Event = null):void{
        var obj:Sector;
        var i:String;
        obj = this;
        obj.graphics.clear();
        obj.graphics.lineStyle(1,_border);
        obj.graphics.beginFill(back, 1);
        obj.graphics.drawRect(-w/2,-h/2,w,h);
        obj.graphics.endFill();
        for(i in this.neibours){
            obj = grid.sectors[neibours[i][0]][neibours[i][1]];
            obj.graphics.clear();
            obj.graphics.lineStyle(1,_border);
            obj.graphics.beginFill(back, 1);
            obj.graphics.drawRect(-w/2,-h/2,w,h);
            obj.graphics.endFill();
        }
    }
    public function sec_over(e:Event = null):void{
        var obj:Sector;
        var i:String;
        obj = this;
        obj.graphics.clear();
        obj.graphics.lineStyle(1,_border);
        obj.graphics.beginFill(light, 1);
        obj.graphics.drawRect(-w/2,-h/2,w, h);
        obj.graphics.endFill();
        for(i in this.neibours){
            obj = grid.sectors[neibours[i][0]][neibours[i][1]];
            obj.graphics.clear();
            obj.graphics.lineStyle(1,_border);
            obj.graphics.beginFill(n_light, 1);
            obj.graphics.drawRect(-w/2,-h/2,w, h);
            obj.graphics.endFill();
        }
    }

}
}
