
function getFiles() 
{
	return File.openDlg('Please select the files to be imported:', "*.fxg", true);
}

function importFiles(selectedFiles) 
{	
    selectedFiles = [].concat( selectedFiles );
    for(var i=0;i<selectedFiles.length;i++)    
    {
        processFile(selectedFiles[i]);
    }
}

function processFile(selectedFile) 
{	
   fileDocument= app.open(selectedFile);
   pngFilePath = new File(replaceExtension(selectedFile, "png"));
   opt = new ExportOptionsPNG24();
   opt.artBoardClipping = true;
   fileDocument.exportFile (new File(pngFilePath), ExportType.PNG24, opt);
   fileDocument.close(SaveOptions.DONOTSAVECHANGES);
   
   importFileIntoLayer(new File(pngFilePath));
}

function replaceExtension(selectedFile, ext) 
{   
    parts = selectedFile.absoluteURI.split(".");
    return selectedFile.absoluteURI.substr (0, selectedFile.absoluteURI.length-parts[parts.length-1].length) +  ext;
}

function importFileIntoLayer(pngFile) 
{	
    firstLayer = app.activeDocument.layers[0]; 
    itemName = pngFile.name.substring(0, pngFile.name.indexOf(".") );    

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

importFiles(getFile());