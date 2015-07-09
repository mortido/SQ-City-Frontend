package com.github.mortido.sqcity.configuration
{
    import flash.utils.Dictionary;

    public class Config
    {
        private var _imageInfos:Dictionary = new Dictionary();
        private var _buildingTypes:Dictionary = new Dictionary();

        public function get imageInfos():Dictionary
        {
            return _imageInfos;
        }

        public function get buildingTypes():Dictionary
        {
            return _buildingTypes;
        }
    }
}
