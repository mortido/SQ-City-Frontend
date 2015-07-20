package com.github.mortido.sqcity.ui.gamefield
{
    import flash.events.MouseEvent;
    import flash.geom.Point;

    public class ScrollingFieldState extends BaseFieldState
    {

        override public function setup(cityField:GameField):void
        {
            super.setup(cityField);
            view.addEventListener(MouseEvent.MOUSE_DOWN, onStartPan, false, 0, true);
        }

        override public function release():void
        {
            view.removeEventListener(MouseEvent.MOUSE_MOVE, onPan);
            view.removeEventListener(MouseEvent.MOUSE_UP, onStopPan);
            view.removeEventListener(MouseEvent.MOUSE_DOWN, onStartPan);

            super.release();
        }

        /**
         * Point for view scrolling.
         */
        private var panPt:Point;

        private function onStartPan(e:MouseEvent):void
        {
            panPt = new Point(view.stage.mouseX, view.stage.mouseY);

            view.removeEventListener(MouseEvent.MOUSE_DOWN, onStartPan);
            view.addEventListener(MouseEvent.MOUSE_MOVE, onPan, false, 0, true);
            view.addEventListener(MouseEvent.MOUSE_UP, onStopPan, false, 0, true);
        }

        private function onPan(e:MouseEvent):void
        {
            view.panBy(panPt.x - view.stage.mouseX, panPt.y - view.stage.mouseY);
            panPt.x = view.stage.mouseX;
            panPt.y = view.stage.mouseY;
        }

        private function onStopPan(e:MouseEvent):void
        {
            view.removeEventListener(MouseEvent.MOUSE_MOVE, onPan);
            view.removeEventListener(MouseEvent.MOUSE_UP, onStopPan);
            view.addEventListener(MouseEvent.MOUSE_DOWN, onStartPan, false, 0, true);
        }
    }
}
