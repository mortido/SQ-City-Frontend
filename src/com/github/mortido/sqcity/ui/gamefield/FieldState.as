package com.github.mortido.sqcity.ui.gamefield
{
    public interface FieldState
    {
        function setup(cityField:GameField):void;

        function release():void;
    }
}
