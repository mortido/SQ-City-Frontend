package com.github.mortido.sqcity.resources
{
    import flash.display.Bitmap;
    import flash.display.Sprite;

    public class BitmapWrapper extends Sprite
    {
        private var _bitmap:Bitmap;
        public function get bitmap():Bitmap
        {
            return _bitmap;
        }

        public function BitmapWrapper(bitmap:Bitmap)
        {
            _bitmap = bitmap;
            addChild(bitmap);
        }
    }
}
