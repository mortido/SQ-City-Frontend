package com.github.mortido.sqcity.resources
{
    import flash.utils.Dictionary;

    public class Assets
    {
        [Embed(source="../../../../../../assets/stub.png")]
        public static var StubImage:Class;

        private static var strings:Dictionary = null;

        private static function initStrings():void
        {
            strings = new Dictionary();
            strings["@string/move_btn_text"] = "Move";
            strings["@string/sell_btn_text"] = "Sell";
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
    }
}