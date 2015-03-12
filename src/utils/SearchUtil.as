/**
 * Created by wwtork on 12.03.15.
 */
package utils {
import classes.Person;
import classes.Sector;

public class SearchUtil {

    private static var _pos:Array = [];
    private static var _way_to_walk:Array = [];
    private static var _still_counting:Boolean = false;
    private static var _sectors:Array = [];

    private static function calc_path(target:Array):Boolean{
        var path:Array = [];

        var neibours:Array;
        var min_w:Sector;
        var i:String;

        var p:Array;
        var count:Number = 0;
        p = target;
        path.push(_sectors[target[0]][target[1]]);
        if(_sectors[p[0]][p[1]].closed) return false;
        while(!((p[0] == _pos['line']) && (p[1] == _pos['cell']))){
            neibours = _sectors[p[0]][p[1]].neibours;
            for(i in neibours) {
                if((!min_w)||(_sectors[neibours[i][0]][neibours[i][1]].weight < min_w.weight))
                    min_w = _sectors[neibours[i][0]][neibours[i][1]];
            }
            path.push(min_w);
            p = [min_w.line, min_w.cell];
            count++;
        }
        _way_to_walk = path.reverse();
        return true;
    }

    static public function search(p:Array, target:Array) : Array {

        var j:String;
        var new_w:Number;
        var that_w:Number;
        var that_c:Number;
        var last_w:Number;
        var that:Array = [];
        var i:String;
        var to_search:Array = [];
        if(p['line'] != undefined) p[0] = p['line'];
        if(p['cell'] != undefined) p[1] = p['cell'];

        if (_sectors[target[0]][target[1]] && _sectors[target[0]][target[1]].closed) return false;
        if(_still_counting){

            _sectors[p[0]][p[1]].flag = true;
            that = _sectors[p[0]][p[1]].neibours;
            if((p[0] == _pos['line'])&&(p[1] == _pos['cell'])) _sectors[p[0]][p[1]].weight = 0;
            if((p[0] == target[0]) && (p[1] == target[1])){
                _still_counting = false;
                calc_path(target);
            }
            else{
                for(j in that){
                    if(!_sectors[that[j][0]][that[j][1]].flag){
                        that_c = _sectors[that[j][0]][that[j][1]].closed;
                        if(!that_c){
                            that_w = _sectors[that[j][0]][that[j][1]].weight;
                            last_w = _sectors[p[0]][p[1]].weight;
                            new_w = 10 + last_w;
                            if((that_w == 365000)||(that_w > new_w)){
                                _sectors[that[j][0]][that[j][1]].weight = new_w;
                                _sectors[that[j][0]][that[j][1]].change_text(_sectors[that[j][0]][that[j][1]].weight.toString());
                            }
                            to_search.push(that[j]);
                        }

                    }
                }
                for(i in to_search){
                    search(to_search[i], target);
                }
            }
        }
        return _way_to_walk;
    }

    public static function set sectors(value:Array):void {
        _sectors = value;
    }

    public static function set pos(value:Array):void {
        _pos = value;
    }
}
}
