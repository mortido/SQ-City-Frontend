package com.github.mortido.sqcity.ui
{
    import as3isolib.display.IsoSprite;

    import com.github.mortido.sqcity.Game;
    import com.github.mortido.sqcity.models.Building;

    import flash.display.Bitmap;

    public class BuildingSprite extends IsoSprite
    {
        public function BuildingSprite(model:Building)
        {
            super();
            _model = model;
            sprites = [Game.instance.resourceManager.createBitmap(_model.type.getResourceId())];
        }

        private var _model:Building;
    }
}