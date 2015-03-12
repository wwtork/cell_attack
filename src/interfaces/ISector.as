/**
 * Created by IntelliJ IDEA.
 * User: root
 * Date: 03.02.12
 * Time: 21:54
 * To change this template use File | Settings | File Templates.
 */
package interfaces {
import classes.Person;

public interface ISector {
       function update_visitors(added:Person, clear:Boolean = false):void;
       function get_visitors(type:Number):Array;

       //function set_weight():void;
}
}
