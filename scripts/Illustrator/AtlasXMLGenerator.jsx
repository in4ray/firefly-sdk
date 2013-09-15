doc = app.activeDocument;
layers = doc.layers;

code = "";
xml = new XML("<TextureAtlas/>")
for(var i=0;i<layers.length;i++)
{
    groupItems = layers[i].groupItems;
    for(var j=0;j<groupItems.length;j++)
    {
        grp = groupItems[j];
        bounds = grp.visibleBounds;
        for(k = grp.pathItems.length - 1; k >=0; k--){
            if(grp.pathItems[k].typename == "PathItem" && grp.pathItems[k].clipping) 
                  bounds = grp.pathItems[k].visibleBounds;       
         }            
         
         x = bounds[0];
         y = -bounds[1];
         w = bounds[2] - x;
         h = -bounds[3] - y;
         grpName = (grp.name != 0)  ?  grp.name : "Group" + j;
         
         subXML = new XML("<SubTexture name='" +grpName +
                                                          "' x='" + x  +  
                                                          "' y='" + y  +
                                                          "' width='" + w  +
                                                          "' height='" + h  +
                                                          "' frameX='0' frameY='0" +
                                                          "' frameWidth='" + w  +
                                                          "' frameHeight='" + h +
                                                            "'/>");
         
         code += "public function get " +  grpName.substr(0, 1).toLowerCase() + grpName.substr(1, grpName.length-1) + "():Texture{ return getTextureAtlas(" + doc.name.split(".")[0] + ").getTexture(\"" + grpName + "\"); } \n";
         
         xml.appendChild(subXML);
    }
}

xmlPath = doc.fullName.absoluteURI;
parts = xmlPath.split(".");
xmlPath= "";
for(var i=0;i<parts.length-1;i++)
{
    xmlPath += parts[i];
}

xmlPath += ".xml";
file = new File (xmlPath);
file.open("w");
saved=file.writeln(xml.toXMLString() + "\n <!--\n" + code + "-->");
file.close();

if(saved)
    Window.alert(xmlPath + " was saved.");
else
    Window.alert(xmlPath + " was not saved!");
