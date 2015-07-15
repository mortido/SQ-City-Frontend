package com.github.mortido.sqcity.ui
{
    import as3isolib.display.IsoSprite;

    import com.github.mortido.sqcity.Game;
    import com.github.mortido.sqcity.models.Building;
    import com.github.mortido.sqcity.resources.IGameResourceManager;

    import flash.display.Bitmap;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;

    public class BuildingSprite extends IsoSprite
    {


        public function BuildingSprite(model:Building)
        {
            super();
            _model = model;

            var rm:IGameResourceManager = Game.instance.resourceManager;

            var up:Bitmap = rm.createBitmap(_model.type.getResourceId());
            var over:Bitmap = rm.createBitmap(_model.type.getResourceId());
            over.filters = VisualEffects.HOVERED_BUTTON_FILTERS;
            var hitArea:Tile = new Tile(_model.type.xSize,_model.type.ySize);
            var button:SimpleButton = new SimpleButton(up, over, over, hitArea);
            button.addEventListener(MouseEvent.CLICK, onClick);
            sprites = [button];
        }

        private function onClick(event:MouseEvent):void
        {
            // TODO: if ready for production - show menu (hide on stage click, and many other cases...)
            // TODO: if production is ready - harvest.
        }

        public function update():void
        {
            //TODO: update status bar.
        }

        private var _model:Building;
    }
}