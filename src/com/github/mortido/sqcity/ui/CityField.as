package com.github.mortido.sqcity.ui
{
    import as3isolib.display.IsoSprite;
    import as3isolib.display.IsoView;
    import as3isolib.display.scene.IsoGrid;
    import as3isolib.display.scene.IsoScene;
    import as3isolib.geom.Pt;
    import as3isolib.graphics.Stroke;
    
    import com.github.mortido.sqcity.Assets;
    
    import flash.display.Bitmap;
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.net.URLRequest;

    /**
    * Represent scrolling city map view
    */
    public class CityField extends Sprite
    {
        /**
        * City tile size before isometric transoframtion.
        */
        private static const CELL_SIZE: Number = 50;

        /**
        * Isometric scene object.
        * Contains city tiles and field.
        */
        private var scene:IsoScene;

        /**
        * Isometric view which used to show isoScene.
        */
        private var view:IsoView;

        /**
        * Point for view scrolling.
        */
        private var panPt:Pt;
        
        private var bitmap:Bitmap;

        public function CityField(width:Number, height:Number)
        {
            super();

            scene = new IsoScene();

            // Show grid in debug only.
            CONFIG::DEBUG {
                var grid:IsoGrid = new IsoGrid();
                grid.setGridSize(9, 9, 1);
                grid.gridlines = new Stroke(1, 0xeeeeee);
                grid.showOrigin = false;
                grid.cellSize = CELL_SIZE;
                scene.addChild(grid);
            }

            
            
            
            
            
            
            //////////////////
            var l:Loader = new Loader();
            l.load(new URLRequest("../../../sqtest/field.jpg"));
            l.y= -74;
            l.x = -539;
            
            var l2:Loader = new Loader();
            l2.load(new URLRequest("../../../sqtest/factory.png"));
            l2.contentLoaderInfo.addEventListener(Event.COMPLETE, oncmplte, false, 0 ,true);
            l2.y= -52;
            l2.x = -109;
            bitmap = new Assets.StubImage();
            bitmap.y=-52;
            bitmap.x=-109;
            var s:IsoSprite = new IsoSprite();
            s.sprites = [l, bitmap];
            scene.addChild(s);


            view = new IsoView();
            view.setSize(width, height);
            view.showBorder = false;
            view.panBy(0, height/2);
            view.addScene(scene);
            
            ///////////////
            view.rangeOfMotionTarget = l;
            view.limitRangeOfMotion = true;
            ///////////////
            
            
            
            view.addEventListener(MouseEvent.MOUSE_DOWN, onStartPan, false, 0, true);
            addChild(view);
            addEventListener(Event.ENTER_FRAME, onFrame, false, 0 , true);
        }
        
        protected function oncmplte(event:Event):void
        {
            // TODO Auto-generated method stub
            bitmap.bitmapData =event.target.content.bitmapData;
        }
        
        protected function onFrame(event:Event):void
        {
            scene.render();
        }

        private function onStartPan(e:MouseEvent):void
        {
            panPt = new Pt(stage.mouseX, stage.mouseY);
            
            view.removeEventListener(MouseEvent.MOUSE_DOWN, onStartPan);
            view.addEventListener(MouseEvent.MOUSE_MOVE, onPan, false, 0, true);
            view.addEventListener(MouseEvent.MOUSE_UP, onStopPan, false, 0, true);
        }

        private function onPan(e:MouseEvent):void
        {
            view.panBy(panPt.x - stage.mouseX, panPt.y - stage.mouseY);
            panPt.x = stage.mouseX;
            panPt.y = stage.mouseY;
        }

        private function onStopPan(e:MouseEvent):void
        {
            view.removeEventListener(MouseEvent.MOUSE_MOVE, onPan);
            view.removeEventListener(MouseEvent.MOUSE_UP, onStopPan);
            view.addEventListener(MouseEvent.MOUSE_DOWN, onStartPan, false, 0, true);
        }
    }
}