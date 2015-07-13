package com.github.mortido.sqcity.models
{
    public class Production
    {
        public function Production(isAuto:Boolean,
                                   coinsCost:int,
                                   energyCost:int,
                                   populationCost:int,
                                   coinsBonus:int,
                                   energyBonus:int,
                                   populationBonus:int,
                                   time:uint,
                                   id:int)
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
        private var _coinsCost:int;
        private var _energyCost:int;
        private var _populationCost:int;
        private var _coinsBonus:int;
        private var _energyBonus:int;
        private var _populationBonus:int;
        private var _time:uint;
        private var _id:int;

        public function get isAuto():Boolean
        {
            return _isAuto;
        }

        public function get coinsCost():int
        {
            return _coinsCost;
        }

        public function get energyCost():int
        {
            return _energyCost;
        }

        public function get populationCost():int
        {
            return _populationCost;
        }

        public function get coinsBonus():int
        {
            return _coinsBonus;
        }

        public function get energyBonus():int
        {
            return _energyBonus;
        }

        public function get populationBonus():int
        {
            return _populationBonus;
        }

        public function get time():uint
        {
            return _time;
        }

        public function get id():int
        {
            return _id;
        }

    }
}