package com.github.mortido.sqcity
{
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;

    import com.github.mortido.sqcity.ui.CityField;

    [SWF(width = "800", height = "500", backgroundColor="0x00aa22", frameRate="30")]
    public class Main extends Sprite
    {

        public function Main()
        {
            // Initialize singltons.
            
            
            // Seyt stage params.
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;

            // Add ui components.
            addChild(new CityField(stage.stageWidth, stage.stageHeight));
        }
    }
}