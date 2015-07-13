package com.github.mortido.sqcity.ui.buttons
{
    import com.github.mortido.sqcity.Game;
    import com.github.mortido.sqcity.resources.IGameResourceManager;
    import com.github.mortido.sqcity.ui.*;

    import flash.display.Bitmap;
    import flash.display.Shape;
    import flash.display.SimpleButton;

    public class CircleButton extends SimpleButton
    {
        public function CircleButton(radius:Number, imageId:String)
        {
            var rm:IGameResourceManager = Game.instance.resourceManager;
            var up:Bitmap = rm.createBitmap(imageId);

            var over:Bitmap = rm.createBitmap(imageId);
            over.filters = VisualEffects.HOVERED_BUTTON_FILTERS;

            var down:Bitmap = rm.createBitmap(imageId);
            down.filters = VisualEffects.PRESSED_BUTTON_FILTERS;

            var hitArea:Shape = new Shape();
            hitArea.graphics.beginFill(0x000000);
            hitArea.graphics.drawCircle(0, 0, radius);
            hitArea.graphics.endFill();

            super(up, over, down, hitArea);
        }
        private var _radius:Number;

        public function get radius():Number
        {
            return _radius;
        }
    }
}