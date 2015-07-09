package com.github.mortido.sqcity.models
{
    public class Production
    {
        public function Production(isAuto:Boolean,
                                   coinsCost:Number,
                                   energyCost:Number,
                                   populationCost:Number,
                                   coinsBonus:Number,
                                   energyBonus:Number,
                                   populationBonus:Number,
                                   time:Number,
                                   id:Number)
        {
            _isAuto = isAuto;
            _coinsCost = coinsCost;
            _energyCost = energyCost;
            _populationCost = populationCost;
            _coinsBonus = coinsBonus;
            _energyBonus = energyBonus;
            _populationBonus = populationBonus;
            _time = time;
            _id = id;
        }

        private var _isAuto:Boolean;
        private var _coinsCost:Number;
        private var _energyCost:Number;
        private var _populationCost:Number;
        private var _coinsBonus:Number;
        private var _energyBonus:Number;
        private var _populationBonus:Number;
        private var _time:Number;
        private var _id:Number;

        public function get isAuto():Boolean
        {
            return _isAuto;
        }

        public function get coinsCost():Number
        {
            return _coinsCost;
        }

        public function get energyCost():Number
        {
            return _energyCost;
        }

        public function get populationCost():Number
        {
            return _populationCost;
        }

        public function get coinsBonus():Number
        {
            return _coinsBonus;
        }

        public function get energyBonus():Number
        {
            return _energyBonus;
        }

        public function get populationBonus():Number
        {
            return _populationBonus;
        }

        public function get time():Number
        {
            return _time;
        }

        public function get id():Number
        {
            return _id;
        }

    }
}