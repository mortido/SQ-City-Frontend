package com.github.mortido.sqcity.ui.buttons
{
    import com.github.mortido.sqcity.GameState;
    import com.github.mortido.sqcity.resources.IGameResourceManager;
    import com.github.mortido.sqcity.ui.*;

    import flash.display.Shape;
    import flash.display.SimpleButton;
    import flash.display.Sprite;

    public class CircleButton extends SimpleButton
    {
        public function CircleButton(radius:Number, imageId:String, backgroundColor:Object = null)
        {
            var rm:IGameResourceManager = GameState.instance.resourceManager;
            var up:Sprite = rm.createImageSprite(imageId);

            var over:Sprite = rm.createImageSprite(imageId);
            over.filters = VisualEffects.HOVERED_BUTTON_FILTERS;

            var down:Sprite = rm.createImageSprite(imageId);
            down.filters = VisualEffects.PRESSED_BUTTON_FILTERS;

            var hitArea:Shape = new Shape();
            hitArea.graphics.beginFill(0x000000);
            hitArea.graphics.drawCircle(0, 0, radius);
            hitArea.graphics.endFill();

            if(backgroundColor!=null)
            {
                up.graphics.beginFill(uint(backgroundColor));
                up.graphics.drawCircle(0, 0, radius);
                up.graphics.endFill();

                over.graphics.beginFill(uint(backgroundColor));
                over.graphics.drawCircle(0, 0, radius);
                over.graphics.endFill();

                down.graphics.beginFill(uint(backgroundColor));
                down.graphics.drawCircle(0, 0, radius);
                down.graphics.endFill();
            }

            super(up, over, down, hitArea);
        }

        private var _radius:Number;

        public function get radius():Number
        {
            return _radius;
        }
    }
}
