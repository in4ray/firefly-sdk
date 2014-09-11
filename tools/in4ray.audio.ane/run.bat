set adt_directory=C:\Program Files\Adobe\Adobe Flash Builder 4.6\sdks\4.6.0\bin
set project_directory=d:\Projects\in4ray\ANE\audioANE\

set ane_library_project_directory=%project_directory%\AudioANELibrary
set android_project_directory=%project_directory%\AudioANENative
set ios_project_directory=%project_directory%\AudioANE-ios\build\Release
set default_project_directory=%project_directory%\AudioANEDefault

set signing_options=-storetype pkcs12 -keystore "in4ray-cert.p12" -storepass 111 -tsa none
set dest_ANE=AudioANE.ane

set extension_XML=%ane_library_project_directory%\src\extension.xml
set library_SWC=%ane_library_project_directory%\bin\AudioANELibrary.swc
set android_library_directory=%ane_library_project_directory%\bin\Android-ARM
set ios_library_directory=%ane_library_project_directory%\bin\iPhone-ARM

set default_library_directory=%default_project_directory%\bin\default

"%adt_directory%"/adt -package %signing_options% -target ane "%dest_ANE%" "%extension_XML%" -swc "%library_SWC%" -platform Android-ARM -C "%android_library_directory%" library.swf -C "%android_project_directory%" AudioANENative.jar -platform iPhone-ARM -C "%ios_library_directory%" library.swf  -C "%ios_project_directory%" libAudioANE-ios.a -platform default -C "%default_library_directory%" library.swf