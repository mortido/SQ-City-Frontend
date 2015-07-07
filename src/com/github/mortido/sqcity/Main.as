package com.github.mortido.sqcity
{
    import as3isolib.display.IsoSprite;
    import as3isolib.display.IsoView;
    import as3isolib.display.scene.IsoGrid;
    import as3isolib.display.scene.IsoScene;
    import as3isolib.geom.Pt;
    import as3isolib.graphics.Stroke;
    
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import flash.net.URLRequest;
    import flash.text.TextField;
    import flash.text.TextFormat;
    
    import org.osmf.layout.ScaleMode;
    
    import ui.CityField;
    
    [SWF(width = "800", height = "500", backgroundColor="0x00aa22", frameRate="30")]
    public class Main extends Sprite
    {

        public function Main()
        {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;

            addChild(new CityField(stage.stageWidth, stage.stageHeight));
        }
    }
}