package com.github.mortido.sqcity.resources
{
    import flash.display.Loader;
    import flash.utils.Dictionary;

    public class LoaderPool
    {
        private static var _instance:LoaderPool;

        public static function get instance():LoaderPool
        {
            if (_instance == null)
            {
                _instance = new LoaderPool();
            }

            return _instance;
        }

        private var _freeLoaders:Vector.<Loader> = new Vector.<Loader>();
        private var _activeLoaders:Dictionary = new Dictionary();

        public function checkout():Loader
        {
            var loader:Loader;
            if (_freeLoaders != null && _freeLoaders.length > 0)
            {
                return _freeLoaders.shift();
            }
            else
            {
                loader = new Loader();
            }
            _activeLoaders[loader] = loader;
            return loader;
        }

        public function checkin(loader:Loader):void
        {
            _activeLoaders[loader] = null;
            delete _activeLoaders[loader];
            _freeLoaders.push(loader);
        }
    }
}