package com.github.mortido.sqcity.ui.buttons
{
    import com.github.mortido.sqcity.Game;
    import com.github.mortido.sqcity.models.BuildingType;
    import com.github.mortido.sqcity.resources.IGameResourceManager;
    import com.github.mortido.sqcity.ui.VisualEffects;

    import flash.display.Bitmap;
    import flash.display.Shape;
    import flash.display.SimpleButton;

    public class BuildingButton extends SimpleButton
    {
        public function BuildingButton(buildingType:BuildingType, width:Number, height:Number, scale:Number = 0.5)
        {
            var rm:IGameResourceManager = Game.instance.resourceManager;
            _buildingType = buildingType;

            var up:Bitmap = rm.createBitmap(buildingType.getResourceId());
            var over:Bitmap = rm.createBitmap(buildingType.getResourceId());
            var down:Bitmap = rm.createBitmap(buildingType.getResourceId());

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

            super(up, over, down, hitArea);
        }
        private var _buildingType:BuildingType;

        public function get buildingType():BuildingType
        {
            return _buildingType;
        }
    }
}
