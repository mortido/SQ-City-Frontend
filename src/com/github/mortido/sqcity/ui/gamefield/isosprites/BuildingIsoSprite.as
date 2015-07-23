package com.github.mortido.sqcity.ui.gamefield.isosprites
{
    import as3isolib.display.IsoSprite;

    import com.github.mortido.sqcity.GameState;
    import com.github.mortido.sqcity.models.Building;
    import com.github.mortido.sqcity.resources.IGameResourceManager;
    import com.github.mortido.sqcity.ui.*;
    import com.github.mortido.sqcity.ui.gamefield.GameField;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;

    public class BuildingIsoSprite extends IsoSprite
    {
        public function BuildingIsoSprite(model:Building)
        {
            super();
            _model = model;

            var rm:IGameResourceManager = GameState.instance.resourceManager;

            image = rm.createImageSprite(_model.type.getResourceId());
            var hitArea:Tile = new Tile(_model.type.xSize, _model.type.ySize, 0x000000, 0);
            hitArea.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
            hitArea.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
            hitArea.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
            hitArea.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
            hitArea.addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
            addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);

            // Don't 'hover' other sprites.
            container.mouseEnabled = false;
            image.mouseEnabled = image.mouseChildren = false;

            setSize(_model.type.xSize * GameField.CELL_SIZE, _model.type.ySize * GameField.CELL_SIZE, 1)

            sprites = [image, hitArea];
        }

        private function onFrame(event:Event):void
        {
            // TODO: update status.
        }

        private var image:Sprite;
        private var _model:Building;

        public function get model():Building
        {
            return _model;
        }

        public function update():void
        {
            //TODO: update status bar.
        }

        private function onMouseUp(event:MouseEvent):void
        {
            image.filters = [];
        }

        private function onMouseDown(event:MouseEvent):void
        {
            image.filters = VisualEffects.PRESSED_BUTTON_FILTERS;
        }

        private function onMouseOut(event:MouseEvent):void
        {
            image.filters = [];
        }

        private function onMouseOver(event:MouseEvent):void
        {
            image.filters = VisualEffects.HOVERED_BUTTON_FILTERS;
        }

        private function onClick(event:MouseEvent):void
        {
            if (_model.type.productions.length == 0)
            {
                return;
            }

            if(_model.currentProduction)
            {

            }
            // TODO: if production
            // TODO:     If production ready
            // TODO:         harvest
            // TODO:         if production was isAuto - start it again.
            // TODO: else
            // TODO:     show "Chose Production menu"
        }
    }
}