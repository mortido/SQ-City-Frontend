package com.github.mortido.sqcity.ui.gamefield
{
    import as3isolib.display.IsoSprite;

    import com.github.mortido.sqcity.GameState;
    import com.github.mortido.sqcity.models.Building;
    import com.github.mortido.sqcity.models.BuildingType;
    import com.github.mortido.sqcity.resources.Assets;
    import com.github.mortido.sqcity.ui.Tile;
    import com.github.mortido.sqcity.ui.gamefield.isosprites.BuildingIsoSprite;

    public class BuildNewFieldState extends EditFieldState
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
            editScene.addChild(guideSprite);
        }

        private var _buildingType:BuildingType;
        private var fittedTile:Tile;
        private var notFittedTile:Tile;
        private var guideSprite:IsoSprite;


        override protected function onTileSelected(x:int, y:int):void
        {
            if (!isBuildingInRange(x, y, _buildingType))
            {
                // Hide guide sprites.
                fittedTile.visible = false;
                notFittedTile.visible = false;
            }
            else
            {
                // Check placement.
                var fitted:Boolean = checkPlacement(x, y, _buildingType);
                fittedTile.visible = fitted;
                notFittedTile.visible = !fitted;
                guideSprite.moveTo(x * GameField.CELL_SIZE, y * GameField.CELL_SIZE, 0);
            }
        }

        override protected function onTileClicked(x:int, y:int):void
        {
            if (checkPlacement(x, y, _buildingType))
            {
                var building:Building = GameState.instance.buildNew(x, y, _buildingType);
                field.addBuilding(building);
                field.setState(new ScrollingFieldState());
            }
        }
    }
}
