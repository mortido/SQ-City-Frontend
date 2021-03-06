package com.github.mortido.sqcity.ui
{
    import com.github.mortido.sqcity.GameState;
    import com.github.mortido.sqcity.models.BuildingType;
    import com.github.mortido.sqcity.resources.Assets;
    import com.github.mortido.sqcity.ui.buttons.BuildingButton;
    import com.github.mortido.sqcity.ui.buttons.CircleButton;
    import com.github.mortido.sqcity.ui.buttons.TextButton;
    import com.github.mortido.sqcity.ui.gamefield.BuildNewFieldState;
    import com.github.mortido.sqcity.ui.gamefield.GameField;
    import com.github.mortido.sqcity.ui.gamefield.MoveBuildingFieldState;
    import com.github.mortido.sqcity.ui.gamefield.SellBuildingFieldState;
    import com.greensock.*;
    import com.greensock.easing.*;

    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.utils.Dictionary;

    public class ToolBox extends Sprite
    {
        private const TOOLBOX_HEIGHT:Number = 100;
        private const TOGGLE_BTN_OFFSET:Number = 35;
        private const ACTION_BTN_OFFSET:Number = 10;
        private const ACTION_BTN_HEIGHT:Number = 35;
        private const ACTION_BTN_WIDTH:Number = 100;
        private const BUILDING_BTN_WIDTH:Number = 50;
        private const BUILDING_BTN_HEIGHT:Number = 80;
        private const BUILDING_BTN_OFFSET:Number = 30;

        private var _buildingButtons:Vector.<BuildingButton> = new Vector.<BuildingButton>();

        public function ToolBox(gameField:GameField)
        {
            super();
            _gameField = gameField;
            isOpened = false;

            // Create main container.
            mainContainer = new Sprite();
            addChild(mainContainer);

            // Create toggle button.
            toggleButton = new CircleButton(25, "@image/toolbox");
            addChild(toggleButton);

            // Create move and sell buttons.
            var moveButton:TextButton = new TextButton(
                    Assets.getStringResource("@string/move_btn_text"),
                    ACTION_BTN_WIDTH,
                    ACTION_BTN_HEIGHT,
                    Assets.getColor("@color/move_btn_text"),
                    Assets.getColor("@color/move_btn"));
            moveButton.x = ACTION_BTN_OFFSET;
            moveButton.y = ACTION_BTN_OFFSET;
            moveButton.addEventListener(MouseEvent.CLICK, onMoveButtonClick, false, 0, true);
            mainContainer.addChild(moveButton);

            var sellButton:TextButton = new TextButton(
                    Assets.getStringResource("@string/sell_btn_text"),
                    ACTION_BTN_WIDTH,
                    ACTION_BTN_HEIGHT,
                    Assets.getColor("@color/sell_btn_text"),
                    Assets.getColor("@color/sell_btn"));
            sellButton.x = ACTION_BTN_OFFSET;
            sellButton.y = ACTION_BTN_OFFSET * 2 + ACTION_BTN_HEIGHT;
            sellButton.addEventListener(MouseEvent.CLICK, onSellButtonClick, false, 0, true);
            mainContainer.addChild(sellButton);

            var buildingTypes:Dictionary = GameState.instance.config.buildingTypes;
            var xIncrement:Number = ACTION_BTN_OFFSET + ACTION_BTN_WIDTH + BUILDING_BTN_OFFSET;
            for (var key:String in buildingTypes)
            {
                var btn:BuildingButton = new BuildingButton(buildingTypes[key], BUILDING_BTN_WIDTH, BUILDING_BTN_HEIGHT, true);
                _buildingButtons.push(btn);
                btn.y = ACTION_BTN_OFFSET;
                btn.x = xIncrement;
                mainContainer.addChild(btn);
                xIncrement += BUILDING_BTN_OFFSET + BUILDING_BTN_WIDTH;
            }

            updateBuildingButtons();
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
            toggleButton.addEventListener(MouseEvent.CLICK, toggleToolbox, false, 0, true);
            GameState.instance.resources.addEventListener(Event.CHANGE, onGameResourcesChange, false, 0, true);
        }

        private function onMoveButtonClick(event:MouseEvent):void
        {
            _gameField.setState(new MoveBuildingFieldState());
        }

        private function onSellButtonClick(event:MouseEvent):void
        {
            _gameField.setState(new SellBuildingFieldState());
        }

        private function onGameResourcesChange(event:Event):void
        {
            updateBuildingButtons();
        }

        private var toggleButton:SimpleButton;
        private var mainContainer:Sprite;
        private var isOpened:Boolean;
        private var _gameField:GameField;

        private function updateBuildingButtons():void
        {
            for (var i:int = 0; i < _buildingButtons.length; i++)
            {
                var bt:BuildingType = _buildingButtons[i].buildingType;
                _buildingButtons[i].enabled = GameState.instance.resources.checkModifiers(bt.coinsModifier, bt.energyModifier, bt.populationModifier);
                if (_buildingButtons[i].enabled)
                {
                    _buildingButtons[i].addEventListener(MouseEvent.CLICK, onBuildNewClick, false, 0, true);
                }
                else
                {
                    _buildingButtons[i].removeEventListener(MouseEvent.CLICK, onBuildNewClick);
                }
            }
        }

        private function onBuildNewClick(event:MouseEvent):void
        {
            var btn:BuildingButton = event.currentTarget as BuildingButton;
            _gameField.setState(new BuildNewFieldState(btn.buildingType));
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

            mainContainer.graphics.beginFill(Assets.getColor("@color/windows_border"), 0.8);
            mainContainer.graphics.drawRect(0, 0, stage.stageWidth, 1);
            mainContainer.graphics.beginFill(Assets.getColor("@color/windows_background"), 0.8);
            mainContainer.graphics.drawRect(0, 1, stage.stageWidth, TOOLBOX_HEIGHT);
            mainContainer.graphics.endFill();

            // Move toggle button.
            toggleButton.x = stage.stageWidth - TOGGLE_BTN_OFFSET;
            toggleButton.y = -TOGGLE_BTN_OFFSET;
        }
    }
}
