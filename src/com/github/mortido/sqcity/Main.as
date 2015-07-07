package com.github.mortido.sqcity
{
    import as3isolib.display.IsoView;
    import as3isolib.display.scene.IsoGrid;
    import as3isolib.display.scene.IsoScene;
    import as3isolib.graphics.Stroke;
    
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import flash.text.TextFormat;
    
    [SWF(width = "800", height = "600", backgroundColor="0x000000", frameRate="30")]
    public class Main extends Sprite
    {
        // From given tile images:
        // sqrt(100^2+50^2)
        private static const CELL_SIZE: Number = 112;
        private var grid:IsoGrid;
        private var scene:IsoScene;
        private var view:IsoView;

        public function Main()
        {
            grid = new IsoGrid();
            grid.setGridSize(10,10,1);
            
            grid.gridlines = new Stroke(1, 0xeeeeee);
            grid.showOrigin = false;
            grid.cellSize = CELL_SIZE*1.1;
            
            scene = new IsoScene();
            scene.addChild(grid);
            scene.render();
            
            view = new IsoView();
            view.setSize(stage.stageWidth, stage.stageHeight);
            view.addScene(scene);
            
            addChild(view);
        }
    }
}