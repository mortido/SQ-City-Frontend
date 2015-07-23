package com.github.mortido.sqcity.ui.gamefield
{
    import as3isolib.display.IsoSprite;
    import as3isolib.display.scene.IsoScene;

    import com.github.mortido.sqcity.models.BuildingType;
    import com.github.mortido.sqcity.resources.Assets;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Point;

    public class EditFieldState extends BaseFieldState
    {
        private const OVERLAY_SIZE:Number = 1500;

        public function EditFieldState()
        {
            var s:Sprite = new Sprite();
            s.graphics.beginFill(Assets.getColor("@color/edit_overlay"), 0.5);
            s.graphics.drawRect(-OVERLAY_SIZE / 2, -OVERLAY_SIZE / 2, OVERLAY_SIZE, OVERLAY_SIZE);
            s.graphics.endFill();

            var isoSprite:IsoSprite = new IsoSprite();
            isoSprite.sprites = [s];

            _editScene = new IsoScene();
            _editScene.addChild(isoSprite)
        }

        /**
         * Scene for display edit overlay.
         * Placed under buildings scene.
         */
        private var _editScene:IsoScene;

        override public function setup(cityField:GameField):void
        {
            super.setup(cityField);

            // Add edit scene under building scene.
            view.addSceneAt(_editScene, view.scenes.indexOf(field.buildingScene));

            view.addEventListener(MouseEvent.CLICK, onMouseClick, true, 0, true);
            view.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove, false, 0, true);
            field.addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);
        }

        override public function release():void
        {
            field.removeEventListener(Event.ENTER_FRAME, onFrame);
            view.removeEventListener(MouseEvent.CLICK, onMouseClick, true);
            view.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);

            view.removeScene(_editScene);
            super.release();
        }

        private function onMouseClick(event:MouseEvent):void
        {
            event.stopImmediatePropagation();
            var x:Number = event.stageX;
            var y:Number = event.stageY;
            var tile:Point = field.globalToTile(x, y);
            event.stopImmediatePropagation();

            if (!field.isInRange(tile.x, tile.y))
            {
                // Consider this as canceling building mode.
                field.setState(new ScrollingFieldState());
                return;
            }

            onTileClicked(tile.x, tile.y);
        }

        protected function checkPlacement(x:int, y:int, buildingType:BuildingType):Boolean
        {
            for (var i:int = 0; i < buildingType.xSize; i++)
            {
                for (var j:int = 0; j < buildingType.ySize; j++)
                {
                    if (field.getBuildingByCoordinates(x + i, y + j) || !field.isInRange(x + i, y + j))
                    {
                        return false;
                    }
                }
            }

            return true;
        }

        protected function isBuildingInRange(x:int, y:int, buildingType:BuildingType):Boolean
        {
            for (var i:int = 0; i < buildingType.xSize; i++)
            {
                for (var j:int = 0; j < buildingType.ySize; j++)
                {
                    if (!field.isInRange(x + i, y + j))
                    {
                        return false;
                    }
                }
            }

            return true;
        }

        /**
         * Handles click on some field tile with coordinates x and y.
         * Should be overridden in child class.
         * @param x The X coordinated of clicked tile.
         * @param y The Y coordinated of clicked tile.
         */
        protected function onTileClicked(x:int, y:int):void
        {
            // Do nothing. Just stub for overriding.
        }

        /**
         * Handles mouse move on some field tile with coordinates x and y.
         * Should be overridden in child class.
         * @param x The X coordinated of selected tile.
         * @param y The Y coordinated of selected tile.
         */
        protected function onTileSelected(x:int, y:int):void
        {
            // Do nothing. Just stub for overriding.
        }

        private function onMouseMove(event:MouseEvent):void
        {
            var tile:Point = field.globalToTile(event.stageX, event.stageY);
            onTileSelected(tile.x, tile.y);
        }

        private function onFrame(event:Event):void
        {
            _editScene.render();
        }

        protected function get editScene():IsoScene
        {
            return _editScene;
        }
    }
}