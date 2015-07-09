/**
 * Created by Alexander on 7/10/2015.
 */
package com.github.mortido.sqcity.resources
{
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequest;
    import flash.utils.Dictionary;

    /**
     * The simple load manager for multiple loaders.
     * It doesn't handle progress event but caches each loaded content which is shared between clients
     * Content should be allowed by flash player security
     */
    public class SharedLoadManager
    {
        private static var _cache:Dictionary = new Dictionary;
        private static var _freeLoaders:Vector.<Loader>;
        private static var _activeLoaders:Dictionary = new Dictionary();
        private var _pendingHandlers:Dictionary = new Dictionary();

        /**
         * start load display object
         * @param uri
         * @param loadHandler function called when the load complete,
         * if the object with such uri already have been loaded the function called immediately
         * the function takes one parameter of type Object
         * (which is a loaded content) on success or null on load error
         */
        public function load(uri:String,loadHandler:Function):void
        {
            if(_cache[uri] != null)
            {
                loadHandler(_cache[uri]);
                return;
            }

            if(_pendingHandlers[uri] == null)
            {
                _pendingHandlers[uri] = new Vector.<Function>;
            }
            _pendingHandlers[uri].push(loadHandler);

            if(_activeLoaders[uri] == null)
            {
                var loader:Loader = getLoader();
                _activeLoaders[loader] = uri;
                loader.load(new URLRequest(uri));
            }
        }

        /**
         * cancel the loading which was previously initiated by the load() method
         * @param uri
         * @param loadHandler
         */
        public function cancel(uri:String, loadHandler:Function):void
        {
            if(_pendingHandlers[uri] != null)
            {
                for (var i:int=0;i<_pendingHandlers[uri].length;i++)
                {
                    if(_pendingHandlers[uri][i] == loadHandler)
                    {
                        _pendingHandlers[uri].splice(i,1);
                        break;
                    }
                }
                if(_pendingHandlers[uri].length == 0)
                {
                    _activeLoaders[uri].close();
                    _activeLoaders[uri] = null;
                    delete _activeLoaders[uri];
                }
            }
        }

        /**
         * remove cached objects and free loaders
         * @param disposeLoaders if false than loaders doesn't disposed
         */
        public function clearCache(disposeLoaders:Boolean = true):void
        {
            for (var uri:String in _cache)
            {
                _cache[uri] = null;
                delete _cache[uri];
            }
            if(disposeLoaders && _freeLoaders != null)
            {
                while(_freeLoaders.length)
                {
                    _freeLoaders.shift();
                }
            }
        }

        private function getLoader():Loader
        {
            if(_freeLoaders != null && _freeLoaders.length > 0)
            {
                return _freeLoaders.shift();
            }
            var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeLoadHandler);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorLoadHandler);
            return loader;
        }

        private function errorLoadHandler(event:IOErrorEvent):void
        {
            handleResult(LoaderInfo(event.target));
        }

        private function completeLoadHandler(event:Event):void
        {
            handleResult(LoaderInfo(event.target));
        }

        private function handleResult(loaderInfo:LoaderInfo):void
        {
            var uri:String = _activeLoaders[loaderInfo.loader];
            var handlers:Vector.<Function> = _pendingHandlers[uri];
            if(handlers != null)
            {
                while(handlers.length)
                {
                    var handler:Function = handlers.shift();
                    handler(loaderInfo.content);
                }
                _pendingHandlers[uri] = null;
                delete _pendingHandlers[uri];
            }
            if(loaderInfo.content)
            {
                _cache[uri] = loaderInfo.content;
                loaderInfo.loader.unload();
            }
            _activeLoaders[loaderInfo.loader] = null;
            delete _activeLoaders[loaderInfo.loader];
            if(_freeLoaders == null)
            {
                _freeLoaders = new Vector.<Loader>;
            }
            _freeLoaders.push(loaderInfo.loader);
        }
    }
}
