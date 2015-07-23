package com.github.mortido.sqcity.ui.gamefield
{
    import com.github.mortido.sqcity.GameState;
    import com.github.mortido.sqcity.models.Building;

    public class SellBuildingFieldState extends EditFieldState
    {
        override protected function onTileClicked(x:int, y:int):void
        {
            var building:Building = field.getBuildingByCoordinates(x, y);
            if (building)
            {
                field.removeBuilding(building);
                GameState.instance.sellBuilding(building);
                field.setState(new ScrollingFieldState());
            }
        }
    }
}
