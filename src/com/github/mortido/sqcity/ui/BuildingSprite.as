package com.github.mortido.sqcity.ui
{
    import as3isolib.display.IsoSprite;

    import com.github.mortido.sqcity.Game;
    import com.github.mortido.sqcity.models.Building;

    public class BuildingSprite extends IsoSprite
    {
        public function BuildingSprite(model:Building)
        {
            super();
            _model = model;
            sprites = [Game.instance.resourceManager.createBitmap(getResourceId())];
        }

        private var _model:Building;

        private function getResourceId():String
        {
            return "@image/building/" + _model.type.name;
        }
    }
}