package com.github.mortido.sqcity.configuration
{
    public class ImageInfo
    {
        public function ImageInfo(url:String, referenceX:Number, referenceY:Number)
        {
            _url = url;
            _referenceX = referenceX;
            _referenceY = referenceY;
        }

        private var _url:String;
        private var _referenceX:Number;
        private var _referenceY:Number;

        public function get url():String
        {
            return _url;
        }

        public function get referenceX():Number
        {
            return _referenceX;
        }

        public function get referenceY():Number
        {
            return _referenceY;
        }
    }
}
