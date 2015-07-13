package com.github.mortido.sqcity.models
{
    public class BuildingType
    {
        public function BuildingType(coinsModifier:int,
                                     energyModifier:int,
                                     populationModifier:int,
                                     xSize:uint,
                                     ySize:uint,
                                     name:String,
                                     productions:Vector.<Production>)
        {
            _coinsModifier = coinsModifier;
            _energyModifier = energyModifier;
            _populationModifier = populationModifier;
            _xSize = xSize;
            _ySize = ySize;
            _name = name;
            _productions = productions;
        }

        private var _coinsModifier:int;
        private var _energyModifier:int;
        private var _populationModifier:int;
        private var _xSize:uint;
        private var _ySize:uint;
        private var _name:String;
        private var _productions:Vector.<Production>;

        public function get coinsModifier():int
        {
            return _coinsModifier;
        }

        public function get energyModifier():int
        {
            return _energyModifier;
        }

        public function get populationModifier():int
        {
            return _populationModifier;
        }

        public function get xSize():uint
        {
            return _xSize;
        }

        public function get ySize():uint
        {
            return _ySize;
        }

        public function get name():String
        {
            return _name;
        }

        public function get productions():Vector.<Production>
        {
            return _productions;
        }

        public function getResourceId():String
        {
            return "@image/building/" + _name;
        }
    }
}