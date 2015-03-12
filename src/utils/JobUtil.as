/**
 * Created by wwtork on 12.03.15.
 */
package utils {
public class JobUtil {

    private static var _jobs:Array = [];

    public function JobUtil() {
    }

    public static function addJob(job:Array){
        _jobs.push(job);
    }

    public static function get jobs():Array {
        return _jobs;
    }

    public static function hasJobs():Boolean{
        return _jobs.length > 0;
    }
}
}
