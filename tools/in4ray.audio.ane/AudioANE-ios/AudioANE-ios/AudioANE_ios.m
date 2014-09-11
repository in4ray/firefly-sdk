#include "FlashRuntimeExtensions.h"

// Sound
FREObject init(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    return NULL;
}

FREObject loadSound(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    return NULL;
}

FREObject unloadSound(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    return NULL;
}

FREObject playSound(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    return NULL;
}

FREObject stopSound(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    return NULL;
}

FREObject pauseSound(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    return NULL;
}

FREObject setSoundVolume(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    return NULL;
}

// Music
FREObject loadMusic(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    return NULL;
}

FREObject unloadMusic(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    return NULL;
}

FREObject playMusic(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    return NULL;
}

FREObject stopMusic(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    return NULL;
}

FREObject setMusicVolume(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    return NULL;
}

FREObject isMusicPlaying(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    return NULL;
}


void AudioContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest,const FRENamedFunction** functionsToSet){
    
    *numFunctionsToTest = 13;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * *numFunctionsToTest);
                                                        
    func[0].name = (const uint8_t*) "init";
    func[0].functionData = NULL;
    func[0].function = &init;
                                                        
    func[1].name = (const uint8_t*) "loadSound";
    func[1].functionData = NULL;
    func[1].function = &loadSound;
    
    func[2].name = (const uint8_t*) "unloadSound";
    func[2].functionData = NULL;
    func[2].function = &unloadSound;
    
    func[3].name = (const uint8_t*) "playSound";
    func[3].functionData = NULL;
    func[3].function = &playSound;
    
    func[4].name = (const uint8_t*) "stopSound";
    func[4].functionData = NULL;
    func[4].function = &stopSound;
    
    func[5].name = (const uint8_t*) "pauseSound";
    func[5].functionData = NULL;
    func[5].function = &pauseSound;
    
    func[6].name = (const uint8_t*) "setSoundVolume";
    func[6].functionData = NULL;
    func[6].function = &setSoundVolume;
    
    func[7].name = (const uint8_t*) "loadMusic";
    func[7].functionData = NULL;
    func[7].function = &loadMusic;
    
    func[8].name = (const uint8_t*) "unloadMusic";
    func[8].functionData = NULL;
    func[8].function = &unloadMusic;
    
    func[9].name = (const uint8_t*) "playMusic";
    func[9].functionData = NULL;
    func[9].function = &playMusic;
    
    func[10].name = (const uint8_t*) "stopMusic";
    func[10].functionData = NULL;
    func[10].function = &stopMusic;
    
    func[11].name = (const uint8_t*) "setMusicVolume";
    func[11].functionData = NULL;
    func[11].function = &setMusicVolume;
        
    func[12].name = (const uint8_t*) "isMusicPlaying";
    func[12].functionData = NULL;
    func[12].function = &isMusicPlaying;
    
    *functionsToSet = func;
}

void AudioExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet){
    *extDataToSet = NULL;
    *ctxInitializerToSet = &AudioContextInitializer;
}

void AudioExtensionFinalizer(void** extDataToSet){
    return;
}

