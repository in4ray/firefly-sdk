/**
 * Created by rzarich on 18.06.14.
 */
package com.firefly.core.utils
{
import flash.utils.Dictionary;

public class WeakRef
{
    private var _ref:Dictionary;

    public function WeakRef(obj:*)
    {
        _ref = new Dictionary(true);
        _ref[obj] = true;
    }

    public function get():*
    {
        for (var item:* in _ref )
        {
            return item;
        }
        return null;
    }
}
}
