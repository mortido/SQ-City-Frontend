package com.github.mortido.sqcity.models
{
    import flash.events.Event;
    import flash.events.EventDispatcher;

    public class GameResources extends EventDispatcher
    {
        public function GameResources(coins:Number, energy:Number, population:Number)
        {
            _coins = coins;
            _energy = energy;
            _population = population;
        }
        private var _coins:Number;
        private var _energy:Number;
        private var _population:Number;

        public function get coins():Number
        {
            return _coins;
        }

        public function get energy():Number
        {
            return _energy;
        }

        public function get population():Number
        {
            return _population;
        }

        public function add(coins:Number, energy:Number, population:Number):void
        {
            _coins += coins;
            _energy += energy;
            _population += population;
            dispatchEvent(new Event(Event.CHANGE));
        }
    }
}
