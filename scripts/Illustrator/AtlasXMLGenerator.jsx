doc = app.activeDocument;
var win = new Window("dialog", "Atlas Generator");
win.browsePnl = win.add("panel", [10, 10, 440, 100]);
win.browsePnl.add("statictext", [30, 10, 250, 30], "Add FXG files to generate atlas.");
win.browsePnl.filesLabel = win.browsePnl.add("statictext", [30, 47, 150, 80], "Files added:");
win.browsePnl.addButton = win.browsePnl.add("button", [300, 40 , 400, 70], "Add Files");
win.generatePnl = win.add("panel", [10, 110, 440, 200]);
win.generatePnl.add("statictext", [30, 10, 250, 30], "Generate FXG atlas");
win.generatePnl.fileNameLabel = win.generatePnl.add("statictext", [30, 47, 150, 80], "File name:" + doc.fullName.name.split(".")[0] + ".xml");
win.generatePnl.generateButton = win.generatePnl.add("button", [300, 40 , 400, 70], "Generate");
       
win.browsePnl.addButton.onClick = function ()
{
    importFiles(getFiles());
};     
win.generatePnl.generateButton .onClick = generateAtlas;

updateNumberOfFiles();
win.show();
 
  
function updateNumberOfFiles() 
{
    win.browsePnl.filesLabel.text = "Files added: "  + doc.layers[0].placedItems.length;
}
 
function getFiles() 
{
	return File.openDialog('Please select the files to be imported:', "*.fxg", true);
}

function importFiles(selectedFiles) 
{	
    selectedFiles = [].concat( selectedFiles );
    for(var i=0;i<selectedFiles.length;i++)    
    {
        processFile(selectedFiles[i]);
    }

    updateNumberOfFiles();
}

function processFile(selectedFile) 
{	
   fileDocument= app.open(selectedFile);
   assetFolder = getExtFolder();
    if(!assetFolder.exist)
        assetFolder.create();
   
   pngFilePath = assetFolder.absoluteURI + "/" + selectedFile.name + ".png";
   opt = new ExportOptionsPNG24();
   opt.artBoardClipping = true;
   fileDocument.exportFile (new File(pngFilePath), ExportType.PNG24, opt);
   fileDocument.close(SaveOptions.DONOTSAVECHANGES);
   
   importFileIntoLayer(new File(pngFilePath));
}

function getExtFolder() 
{  
    docUrl = doc.fullName.absoluteURI;
    parts = docUrl.split("/");
    docUrl = docUrl.substr (0, docUrl.length-parts[parts.length-1].length) + doc.name.split(".")[0] + ".assets";
    return new Folder (docUrl);
}

function importFileIntoLayer(pngFile) 
{	
    firstLayer = app.activeDocument.layers[0]; 
    itemName = pngFile.name.substring(0, pngFile.name.indexOf(".") );    

    var thisPlacedItem;
    for(var i=0;i<firstLayer.placedItems.length;i++)    
    {
        if(firstLayer.placedItems[i].name == itemName)
        {
            thisPlacedItem = firstLayer.placedItems[i];
            break;
        }
    }
    
    if(thisPlacedItem  == null)
        thisPlacedItem = firstLayer.placedItems.add();
        
    thisPlacedItem.file = pngFile;
    thisPlacedItem.name = itemName;
}

function generateAtlas() 
{
    layers = doc.layers;
    artboardRect = doc.artboards[0].artboardRect;

    code = "";
    xml = new XML("<TextureAtlas/>")
    for(var i=0;i<layers.length;i++)
    {
        placedItems = layers[i].placedItems;
        for(var j=0;j<placedItems.length;j++)
        {  
            bounds = placedItems[j].geometricBounds;
          
             x = bounds[0]-artboardRect[0];
             y = -bounds[1]+artboardRect[1];
             w = bounds[2] - x - artboardRect[0];
             h = -bounds[3] - y + artboardRect[1];
             itemName = (placedItems[j].name != 0)  ?  placedItems[j].name : "Group" + j;
             
             subXML = new XML("<SubTexture name='" +itemName +
                                                              "' x='" + x  +  
                                                              "' y='" + y  +
                                                              "' width='" + w  +
                                                              "' height='" + h  +
                                                              "' frameX='0' frameY='0" +
                                                              "' frameWidth='" + w  +
                                                              "' frameHeight='" + h +
                                                                "'/>");
             
             code += "public function get " +  itemName.substr(0, 1).toLowerCase() + itemName.substr(1, itemName.length-1) + "():Texture{ return getTextureAtlas(" + doc.name.split(".")[0] + ").getTexture(\"" + itemName + "\"); } \n";
             
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
}