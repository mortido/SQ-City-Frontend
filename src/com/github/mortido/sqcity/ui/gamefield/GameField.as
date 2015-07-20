package com.github.mortido.sqcity.ui.gamefield
{
    import as3isolib.display.IsoSprite;
    import as3isolib.display.IsoView;
    import as3isolib.display.renderers.DefaultSceneLayoutRenderer;
    import as3isolib.display.renderers.SimpleSceneLayoutRenderer;
    import as3isolib.display.scene.IsoGrid;
    import as3isolib.display.scene.IsoScene;
    import as3isolib.geom.Pt;
    import as3isolib.graphics.Stroke;

    import com.github.mortido.sqcity.GameState;
    import com.github.mortido.sqcity.models.Building;
    import com.github.mortido.sqcity.ui.*;
    import com.github.mortido.sqcity.ui.gamefield.isosprites.BuildingIsoSprite;

    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Point;

    /**
     * Represent scrolling city map view
     */
    public class GameField extends Sprite
    {
        /**
         * City tile size before isometric transoframtion.
         */
        public static const CELL_SIZE:Number = 50;

        /**
         * Field size in tiles.
         */
        public static const FIELD_SIZE:Number = 9;

        public function GameField(width:Number, height:Number, buildings:Vector.<Building>)
        {
            super();

            mainScene = new IsoScene();

            // Add background scene.
            backScene = new IsoScene();
            var fieldBackground:IsoSprite = new IsoSprite();
            var fieldBackgroundImage:Sprite = GameState.instance.resourceManager.createImageSprite("@image/field");
            fieldBackground.sprites = [fieldBackgroundImage];
            backScene.addChild(fieldBackground);

            // Show grid in debug only.
            CONFIG::DEBUG {
                var grid:IsoGrid = new IsoGrid();
                grid.setGridSize(FIELD_SIZE, FIELD_SIZE, 1);
                grid.gridlines = new Stroke(1, 0xeeeeee);
                grid.showOrigin = false;
                grid.cellSize = CELL_SIZE;
                grid.x = -1;
                grid.y = -1;
                backScene.addChild(grid);
            }

            // Configure isometric view.
            _view = new IsoView();
            _view.setSize(width, height);
            _view.showBorder = false;
            _view.panBy(0, height / 2);

            _view.addScene(backScene);
            _view.addScene(mainScene);
            _view.rangeOfMotionTarget = fieldBackgroundImage;
            _view.limitRangeOfMotion = true;
            addChild(_view);

            // Create placement matrix.
            _placementMatrix = new Vector.<Vector.<BuildingIsoSprite>>(FIELD_SIZE);
            for (var i:int = 0; i < FIELD_SIZE; i++)
            {
                _placementMatrix[i] = new Vector.<BuildingIsoSprite>(FIELD_SIZE);
            }

            // Add buildings.
            for (var j:int = 0; j < buildings.length; j++)
            {
                addBuilding(buildings[j]);
            }

            // Set default (do nothing) state.
            setState(new ScrollingFieldState());

            addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);
        }

        /**
         * Isometric scene object.
         * Contains building sprites.
         */
        private var mainScene:IsoScene;

        /**
         * Isometric scene object.
         * Contains background sprites.
         */
        private var backScene:IsoScene;

        /**
         * Current field state.
         * Contains build/play logic.
         */
        private var _state:FieldState;

        /**
         * Isometric view which used to show isoScene.
         */
        private var _view:IsoView;

        /**
         * Associate coordinates and buildings sprites.
         */
        private var _placementMatrix:Vector.<Vector.<BuildingIsoSprite>>;

        public function setState(value:FieldState):void
        {
            if (_state)
            {
                _state.release();
            }

            _state = value;
            _state.setup(this);
        }

        public function isInRange(x:int, y:int):Boolean
        {
            return x >= 0 && x < FIELD_SIZE && y >= 0 && y < FIELD_SIZE;
        }

        internal function get placementMatrix():Vector.<Vector.<BuildingIsoSprite>>
        {
            return _placementMatrix;
        }

        internal function get view():IsoView
        {
            return _view;
        }

        internal function addToPlacementMatrix(bs:BuildingIsoSprite):void
        {
            var building:Building = bs.model;
            for (var i:int = 0; i < building.type.xSize; i++)
            {
                for (var j:int = 0; j < building.type.ySize; j++)
                {
                    _placementMatrix[building.x + i][building.y + j] = bs;
                }
            }
        }

        internal function removeFromPlacementMatrix(bs:BuildingIsoSprite):void
        {
            var building:Building = bs.model;
            for (var i:int = 0; i < building.type.xSize; i++)
            {
                for (var j:int = 0; j < building.type.ySize; j++)
                {
                    _placementMatrix[building.x + i][building.y + j] = null;
                }
            }
        }

        internal function addBuilding(building:Building):void
        {
            var bs:BuildingIsoSprite = new BuildingIsoSprite(building);
            bs.moveTo(building.x * CELL_SIZE, building.y * CELL_SIZE, 0);
            addToPlacementMatrix(bs);
            mainScene.addChild(bs);
        }

        internal function deleteBuilding(building:Building):void
        {
            var bs:BuildingIsoSprite = _placementMatrix[building.x][building.y];
            removeFromPlacementMatrix(bs);
            mainScene.removeChild(bs);
        }

        internal function globalToTile(stageX:Number, stageY:Number):Point
        {
            var point2d:Point = _view.globalToLocal(new Point(stageX, stageY));
            var point:Pt = _view.localToIso(point2d);
            var x:Number = Math.floor(point.x / CELL_SIZE);
            var y:Number = Math.floor(point.y / CELL_SIZE);
            return new Point(x, y);
        }

        private function onFrame(event:Event):void
        {
            backScene.render();
            mainScene.render();
        }
    }
}