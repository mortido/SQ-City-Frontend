package com.github.mortido.sqcity
{
    import com.github.mortido.sqcity.resources.CachedResourceManager;
    import com.github.mortido.sqcity.ui.CityField;
    
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;

    [SWF(width = "800", height = "500", backgroundColor="0x00aa22", frameRate="30")]
    public class Main extends Sprite
    {
        public function Main()
        {
            // Initialize singltons.
            Game.instance.resourceManager = new CachedResourceManager();
            
            // Set stage params.
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;

            // Add ui components.
            addChild(new CityField(stage.stageWidth, stage.stageHeight));
        }
    }
}