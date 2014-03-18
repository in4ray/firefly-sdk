/**********************************************************

in4ray 
Copyright 2012-2013 in4ray 
All Rights Reserved 

NOTICE:  in4ray permits you to use, modify, and 
distribute this file in accordance with the terms
of the in4ray license agreement accompanying it.  
If you have received this file from a source 
other than in4ray, then your use, modification,
or distribution of it requires the prior 
written permission of in4ray. 

*********************************************************/

/**********************************************************
 
SaveArtboardsAsFXG.jsx

DESCRIPTION

Saves the artboards to FXG and named resuluted files according to 
names of artboards.
 
**********************************************************/
var docRef = app.activeDocument;
	
// Save the artboards to FXG.
var i, 
	destFile,
	fxgSaveOptions,
	destFolder = Folder.selectDialog('Select the folder to save the FXG files to:');

if (destFolder && docRef.artboards.length > 0) {
	for (i=0; i<docRef.artboards.length; i++)
	{
		destFile = new File(destFolder + '/' + docRef.artboards[i].name);
		fxgSaveOptions = new FXGSaveOptions();
		fxgSaveOptions.saveMultipleArtboards = true;
		fxgSaveOptions.artboardRange = String(i+1);
		docRef.saveAs(destFile,  fxgSaveOptions);	
	}
}	

