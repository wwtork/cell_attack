/**
 * Created with IntelliJ IDEA.
 * User: ivan
 * Date: 29.05.13
 * Time: 18:23
 * To change this template use File | Settings | File Templates.
 */
package utils {
import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class ContentHelper {
    private var _level_conf:Array = [];
    private var _persons:Array = [];
    private var _main:Main;
    public function ContentHelper(m:Main) {
        _main = m;
        var myLoader:URLLoader = new URLLoader();
        myLoader.load(new URLRequest("level2.xml"));
        myLoader.addEventListener(Event.COMPLETE, processXML);
    }
    internal function processXML(e:Event):void {
        var _xml_f:XML = new XML(e.target.data);
        var lines:Array = [];
        for (var i:int = 0; i < _xml_f.*.length(); i++) {
            if (!(_level_conf[i] is Array)) _level_conf[i] = [];
            lines = _xml_f.level[i].split('\n');
            for (var l:Number = 0; l < lines.length; l++) {
                _level_conf[i][l] = [];
                _level_conf[i][l] = lines[l].split(',');
                if (_level_conf[i][l].indexOf('p') != -1) {
                    _persons.push(new Array(l, _level_conf[i][l].indexOf('p')));
                }
            }

        }

        _main.after_config();
    }

    public function get level_conf():Array {
        return _level_conf;
    }

    public function get persons():Array {
        return _persons;
    }
}
}
