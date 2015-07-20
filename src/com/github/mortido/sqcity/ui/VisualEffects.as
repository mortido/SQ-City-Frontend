package com.github.mortido.sqcity.ui
{
    import com.github.mortido.sqcity.resources.Assets;

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

        public static var DISABLED_BUTTON_COLOR_MATRIX:Array = [1 / 3, 1 / 2, 1 / 6, 0, 0, // red
            1 / 3, 1 / 2, 1 / 6, 0, 0, // green
            1 / 3, 1 / 2, 1 / 6, 0, 0, // blue
            0, 0, 0, 1, 0];  // alpha

        public static var PRESSED_BUTTON_FILTERS:Array = [new DropShadowFilter(2, 45, Assets.getColor("@color/shadow"), 0.20, 0, 0, 1, 1, true),
            new ColorMatrixFilter(VisualEffects.PRESSED_BUTTON_COLOR_MATRIX)];

        public static var HOVERED_BUTTON_FILTERS:Array = [new ColorMatrixFilter(VisualEffects.HOVERED_BUTTON_COLOR_MATRIX)];

        public static var DISABLED_BUTTON_FILTERS:Array = [new ColorMatrixFilter(VisualEffects.DISABLED_BUTTON_COLOR_MATRIX)];
    }
}
