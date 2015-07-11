package com.github.mortido.sqcity.ui
{
    import com.github.mortido.sqcity.Game;
    import com.github.mortido.sqcity.resources.IGameResourceManager;

    import flash.display.Bitmap;
    import flash.display.Shape;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.filters.ColorMatrixFilter;
    import flash.filters.DropShadowFilter;
    
    import com.greensock.*;
    import com.greensock.easing.*;

    public class ToolBox extends Sprite
    {
        private static var TOOLBOX_HEIGHT:Number = 100;
        private static var TOGGLE_BTN_OFFSET:Number = 35;
        private static var TOGGLE_BTN_SIZE:Number = 50;

        private static var TOOLBOX_COLOR:uint = 0xe0e0d2;
        private static var TOOLBOX_BORDER_COLOR:uint = 0xbab9ae;

        private var toggleButton:SimpleButton;
        private var mainContainer:Sprite;
        private var isOpened:Boolean;

        public function ToolBox()
        {
            super();
            isOpened = false;
            var rm:IGameResourceManager = Game.instance.resourceManager;

            // Setup toggle button view.
            toggleButton = new SimpleButton();

            var bmp:Bitmap = rm.createBitmap("@image/toolbox");
            toggleButton.upState = bmp;

            bmp = rm.createBitmap("@image/toolbox");
            bmp.filters = [new ColorMatrixFilter(VisualEffects.HOVERED_BUTTON_COLOR_MATRIX)];
            toggleButton.overState = bmp;

            bmp = rm.createBitmap("@image/toolbox");
            bmp.filters = [new DropShadowFilter(2, 45, 0x000000, 0.20, 0, 0, 1, 1, true),
                new ColorMatrixFilter(VisualEffects.PRESSED_BUTTON_COLOR_MATRIX)];
            toggleButton.downState = toggleButton.hitTestState = bmp;
            var hitArea:Shape = new Shape();
            hitArea.graphics.beginFill(0x000000);
            hitArea.graphics.drawCircle(0, 0, TOGGLE_BTN_SIZE / 2);
            hitArea.graphics.endFill();
            toggleButton.hitTestState = hitArea;

            // Create main container.
            mainContainer = new Sprite();

            addChild(mainContainer);
            addChild(toggleButton);
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
            toggleButton.addEventListener(MouseEvent.CLICK, toggleToolbox, false, 0, true);
        }

        private function toggleToolbox(event:MouseEvent):void
        {
            if (isOpened)
            {
                isOpened = false;
                TweenLite.to(toggleButton, 0.65, {y:-TOGGLE_BTN_OFFSET, ease:Back.easeIn});
                TweenLite.to(mainContainer, 0.65, {y:0, ease:Circ.easeIn});
            }
            else
            {
                TweenLite.to(toggleButton, 0.65, {y:-TOOLBOX_HEIGHT-1, ease:Back.easeOut});
                TweenLite.to(mainContainer, 0.65, {y:-TOOLBOX_HEIGHT-1, ease:Circ.easeOut});
                isOpened = true;
            }

        }

        private function onAddedToStage(event:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

            mainContainer.graphics.beginFill(TOOLBOX_BORDER_COLOR, 0.8);
            mainContainer.graphics.drawRect(0, 0, stage.stageWidth, 1);
            mainContainer.graphics.beginFill(TOOLBOX_COLOR, 0.8);
            mainContainer.graphics.drawRect(0, 1, stage.stageWidth, TOOLBOX_HEIGHT);
            mainContainer.graphics.endFill();

            // Move toggle button.
            toggleButton.x = stage.stageWidth - TOGGLE_BTN_OFFSET;
            toggleButton.y = -TOGGLE_BTN_OFFSET;
        }
    }
}
