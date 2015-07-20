package com.github.mortido.sqcity.ui.gamefield
{
    import as3isolib.display.IsoSprite;
    import as3isolib.display.scene.IsoScene;

    import com.github.mortido.sqcity.GameState;
    import com.github.mortido.sqcity.models.Building;
    import com.github.mortido.sqcity.models.BuildingType;
    import com.github.mortido.sqcity.resources.Assets;
    import com.github.mortido.sqcity.ui.Tile;
    import com.github.mortido.sqcity.ui.gamefield.isosprites.BuildingIsoSprite;

    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Point;

    public class BuildNewFieldState extends BaseFieldState
    {

        public function BuildNewFieldState(buildingType:BuildingType)
        {
            _buildingType = buildingType;

            fittedTile = new Tile(_buildingType.xSize, _buildingType.ySize, Assets.getColor("@color/guide_sprite_fitted"), 0.5)
            fittedTile.visible = false;
            notFittedTile = new Tile(_buildingType.xSize, _buildingType.ySize, Assets.getColor("@color/guide_sprite_not_fitted"), 0.5)
            notFittedTile.visible = false;

            guideSprite = new IsoSprite();
            guideSprite.sprites = [fittedTile, notFittedTile];

            buildingScene = new IsoScene();
            buildingScene.addChild(guideSprite)
        }
        private var _buildingType:BuildingType;
        private var fittedTile:Tile;
        private var notFittedTile:Tile;
        private var guideSprite:IsoSprite;
        private var buildingScene:IsoScene;

        override public function setup(cityField:GameField):void
        {
            super.setup(cityField);
            view.addScene(buildingScene);
            field.addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);
            view.addEventListener(MouseEvent.CLICK, onBuild, false, 0, true);
            view.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove, false, 0, true);
            view.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
        }

        override public function release():void
        {
            field.removeEventListener(Event.ENTER_FRAME, onFrame);
            view.removeEventListener(MouseEvent.CLICK, onBuild);
            view.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
            view.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
            view.removeScene(buildingScene);
            super.release();
        }

        private function isNewBuildingInRange(x:int, y:int):Boolean
        {
            for (var i:int = 0; i < _buildingType.xSize; i++)
            {
                for (var j:int = 0; j < _buildingType.ySize; j++)
                {
                    if (!field.isInRange(x + i, y + j))
                    {
                        return false;
                    }
                }
            }

            return true;
        }

        private function checkPlacement(x:int, y:int):Boolean
        {
            var placementMatrix:Vector.<Vector.<BuildingIsoSprite>> = field.placementMatrix;
            for (var i:int = 0; i < _buildingType.xSize; i++)
            {
                for (var j:int = 0; j < _buildingType.ySize; j++)
                {
                    if (placementMatrix[x + i][y + j] != null)
                    {
                        return false;
                    }
                }
            }

            return true;
        }

        private function onMouseOver(event:MouseEvent):void
        {
            // Prevent mouse over handlers.
            //event.stopImmediatePropagation();
        }

        private function onMouseMove(event:MouseEvent):void
        {
            // Prevent mouse move handlers.
            //event.stopImmediatePropagation();

            var tile:Point = field.globalToTile(event.stageX, event.stageY);

            if (!isNewBuildingInRange(tile.x, tile.y))
            {
                // Hide guide sprites.
                fittedTile.visible = false;
                notFittedTile.visible = false;
            }
            else
            {
                // Check placement.
                var fitted:Boolean = checkPlacement(tile.x, tile.y);
                fittedTile.visible = fitted;
                notFittedTile.visible = !fitted;
                guideSprite.moveTo(tile.x * GameField.CELL_SIZE, tile.y * GameField.CELL_SIZE, 0);
            }
        }

        private function onBuild(event:MouseEvent):void
        {
            // Prevent click handlers.
            //event.stopImmediatePropagation();

            var tile:Point = field.globalToTile(event.stageX, event.stageY);

            if (!field.isInRange(tile.x, tile.y))
            {
                // Consider this as canceling building mode.
                field.setState(new ScrollingFieldState());
                return;
            }

            if (!checkPlacement(tile.x, tile.y))
            {
                // Do nothing if in range, but can't build because of place limit.
                return;
            }

            var building:Building = GameState.instance.buildNew(tile.x, tile.y, _buildingType);
            field.addBuilding(building);
            field.setState(new ScrollingFieldState());
        }

        private function onFrame(event:Event):void
        {
            buildingScene.render();
        }
    }
}
