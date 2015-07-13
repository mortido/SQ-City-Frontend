package com.github.mortido.sqcity.resources
{
    import com.github.mortido.sqcity.Game;
    import com.github.mortido.sqcity.configuration.ImageInfo;

    import flash.display.Bitmap;

    public class CachedResourceManager implements IGameResourceManager
    {
        private var lm:SharedLoadManager = new SharedLoadManager();

        public function createBitmap(id:String):Bitmap
        {
            // TODO: check existence.
            var ii:ImageInfo = Game.instance.config.imageInfos[id];

            // TODO: Check cache.

            var bitmap:Bitmap = new Assets.StubImage();
            bitmap.x = -ii.referenceX;
            bitmap.y = -ii.referenceY;

            // Start downloading
            lm.load(ii.url, function (b:Bitmap):void
            {
                bitmap.bitmapData = b.bitmapData;
            });

            return bitmap;
        }
    }
}