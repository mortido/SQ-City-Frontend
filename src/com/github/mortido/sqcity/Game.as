package com.github.mortido.sqcity
{
    import com.github.mortido.sqcity.resources.IGameResourceManager;

    public final class Game
    {
        private static var _instance:Game;
        private var _resourceManager:IGameResourceManager;

        public function Game()
        {
            if(_instance){
                throw new Error("Singleton... use instance property.");
            }
        }

        public static function get instance() : Game
        {
            if(_instance==null)
            {
                _instance = new Game();
            }
            return _instance;
        }

        public function get resourceManager() : IGameResourceManager
        {
            return _resourceManager;
        }

        public function set resourceManager(rm:IGameResourceManager) : void
        {
            _resourceManager = rm;
        }
    }
}