/**
 * Created by hsavenko on 9/10/2014.
 */
package utils.loka.ui {
import flash.display.DisplayObject;
import flash.geom.Point;

    public class GoalDO {
        private var _point:Point;
        private var _isHandCursor:Boolean;
        public function GoalDO(point:Point, useHandCursor:Boolean) {
            _point = point;
            _isHandCursor = useHandCursor;
        }

        public function get point():Point {
            return _point;
        }

        public function get isHandCursor():Boolean {
            return _isHandCursor;
        }
    }
}
