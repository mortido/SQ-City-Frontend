package com.github.mortido.sqcity.resources
{
    import flash.utils.Dictionary;

    public class Assets
    {
        [Embed(source="../../../../../../assets/stub.png")]
        public static var StubImage:Class;

        private static var strings:Dictionary = null;
        private static var colors:Dictionary = null;

        private static function initStrings():void
        {
            strings = new Dictionary();
            strings["@string/move_btn_text"] = "Move";
            strings["@string/sell_btn_text"] = "Sell";
        }

        private static function initColors():void
        {
            colors = new Dictionary();
            colors["@color/coins"] = 0x1f6d00;//0xccff00;
            colors["@color/energy"] = 0x00bbff;
            colors["@color/population"] = 0xff00ff;
            colors["@color/resource_delimiter"] = 0x555522;
            colors["@color/windows_background"] = 0xe0e0d2;
            colors["@color/windows_border"] = 0xbab9ae;
            colors["@color/shadow"] = 0x000000;
            colors["@color/move_btn"] = 0x4c6fe0;
            colors["@color/move_btn_text"] = 0xfff5d1;
            colors["@color/sell_btn"] = 0xe0b14c;
            colors["@color/sell_btn_text"] = 0xd1e7ff;
            colors["@color/guide_sprite_fitted"] = 0x00ff33;
            colors["@color/guide_sprite_not_fitted"] = 0xff3300;

        }

        public static function getStringResource(id:String):String
        {
            if (strings == null)
            {
                initStrings();
            }

            if (strings[id] == null)
            {
                throw new Error("There is no string with id: \"" + id + "\"");
            }

            return strings[id];
        }

        public static function getColor(id:String):uint
        {
            if (colors == null)
            {
                initColors();
            }

            if (colors[id] == null)
            {
                throw new Error("There is no color with id: \"" + id + "\"");
            }

            return colors[id];
        }
    }
}