package com.github.mortido.sqcity
{
    import com.github.mortido.sqcity.configuration.Config;
    import com.github.mortido.sqcity.models.Building;
    import com.github.mortido.sqcity.models.BuildingType;
    import com.github.mortido.sqcity.models.GameResources;
    import com.github.mortido.sqcity.resources.IGameResourceManager;

    public final class GameState
    {
        private static var _instance:GameState;

        public static function get instance():GameState
        {
            if (_instance == null)
            {
                _instance = new GameState();
            }
            return _instance;
        }

        public function GameState()
        {
            if (_instance)
            {
                throw new Error("Singleton... use instance property.");
            }
        }

        private var _resourceManager:IGameResourceManager;
        private var _config:Config;
        private var _resources:GameResources;
        private var _buildings:Vector.<Building>;
        private const COINS_SELL_MODIFIER:Number = 0.5;
        private const ENERGY_SELL_MODIFIER:Number = 1;
        private const POPULATION_SELL_MODIFIER:Number = 1;

        public function get resources():GameResources
        {
            return _resources;
        }

        public function set resources(value:GameResources):void
        {
            _resources = value;
        }

        public function get resourceManager():IGameResourceManager
        {
            return _resourceManager;
        }

        public function set resourceManager(rm:IGameResourceManager):void
        {
            _resourceManager = rm;
        }

        public function get config():Config
        {
            return _config;
        }

        public function set config(value:Config):void
        {
            _config = value;
        }

        public function get buildings():Vector.<Building>
        {
            return _buildings;
        }

        public function set buildings(buildings:Vector.<Building>):void
        {
            _buildings = buildings;
        }

        public function buildNew(x:int, y:int, type:BuildingType):Building
        {
            // TODO: Check resources.
            // TODO: Check place.

            // Create new building.
            var result:Building = new Building(x, y, type);
            _buildings.push(result);

            // Update resources.
            resources.add(type.coinsModifier, type.energyModifier, type.populationModifier);

            // TODO: Send request (updates ID).

            return result;
        }

        public function sellBuilding(building:Building):void
        {
            // TODO: Check that building exist.
            // Remove from memory.
            _buildings.splice(_buildings.indexOf(building), 1);
            // TODO: Update resources.
            var btype:BuildingType = building.type;
            _resources.add(-btype.coinsModifier*COINS_SELL_MODIFIER, -btype.energyModifier*ENERGY_SELL_MODIFIER, -btype.populationModifier*POPULATION_SELL_MODIFIER);
            // TODO: Send request.
        }

        public function moveBuilding(building:Building, newX:int, newY:int):void
        {
            // TODO: Check that building exist.
            // TODO: Check new place (except current building).
            // TODO: Move building coordinates.
            building.x = newX;
            building.y = newY;
            // TODO: Send request.
        }

        public function harvest(building:Building):void
        {
            // TODO: Check that building exist.
            // TODO: Check production exist.
            // TODO: Check production time.
            // TODO: Update resources.
            // TODO: Remove production OR start it again if it isAuto = true.
            // TODO: Send request.
        }

        public function startProduction(building:Building):void
        {
            // TODO: Check that building exist.
            // TODO: Check production can be start on this building.
            // TODO: Check that no other productions.
            // TODO: Update resources.
            // TODO: Add production to building.
            // TODO: Set finish time.
            // TODO: Send request to server.
        }
    }
}