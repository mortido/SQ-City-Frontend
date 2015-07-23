package com.github.mortido.sqcity.ui.gamefield.isosprites
{
    import as3isolib.display.IsoSprite;

    import com.github.mortido.sqcity.GameState;
    import com.github.mortido.sqcity.models.Building;
    import com.github.mortido.sqcity.models.Production;
    import com.github.mortido.sqcity.resources.Assets;
    import com.github.mortido.sqcity.resources.IGameResourceManager;
    import com.github.mortido.sqcity.ui.*;
    import com.github.mortido.sqcity.ui.buttons.CircleButton;
    import com.github.mortido.sqcity.ui.gamefield.GameField;
    import com.greensock.TweenLite;
    import com.greensock.easing.Back;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.globalization.DateTimeFormatter;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

    public class BuildingIsoSprite extends IsoSprite
    {
        private const MILLISECONDS_IN_HOUR:Number = 3600000;

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

            // For correct rendering order at isometric scene.
            setSize(_model.type.xSize * GameField.CELL_SIZE, _model.type.ySize * GameField.CELL_SIZE, 1);

            // Create status text field.
            statusText = new TextField();
            statusText.selectable = false;
            statusText.autoSize = TextFieldAutoSize.LEFT;
            statusText.defaultTextFormat = new TextFormat("helvetica", 12, Assets.getColor("@color/status_text"), true);
            statusText.background = true;
            statusText.backgroundColor = Assets.getColor("@color/status_background");
            statusText.alpha = 0.8;
            statusText.y = STATUS_LABEL_VERTICAL_OFFSET;

            // Create production buttons.
            var productions:Vector.<Production> = _model.type.productions;
            var buttonsContainer:Sprite = new Sprite();
            //buttonsContainer.mouseEnabled = false;
            productionButtons = new Vector.<CircleButton>();
            for (var i:int = 0; i < productions.length; i++)
            {
                if (productions[i].isAuto)
                {

                    // There is should be only one production if it has isAuto flag.
                    for (var j:int = 0; j < productionButtons.length; j++)
                    {
                        buttonsContainer.removeChild(productionButtons[i]);
                        productionButtons.slice(j, 1);
                    }
                    break;
                }

                var button:CircleButton = new CircleButton(PRODUCTION_BUTTON_SIZE / 2, "@image/contract/" + productions[i].id, Assets.getColor("@color/production_buttons_background"));
                button.visible = false;
                button.alpha = 0;
                productionButtons.push(button);
                buttonsContainer.addChild(button);
            }

            sprites = [image, hitArea, statusText, buttonsContainer];

            hoursTimeFormatter = new DateTimeFormatter("en-Us");
            hoursTimeFormatter.setDateTimePattern("H:mm:ss");
            minutesTimeFormatter = new DateTimeFormatter("en-Us");
            minutesTimeFormatter.setDateTimePattern("m:ss");
        }

        private const PRODUCTION_BUTTON_SIZE:Number = 60;
        private const STATUS_LABEL_VERTICAL_OFFSET:Number = -50;
        private const PRODUCTION_BUTTONS_VERTICAL_OFFSET:Number = -50;
        private const PRODUCTION_BUTTONS_OFFSET:Number = 10;
        private var statusText:TextField;
        private var image:Sprite;
        private var _model:Building;
        private var hoursTimeFormatter:DateTimeFormatter;
        private var minutesTimeFormatter:DateTimeFormatter;

        public function get model():Building
        {
            return _model;
        }

        public function update():void
        {
            if (_model.type.productions.length == 0)
            {
                return;
            }

            // Update status bar.
            if (_model.currentProduction)
            {
                var timeLeft:Number = _model.productionFinishTime.getTime() - new Date().getTime();
                if (timeLeft > 0)
                {
                    statusText.text = Assets.getStringResource("@string/working_status") + formatTime(new Date(timeLeft));
                }
                else
                {
                    statusText.text = Assets.getStringResource("@string/production_ready_status");
                }
            }
            else
            {
                statusText.text = Assets.getStringResource("@string/free_status");
            }

            statusText.x = -statusText.width / 2;
        }

        private function formatTime(time:Date):String
        {
            var formatter:DateTimeFormatter =
                    time.getTime() >= MILLISECONDS_IN_HOUR
                            ? hoursTimeFormatter
                            : minutesTimeFormatter;
            return formatter.format(time);
        }

        private function onFrame(event:Event):void
        {
            update();
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

            if (_model.currentProduction)
            {
                var timeLeft:Number = _model.productionFinishTime.getTime() - new Date().getTime();
                if (timeLeft <= 0)
                {
                    statusText.text = Assets.getStringResource("@string/production_ready_status");
                }
            }
            else
            {
                toggleProductionMenu(true);
                event.stopPropagation();
            }
        }

        private var productionButtons:Vector.<CircleButton>;

        private function toggleProductionMenu(show:Boolean):void
        {
            if (show)
            {
                TweenLite.to(statusText, 0.65, {y: 0, alpha: 0.0, ease: Back.easeIn});
                var x:Number = -(productionButtons.length - 1) * (PRODUCTION_BUTTONS_OFFSET + PRODUCTION_BUTTON_SIZE) / 2;
                for (var i:int = 0; i < productionButtons.length; i++)
                {
                    productionButtons[i].visible = true;
                    TweenLite.to(productionButtons[i], 0.65, {
                        y: PRODUCTION_BUTTONS_VERTICAL_OFFSET,
                        x: x,
                        alpha: 1.0,
                        ease: Back.easeOut
                    });
                    x += PRODUCTION_BUTTONS_OFFSET + PRODUCTION_BUTTON_SIZE;
                }
                container.stage.addEventListener(MouseEvent.CLICK, hideMenu, false, 0, true);
            }
            else
            {
                TweenLite.to(statusText, 0.65, {y: STATUS_LABEL_VERTICAL_OFFSET, alpha: 1.0, ease: Back.easeOut});
                for (var i:int = 0; i < productionButtons.length; i++)
                {
                    var button:CircleButton = productionButtons[i];
                    button.visible = true;
                    TweenLite.to(productionButtons[i], 0.65, {
                        y: 0,
                        x: 0,
                        alpha: 0.0,
                        onComplete:function(){
                            button.visible = false;
                        },
                        ease: Back.easeIn
                    });
                }
                container.stage.addEventListener(MouseEvent.CLICK, hideMenu, false, 0, true);
            }
        }

        private function hideMenu(event:MouseEvent):void
        {
            toggleProductionMenu(false);
            container.removeEventListener(MouseEvent.CLICK, hideMenu);
        }
    }
}