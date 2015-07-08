package com.github.mortido.sqcity.ui
{
    import flash.display.Sprite;
    
    public class BuildingSprite extends Sprite
    {
        private var _fieldX : Number;
        private var _fieldY : Number;

        /**
        * Represent building type (e.g. "factory").
        */
        private var _type:String;

        public function BuildingSprite(buildingType:String)
        {
            super();
            
            _type = buildingType;
            
            // TODO List:
            // Field width and length <- from building Type.
            // Child Bitmap.
            // Bitmap reference point (x, y).
            
            // Click not on sprite, but use grid... maybe we shood pass this event from field.
            
            // TODO List 2:
            // Show status.
            // Show production buttons (if exist).
            // Production button click handler.
            // Sell button?
            // Click handler depends on state (pattern).
        }
        
        public function get type(): String
        {
            return _type;
        }
        
        public function get fieldX(): Number
        {
            return _fieldX;
        }
        
        public function get fieldY(): Number
        {
            return _fieldY;
        }
        
        public function set fieldX(x:Number) : void
        {
            _fieldX = x;
        }
        
        public function set fieldX(y:Number) : void
        {
            _fieldY = y;
        }
    }
}