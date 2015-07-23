/**
 * Created by Alexander on 7/13/2015.
 */
package com.github.mortido.sqcity.ui
{
    import com.github.mortido.sqcity.resources.Assets;

    import flash.display.Sprite;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

    import mx.core.FlexTextField;

    public class ResourceLabel extends Sprite
    {
        private const DELIMITER:String = " / ";

        public function ResourceLabel(coins:int = 0, energy:int = 0, population:int = 0, textSize:Number = 15, showPlus:Boolean = false)
        {
            _coins = coins;
            _energy = energy;
            _population = population;
            _modifiersMode = showPlus;

            defaultFormat = new TextFormat("helvetica", textSize, Assets.getColor("@color/resource_delimiter"), true);
            coinsFormat = new TextFormat("helvetica", textSize, Assets.getColor("@color/coins"), true);
            energyFormat = new TextFormat("helvetica", textSize, Assets.getColor("@color/energy"), true);
            populationFormat = new TextFormat("helvetica", textSize, Assets.getColor("@color/population"), true);

            _textField = new FlexTextField();
            _textField.defaultTextFormat = defaultFormat;
            _textField.autoSize = TextFieldAutoSize.LEFT;
            _textField.selectable = false;
            addChild(_textField);

            update();
        }

        private var _coins:int;
        private var _energy:int;
        private var _textField:FlexTextField;
        private var defaultFormat:TextFormat;
        private var coinsFormat:TextFormat;
        private var energyFormat:TextFormat;
        private var populationFormat:TextFormat;
        private var _modifiersMode:Boolean;
        private var _population:int;

        public function setValues(coins:int, energy:int, population:int):void
        {
            _coins = coins;
            _energy = energy;
            _population = population;
            update();
        }

        public function get coins():int
        {
            return _coins;
        }

        public function set coins(value:int):void
        {
            _coins = value;
            update();
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

        private function formatValue(value:int):String
        {
            if (_modifiersMode)
            {
                if (value == 0)
                {
                    return " - ";
                }

                if (value > 0)
                {
                    return "+" + value.toString();
                }
            }

            return value.toString();
        }

        private function update():void
        {
            var coinsStr:String = formatValue(_coins);
            var energyStr:String = formatValue(_energy);
            var populationStr:String = formatValue(_population);

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
    }
}
