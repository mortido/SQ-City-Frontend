package com.github.mortido.sqcity.models
{
    public class Building
    {

        public function Building(x:Number, y:Number, id:Number, type:BuildingType, currentProduction:Production = null, productionFinishTime:Date = null)
        {
            _x = x;
            _y = y;
            _id = id;
            _type = type;
            _currentProduction = currentProduction;
            _productionFinishTime = productionFinishTime;
        }

        private var _x:Number;
        private var _y:Number;
        private var _id:Number;
        private var _type:BuildingType;
        private var _currentProduction:Production;
        private var _productionFinishTime:Date;

        public function get x():Number
        {
            return _x;
        }

        public function get y():Number
        {
            return _y;
        }

        public function get id():Number
        {
            return _id;
        }

        public function get type():BuildingType
        {
            return _type;
        }

        public function get currentProduction():Production
        {
            return _currentProduction;
        }

        public function set currentProduction(value:Production):void
        {
            _currentProduction = value;
        }

        public function get productionFinishTime():Date
        {
            return _productionFinishTime;
        }

        public function set productionFinishTime(value:Date):void
        {
            _productionFinishTime = value;
        }
    }
}