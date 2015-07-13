/**
 * Created by Alexander on 7/13/2015.
 */
package com.github.mortido.sqcity.ui
{
    import com.github.mortido.sqcity.resources.Assets;

    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

    import mx.core.FlexTextField;

    public class ResourceLabel extends Sprite
    {
        private static var DELIMITER:String = " / ";

        private var _coins:int;
        private var _energy:int;
        private var _textField:FlexTextField;

        private var defaultFormat:TextFormat;
        private var coinsFormat:TextFormat;
        private var energyFormat:TextFormat;
        private var populationFormat:TextFormat;

        public function ResourceLabel(coins:int = 0, energy:int = 0, population:int = 0, textSize:Number = 15)
        {
            _coins = coins;
            _energy = energy;
            _population = population;

            defaultFormat = new TextFormat("helvetica", textSize, Assets.getColor("@color/resource_delimiter"), true);
            coinsFormat = new TextFormat("helvetica", textSize, Assets.getColor("@color/coins"), true);
            energyFormat = new TextFormat("helvetica", textSize, Assets.getColor("@color/energy"), true);
            populationFormat = new TextFormat("helvetica", textSize, Assets.getColor("@color/population"), true);

            _textField = new FlexTextField();
            _textField.defaultTextFormat = defaultFormat;
            _textField.autoSize = TextFieldAutoSize.LEFT;
            _textField.selectable = false;
            addChild(_textField);

            addEventListener(MouseEvent.CLICK, toggleToolbox, false, 0, true);

            update();
        }

        private function toggleToolbox(event:MouseEvent):void
        {
            this.coins /= 10;
        }

        private var _population:int;

        public function get coins():int
        {
            return _coins;
        }

        public function set coins(value:int):void
        {
            _coins = value;
            update();
        }

        private function update():void
        {
            var coinsStr:String = _coins.toString();
            var energyStr:String = _energy.toString();
            var populationStr:String = _population.toString();
            _textField.text = coinsStr + DELIMITER + energyStr + DELIMITER + populationStr;
            var p1:int = 0;
            var p2:int = coinsStr.length;
            _textField.setTextFormat(coinsFormat, p1, p2);
            p2 += DELIMITER.length;
            p1 = p2;
            p2 += energyStr.length;
            _textField.setTextFormat(energyFormat, p1, p2);
            p2 += DELIMITER.length;
            p1 = p2;
            p2 += populationStr.length;
            _textField.setTextFormat(populationFormat, p1, p2);
        }

        public function get energy():int
        {
            return _energy;
        }

        public function set energy(value:int):void
        {
            _energy = value;
            update();
        }

        public function get population():int
        {
            return _population;
        }

        public function set population(value:int):void
        {
            _population = value;
            update();
        }
    }
}
