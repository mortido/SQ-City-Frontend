package com.github.mortido.sqcity.ui.buttons
{
    import com.github.mortido.sqcity.GameState;
    import com.github.mortido.sqcity.models.BuildingType;
    import com.github.mortido.sqcity.resources.IGameResourceManager;
    import com.github.mortido.sqcity.ui.ResourceLabel;
    import com.github.mortido.sqcity.ui.VisualEffects;

    import flash.display.Shape;
    import flash.display.SimpleButton;
    import flash.display.Sprite;

    public class BuildingButton extends Sprite
    {
        public function BuildingButton(buildingType:BuildingType, width:Number, height:Number, showModifiers:Boolean = false, scale:Number = 0.5)
        {
            var rm:IGameResourceManager = GameState.instance.resourceManager;
            _buildingType = buildingType;

            up = rm.createImageSprite(buildingType.getResourceId());
            var over:Sprite = rm.createImageSprite(buildingType.getResourceId());
            var down:Sprite = rm.createImageSprite(buildingType.getResourceId());

            scale *= 1 / Math.max(buildingType.xSize, buildingType.ySize);
            up.scaleX = over.scaleX = down.scaleX = scale;
            up.scaleY = over.scaleY = down.scaleY = scale;
            up.x = over.x = down.x = up.x * scale + width / 2;
            up.y = over.y = down.y = up.y * scale + height * 2 / 3;

            over.filters = VisualEffects.HOVERED_BUTTON_FILTERS;
            down.filters = VisualEffects.PRESSED_BUTTON_FILTERS;

            var hitArea:Shape = new Shape();
            hitArea.graphics.beginFill(0x000000);
            hitArea.graphics.drawRect(0, 0, width, height);
            hitArea.graphics.endFill();

            if (showModifiers)
            {
                addChild(new ResourceLabel(_buildingType.coinsModifier, _buildingType.energyModifier, _buildingType.populationModifier, 9, true));
            }

            button = new SimpleButton(up, over, down, hitArea);
            addChild(button);
        }
        private var up:Sprite;
        private var button:SimpleButton;
        private var _buildingType:BuildingType;

        public function get enabled():Boolean
        {
            return button.enabled;
        }

        public function set enabled(value:Boolean):void
        {
            button.enabled = value;
            up.filters = value ? [] : VisualEffects.DISABLED_BUTTON_FILTERS;
        }

        public function get buildingType():BuildingType
        {
            return _buildingType;
        }
    }
}
