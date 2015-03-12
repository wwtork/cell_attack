/**
 * Created by wwtork on 12.03.15.
 */
package classes {
public class Job {

    private var _class:Class;
    private var _method:String;
    private var _args:Array;
    private var _times:int;
    private var _interval:int;
    private var _offset:int;

    public function Job(cl:Class, method:String, interval:int = 0, offset:int = 0, times:int = -1, args:Array = []) {
        if(method in cl){
            _class = cl;
            _method = method;
            _args = args;
            _times = times;
            _interval = interval;
            _offset = offset;
        }
        else{

        }
    }

    public function start_job():Boolean{
        if(_times > 0 || _times == -1){
            _class[_method](_args);
            _times != -1 && _times--;
            return true;
        }
        else return false;
    }

    public function get offset():int {
        return _offset;
    }

    public function get interval():int {
        return _interval;
    }
}
}
