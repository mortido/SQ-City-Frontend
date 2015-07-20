package com.github.mortido.sqcity.ui
{
    import com.github.mortido.sqcity.GameState;
    import com.github.mortido.sqcity.models.GameResources;
    import com.github.mortido.sqcity.resources.Assets;

    import flash.display.Sprite;

    public class ResourceWindow extends Sprite
    {
        private var label:ResourceLabel;
        private static var LABEL_OFFSET:Number = 6;

        public function ResourceWindow()
        {
            super();
            var gr:GameResources = GameState.instance.resources;
            label = new ResourceLabel(gr.coins, gr.energy, gr.population);
            label.x = LABEL_OFFSET;
            label.y = LABEL_OFFSET;
            addChild(label);
            update();
        }

        private function update():void
        {
            var w:Number = label.width + 2 * LABEL_OFFSET;
            var h:Number = label.height + 2 * LABEL_OFFSET;
            graphics.clear();
            graphics.beginFill(Assets.getColor("@color/windows_background"), 0.8);
            graphics.drawRect(0, 0, w, h);
            graphics.beginFill(Assets.getColor("@color/windows_border"), 0.8);
            graphics.drawRect(0, h, w, 1);
            graphics.drawRect(w, 0, 1, h + 1);
            graphics.endFill();
        }
    }
}
