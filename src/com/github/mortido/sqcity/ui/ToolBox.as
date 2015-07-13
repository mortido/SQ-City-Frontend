package com.github.mortido.sqcity.ui
{
    import com.github.mortido.sqcity.Game;
    import com.github.mortido.sqcity.models.BuildingType;
    import com.github.mortido.sqcity.resources.Assets;
    import com.github.mortido.sqcity.ui.buttons.BuildingButton;
    import com.github.mortido.sqcity.ui.buttons.CircleButton;
    import com.github.mortido.sqcity.ui.buttons.TextButton;
    import com.greensock.*;
    import com.greensock.easing.*;

    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.utils.Dictionary;

    public class ToolBox extends Sprite
    {
        private static var TOOLBOX_HEIGHT:Number = 100;
        private static var TOGGLE_BTN_OFFSET:Number = 35;
        private static var ACTION_BTN_OFFSET:Number = 10;
        private static var ACTION_BTN_HEIGHT:Number = 35;
        private static var ACTION_BTN_WIDTH:Number = 100;
        private static var BUILDING_BTN_WIDTH:Number = 50;
        private static var BUILDING_BTN_HEIGHT:Number = 80;
        private static var BUILDING_BTN_OFFSET:Number = 30;

        private static var TOOLBOX_COLOR:uint = 0xe0e0d2;
        private static var TOOLBOX_BORDER_COLOR:uint = 0xbab9ae;
        private static var MOVE_BTN_COLOR:uint = 0x4c6fe0;
        private static var MOVE_BTN_TEXT_COLOR:uint = 0xfff5d1;
        private static var SELL_BTN_COLOR:uint = 0xe0b14c;
        private static var SELL_BTN_TEXT_COLOR:uint = 0xd1e7ff;

        private var toggleButton:SimpleButton;
        private var moveButton:SimpleButton;
        private var sellButton:SimpleButton;
        private var mainContainer:Sprite;
        private var isOpened:Boolean;

        public function ToolBox()
        {
            super();
            isOpened = false;

            // Create main container.
            mainContainer = new Sprite();
            addChild(mainContainer);

            // Create toggle button.
            toggleButton = new CircleButton(25, "@image/toolbox");
            addChild(toggleButton);

            // Create move and sell buttons.
            moveButton = new TextButton(Assets.getStringResource("@string/move_btn_text"), ACTION_BTN_WIDTH, ACTION_BTN_HEIGHT, MOVE_BTN_TEXT_COLOR, MOVE_BTN_COLOR);
            moveButton.x = ACTION_BTN_OFFSET;
            moveButton.y = ACTION_BTN_OFFSET;
            mainContainer.addChild(moveButton);

            sellButton = new TextButton(Assets.getStringResource("@string/sell_btn_text"), ACTION_BTN_WIDTH, ACTION_BTN_HEIGHT, SELL_BTN_TEXT_COLOR, SELL_BTN_COLOR);
            sellButton.x = ACTION_BTN_OFFSET;
            sellButton.y = ACTION_BTN_OFFSET * 2 + ACTION_BTN_HEIGHT;
            mainContainer.addChild(sellButton);

            var buildingTypes:Dictionary = Game.instance.config.buildingTypes;
            var xIncrement:Number = ACTION_BTN_OFFSET + ACTION_BTN_WIDTH + BUILDING_BTN_OFFSET;
            for (var key:String in buildingTypes)
            {
                var btn:BuildingButton = new BuildingButton(buildingTypes[key], BUILDING_BTN_WIDTH, BUILDING_BTN_HEIGHT);
                btn.y = ACTION_BTN_OFFSET;
                btn.x = xIncrement;
                mainContainer.addChild(btn);
                xIncrement += BUILDING_BTN_OFFSET + BUILDING_BTN_WIDTH;
            }

            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
            toggleButton.addEventListener(MouseEvent.CLICK, toggleToolbox, false, 0, true);
        }

        private function toggleToolbox(event:MouseEvent):void
        {
            if (isOpened)
            {
                isOpened = false;
                TweenLite.to(toggleButton, 0.65, {y: -TOGGLE_BTN_OFFSET, ease: Back.easeIn});
                TweenLite.to(mainContainer, 0.65, {y: 0, ease: Circ.easeIn});
            }
            else
            {
                TweenLite.to(toggleButton, 0.65, {y: -TOOLBOX_HEIGHT - 1, ease: Back.easeOut});
                TweenLite.to(mainContainer, 0.65, {y: -TOOLBOX_HEIGHT - 1, ease: Circ.easeOut});
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
