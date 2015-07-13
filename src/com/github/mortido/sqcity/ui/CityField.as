package com.github.mortido.sqcity.ui
{
    import as3isolib.display.IsoSprite;
    import as3isolib.display.IsoView;
    import as3isolib.display.scene.IsoGrid;
    import as3isolib.display.scene.IsoScene;
    import as3isolib.geom.Pt;
    import as3isolib.graphics.Stroke;

    import com.github.mortido.sqcity.Game;
    import com.github.mortido.sqcity.models.Building;

    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Point;

    /**
     * Represent scrolling city map view
     */
    public class CityField extends Sprite
    {
        /**
         * City tile size before isometric transoframtion.
         */
        private static const CELL_SIZE:Number = 50;

        /**
         * Field size in tiles.
         */
        private static const FIELD_SIZE:Number = 9;

        public function CityField(width:Number, height:Number)
        {
            super();

            scene = new IsoScene();

            // Show grid in debug only.
            CONFIG::DEBUG {
                var grid:IsoGrid = new IsoGrid();
                grid.setGridSize(FIELD_SIZE, FIELD_SIZE, 1);
                grid.gridlines = new Stroke(1, 0xeeeeee);
                grid.showOrigin = false;
                grid.cellSize = CELL_SIZE;
                //scene.addChild(grid);
            }

            // Add background.
            var fieldBackground:IsoSprite = new IsoSprite();
            var fieldBackgroundImage:Bitmap = Game.instance.resourceManager.createBitmap("@image/field");
            fieldBackground.sprites = [fieldBackgroundImage];
            scene.addChild(fieldBackground);

            // Configure isometric view.
            view = new IsoView();
            view.setSize(width, height);
            view.showBorder = false;
            view.panBy(0, height / 2);
            view.addScene(scene);
            view.rangeOfMotionTarget = fieldBackgroundImage;
            view.limitRangeOfMotion = true;

            // Draw buildings.
            var buildings:Vector.<Building> = Game.instance.buildings;
            for (var i:int = 0; i < buildings.length; i++)
            {
                var bs:BuildingSprite = new BuildingSprite(buildings[i]);
                bs.moveBy(buildings[i].x * CELL_SIZE, buildings[i].y * CELL_SIZE, 0);
                scene.addChild(bs);
            }

            view.addEventListener(MouseEvent.MOUSE_DOWN, onStartPan, false, 0, true);
            addChild(view);
            addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);
            addEventListener(MouseEvent.CLICK, onMouseClick, false, 0, true);
        }

        private function onMouseClick(event:MouseEvent):void
        {
            var point2d:Point = view.globalToLocal(new Point(event.stageX, event.stageY));

            var point:Pt = view.localToIso(point2d);
            //var point:Pt = new Pt(point2d.x, point2d.y);
            //IsoMath.screenToIso(point);
            var x:Number = Math.floor(point.x / CELL_SIZE);
            var y:Number = Math.floor(point.y / CELL_SIZE);
            if (x >= 0 && x < FIELD_SIZE && y >= 0 && y < FIELD_SIZE)
            {

            }
        }

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