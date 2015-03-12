/**
 * Created by IntelliJ IDEA.
 * User: root
 * Date: 03.02.12
 * Time: 21:47
 * To change this template use File | Settings | File Templates.
 */
package {

import classes.Person;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;

import utils.ContentHelper;

import views.Grid;
import views.Tooltip;

[Frame(factoryClass="Preloader")]
public class Main extends Sprite{
    public var connector:ClassConnector;
    public var grid:Grid;
    public var msk:Sprite;
    public var grid_container:Sprite = new Sprite();
    public var controls_container:Sprite = new Sprite();
    public var next:Sprite;
    public var config:ContentHelper;
    public var tooltip:Tooltip;

    public function Main() {
        if (!stage) {
            addEventListener(Event.ADDED_TO_STAGE, init);
        } else init();
    }
    public function after_config():void{
        //trace(config.level_conf);
        next = new Sprite();
        next.graphics.lineStyle(1,0);
        next.graphics.beginFill(0,1);
        next.graphics.drawRect(0,0,50,15);
        next.graphics.endFill();
        //next.label = 'next';
        next.x = 0;
        next.y = 0;

        grid = new Grid(this);
        msk = new Sprite();
        msk.graphics.lineStyle(0,1);
        msk.graphics.beginFill(0xffffff,1);
        msk.graphics.drawRect(stage.stageWidth/8,50,stage.stageWidth-(stage.stageWidth/2),275);
        msk.graphics.endFill();
        grid_container.y = 50;
        grid_container.addChild(grid);

        controls_container.addChild(next);

        addChild(grid_container);
        addChild(controls_container);

        connector = new ClassConnector();
        grid.x = 0;
        grid.y = 0;
        var person:Person;
        for each(var p:Array in config.persons ){
            person = new Person(p[0],p[1],this);
            grid.addElem(person,0);
            grid.persons.push(person);
            connector.connect_persons_w_sectors(grid, person);
        }

        next.visible = false;
        for(var i:String in grid.levels){
            grid.levels[i].rotation = -30;
        }
        for(i in grid.persons){
            grid.persons[i].scaleY = 2.5;
            grid.persons[i].rotation = 30;
        }
        show_level(0);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, manage_keys);
        next.addEventListener(MouseEvent.CLICK,move);
        addEventListener(MouseEvent.MOUSE_OVER,on_over);
        addEventListener(MouseEvent.MOUSE_OUT,on_out);
        addEventListener(MouseEvent.MOUSE_MOVE, on_move);
        addEventListener(MouseEvent.MOUSE_DOWN, start_drag);
        addEventListener(MouseEvent.MOUSE_UP, stop_drag);

        grid.scaleY = 0.4;
        this.graphics.lineStyle(0,1);
    }
    public function init(e:Event = null):void{
        removeEventListener(Event.ADDED_TO_STAGE, init);
        this.config = new ContentHelper(this);
    }
    private function start_drag(e:Event = null):void{
        //var bounds:Rectangle = new Rectangle(-Math.abs(msk.width - grid.width),-Math.abs(msk.height-grid.height),Math.abs(msk.width - grid.width),Math.abs(msk.height-grid.height));
        grid.startDrag(false/*, bounds*/);
    }
    private function stop_drag(e:Event = null):void{
        grid.stopDrag();
    }
    private function manage_keys(e:KeyboardEvent = null):void{
        var num:Number = e.charCode;
        if((num >= 48)&&(num <= 57)){
            num = num - 49;
            if(grid.levels[num]){
                 show_level(num);
            }
        }
    }
    /*public function new_tooltip(text:String):void{
        if(tooltip){
            if(contains(tooltip)){
                removeChild(tooltip);
            }
        }
        tooltip = new Sprite();
    }*/

    private function show_level(num : int):void{
        for(var i:String in grid.levels){
            grid.levels[i].alpha = 0.1;
            grid.levels[i].mouseEnabled = false;
            grid.levels[i].mouseChildren = false;
        }
        grid.levels[num].alpha = 1;
        grid.levels[num].mouseEnabled = true;
        grid.levels[num].mouseChildren = true;
    }

    private function move(e:Event = null):void{
        var i:String;
        for(i in grid.persons){
            if(grid.persons[i].way_to_remember.length > 0){
                (grid.persons[i] as Person).start_move();
            }
        }
    }
    private function on_over(e:Event = null):void{
        if(e.target is Person){
            tooltip = new Tooltip('person', e.target);
            tooltip.x = mouseX+5;
            tooltip.y = mouseY+5;
            addChild(tooltip);
        }
    }
    private function on_out(e:Event = null):void{
       // if(!(e.target is Tooltip)){
            if(tooltip){
                if(contains(tooltip)){
                    removeChild(tooltip);
                }
            }
       // }
    }
    private function on_move(e:Event = null):void{
        if(tooltip){
            if(contains(tooltip)){
               tooltip.x = mouseX+5;
               tooltip.y = mouseY+5;
            }
        }
    }
}
}
