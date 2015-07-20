package com.github.mortido.sqcity.models
{
    import flash.events.Event;
    import flash.events.EventDispatcher;

    public class GameResources extends EventDispatcher
    {
        public function GameResources(coins:int, energy:int, population:int)
        {
            _coins = coins;
            _energy = energy;
            _population = population;
        }

        private var _coins:int;
        private var _energy:int;
        private var _population:int;

        public function get coins():int
        {
            return _coins;
        }

        public function get energy():int
        {
            return _energy;
        }

        public function get population():int
        {
            return _population;
        }

        public function add(coins:int, energy:int, population:int):void
        {
            _coins += coins;
            _energy += energy;
            _population += population;
            dispatchEvent(new Event(Event.CHANGE));
        }

        /**
         * Checks that we can apply specified resource modifiers.
         * @param coins Coins modifier (can be negative if it cost).
         * @param energy Energy modifier (can be negative if it cost).
         * @param population Population modifier (can be negative if it cost).
         * @return true if modifiers can be applied; otherwise - false.
         */
        public function checkModifiers(coins:int, energy:int, population:int):Boolean
        {
            return _coins + coins >= 0 &&
                    _energy + energy >= 0 &&
                    _population + population >= 0;
        }
    }
}
