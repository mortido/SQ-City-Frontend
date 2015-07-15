package com.github.mortido.sqcity.ui
{
    import flash.display.Shape;

    public class Tile extends Shape
    {
        private static var XDIM:Number = 50;
        private static var YDIM:Number = 25;

        public function Tile(xSize:uint, ySize:uint, color:uint = 0x000000, alpha:Number = 1.0)
        {
            super();

            graphics.beginFill(color, alpha);
            graphics.moveTo(0, 0);
            var x:Number = XDIM * xSize;
            var y:Number = YDIM * xSize;
            graphics.lineTo(x, y);
            x -= ySize * XDIM;
            y += ySize * YDIM;
            graphics.lineTo(x, y);
            x -= xSize * XDIM;
            y -= xSize * YDIM;
            graphics.lineTo(x, y);
            graphics.lineTo(0, 0);
            graphics.endFill();
        }
    }
}
