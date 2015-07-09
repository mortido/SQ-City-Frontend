package com.github.mortido.sqcity.models
{
    public class BuildingType
    {
        public function BuildingType(coinsModifier:Number,
                                     energyModifier:Number,
                                     populationModifier:Number,
                                     xSize:Number,
                                     ySize:Number,
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

        private var _coinsModifier:Number;
        private var _energyModifier:Number;
        private var _populationModifier:Number;
        private var _xSize:Number;
        private var _ySize:Number;
        private var _name:String;
        private var _productions:Vector.<Production>;

        public function get coinsModifier():Number
        {
            return _coinsModifier;
        }

        public function get energyModifier():Number
        {
            return _energyModifier;
        }

        public function get populationModifier():Number
        {
            return _populationModifier;
        }

        public function get xSize():Number
        {
            return _xSize;
        }

        public function get ySize():Number
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
    }
}