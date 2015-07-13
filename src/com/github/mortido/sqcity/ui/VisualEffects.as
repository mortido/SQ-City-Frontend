package com.github.mortido.sqcity.ui
{
    import flash.filters.ColorMatrixFilter;
    import flash.filters.DropShadowFilter;

    public final class VisualEffects
    {
        public static var HOVERED_BUTTON_COLOR_MATRIX:Array = [1.1, 0, 0, 0, 0, // red
                                                               0, 1.1, 0, 0, 0, // green
                                                               0, 0, 1.1, 0, 0, // blue
                                                               0, 0, 0, 1, 0];  // alpha

        public static var PRESSED_BUTTON_COLOR_MATRIX:Array = [0.9, 0, 0, 0, 0, // red
                                                               0, 0.9, 0, 0, 0, // green
                                                               0, 0, 0.9, 0, 0, // blue
                                                               0, 0, 0, 1, 0];  // alpha

        public static var PRESSED_BUTTON_FILTERS:Array = [new DropShadowFilter(2, 45, 0x000000, 0.20, 0, 0, 1, 1, true),
            new ColorMatrixFilter(VisualEffects.PRESSED_BUTTON_COLOR_MATRIX)];

        public static var HOVERED_BUTTON_FILTERS:Array = [new ColorMatrixFilter(VisualEffects.HOVERED_BUTTON_COLOR_MATRIX)];
    }
}
