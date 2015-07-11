package com.github.mortido.sqcity
{
    import com.github.mortido.sqcity.configuration.Config;
    import com.github.mortido.sqcity.configuration.ImageInfo;
    import com.github.mortido.sqcity.events.LoginEvent;
    import com.github.mortido.sqcity.models.Building;
    import com.github.mortido.sqcity.models.BuildingType;
    import com.github.mortido.sqcity.models.GameResources;
    import com.github.mortido.sqcity.models.Production;
    import com.github.mortido.sqcity.resources.CachedResourceManager;
    import com.github.mortido.sqcity.ui.CityField;
    import com.github.mortido.sqcity.ui.ToolBox;

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;

    [SWF(width="800", height="500", backgroundColor="0x00aa22", frameRate="30")]
    public class Main extends Sprite
    {
        public function Main()
        {
            // Set stage params.
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;

            // Show Login screen.

            // TODO: STUB.
            var config:Config = new Config();
            config.imageInfos["@image/field"] = new ImageInfo("../../../Dropbox/Public/sq/field.jpg", 539, 74);
            config.imageInfos["@image/building/factory"] = new ImageInfo("../../../Dropbox/Public/sq/factory.png", 109, 52);
            config.imageInfos["@image/building/house"] = new ImageInfo("../../../Dropbox/Public/sq/house.png", 60, 38);
            config.imageInfos["@image/building/wind_power"] = new ImageInfo("../../../Dropbox/Public/sq/wind_power.png", 52, 76);
            config.imageInfos["@image/contract/factory1"] = new ImageInfo("../../../Dropbox/Public/sq/contract_1.png", 0, 0);
            config.imageInfos["@image/contract/factory2"] = new ImageInfo("../../../Dropbox/Public/sq/contract_2.png", 0, 0);
            config.imageInfos["@image/toolbox"] = new ImageInfo("../../../Dropbox/Public/sq/toolbox.png", 25, 25);
            config.buildingTypes["factory"] = new BuildingType(-30, -20, -10, 2, 2, "factory", new <Production>[new Production(false, 5, 0, 0, 30, 0, 0, 5 * 60, 1), new Production(false, 10, 0, 0, 50, 0, 0, 15 * 60, 2)]);
            config.buildingTypes["house"] = new BuildingType(-20, -10, 0, 1, 1, "house", new <Production>[new Production(true, 0, 0, 0, 0, 0, 10, 5 * 60, 3)]);
            config.buildingTypes["wind_power"] = new BuildingType(-50, 50, 0, 1, 1, "wind_power", new <Production>[]);
            var buildings:Vector.<Building> = new <Building>[
                new Building(5,0,1,config.buildingTypes["factory"]),
                new Building(0,0,2,config.buildingTypes["house"]),
                new Building(7,6,3,config.buildingTypes["wind_power"])];
            var resources:GameResources = new GameResources(100, 100, 100);

            onLogin(new LoginEvent(buildings, "TestUser", resources, config, "OnLogin"));
        }

        public function onLogin(e:LoginEvent):void
        {
            // Initialize game singleton.
            var game:Game = Game.instance;
            game.resourceManager = new CachedResourceManager();
            game.config = e.config;
            game.buildings = e.buildings;
            game.resources = e.resources;

            // TODO: Hide login screen.

            // Create City Field.
            addChild(new CityField(stage.stageWidth, stage.stageHeight));

            // TODO: Add resource window.

            // TODO: Add contracts window.

            // TODO: Add build panel.
            var tb:ToolBox = new ToolBox();
            tb.y = stage.stageHeight;
            addChild(tb);
        }
    }
}