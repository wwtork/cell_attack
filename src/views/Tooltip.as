/**
 * Created by IntelliJ IDEA.
 * User: root
 * Date: 08.02.12
 * Time: 18:12
 * To change this template use File | Settings | File Templates.
 */
package views {
import flash.display.Sprite;
import flash.text.TextField;

public class Tooltip extends Sprite{
    public var text:TextField = new TextField();
    public var owner:*;
    public function Tooltip(txt:String, own:*) {
        this.text.text = txt;
        this.owner = own;
        this.graphics.lineStyle(1,0);
        this.graphics.beginFill(0xffffff,1);
        this.graphics.drawRect(0,0,text.width, text.height);
        this.graphics.endFill();
        addChild(text);
    }

}
}
