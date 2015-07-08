package com.github.mortido.sqcity.resources
{
    import flash.display.Bitmap;

    public class CachedResourceManager implements IGameResourceManager
    {
        public function createBitmap(id:String) : Bitmap
        {
            return new Assets.StubImage();
        }
    }
}