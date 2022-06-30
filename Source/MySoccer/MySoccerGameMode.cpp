// Copyright Epic Games, Inc. All Rights Reserved.

#include "MySoccerGameMode.h"
#include "MySoccerPlayerController.h"
#include "MySoccerCharacter.h"
#include "UObject/ConstructorHelpers.h"

AMySoccerGameMode::AMySoccerGameMode()
{
	// use our custom PlayerController class
	PlayerControllerClass = AMySoccerPlayerController::StaticClass();

	// set default pawn class to our Blueprinted character
	static ConstructorHelpers::FClassFinder<APawn> PlayerPawnBPClass(TEXT("/Game/TopDownCPP/Blueprints/TopDownCharacter"));
	if (PlayerPawnBPClass.Class != nullptr)
	{
		DefaultPawnClass = PlayerPawnBPClass.Class;
	}
}