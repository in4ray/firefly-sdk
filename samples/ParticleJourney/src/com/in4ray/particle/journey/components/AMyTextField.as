/**
 * Created by rzarich on 17.06.14.
 */
package com.in4ray.particle.journey.components
{
import com.firefly.core.components.TextField;
import com.firefly.core.components.helpers.LocalizationField;

public class AMyTextField extends TextField
{
    public function AMyTextField(localizationField:LocalizationField, fontName:String = "Verdana", fontSize:Number = 12, color:uint = 0, bold:Boolean = false)
    {
        super(localizationField, fontName, fontSize, color, bold);
    }

    public function onCountChange(val:int):void
    {
        text = val.toString();
        trace("Changed1: " + text);
    }
	
	public function onCountChange2(val:int):void
	{
		text = val.toString();
		trace("Changed2: " + text);
	}
}
}
