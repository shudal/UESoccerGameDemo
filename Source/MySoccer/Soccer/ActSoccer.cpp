// Fill out your copyright notice in the Description page of Project Settings.


#include "Soccer/ActSoccer.h"

#include "Kismet/KismetMathLibrary.h"

// Sets default values
AActSoccer::AActSoccer()
{
 	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
	PrimaryActorTick.bCanEverTick = true;

}

// Called when the game starts or when spawned
void AActSoccer::BeginPlay()
{
	Super::BeginPlay();
	
}

// Called every frame
void AActSoccer::Tick(float DeltaTime)
{
	Super::Tick(DeltaTime);
 
/*
	auto nowdis=GetVelocity()*DeltaTime;

	if (bRotInTick && nowdis.Size() > 10)
	{
		
		const float r=0.15;
		auto degx=nowdis.X / r;
		auto degy=nowdis.Y / r;

	
		degx *= (360/UKismetMathLibrary::GetPI());
		degy *= (360/UKismetMathLibrary::GetPI());

		degx = degx - ((int)(degx/360))*360;
		degy = degy - ((int)(degy/360))*360;
	
		auto q1=UKismetMathLibrary::MakeRotator(degx,0,0).Quaternion();
		auto q2=UKismetMathLibrary::MakeRotator(degy,0,0).Quaternion();

		auto nowrot=GetActorRotation().Quaternion();
		auto newrot=q1*q2*nowrot;
		
		SetActorRotation(newrot,ETeleportType::TeleportPhysics);
	}

	if (bConstraintZ)
	{ 
		auto nowloc=GetActorLocation();
		if (nowloc.Z > 16.1)
		{
			nowloc.Z = 16;
			SetActorLocation(nowloc,false,nullptr,ETeleportType::TeleportPhysics);
		}
	}
	*/
}
/*
void AActSoccer::f1()
{
	auto q1=UKismetMathLibrary::MakeRotator(45,0,0).Quaternion();
	auto nowrot=GetActorRotation().Quaternion();
	auto newrot=q1*nowrot;
	SetActorRotation(newrot,ETeleportType::TeleportPhysics);
}
void AActSoccer::f2()
{
	auto q1=UKismetMathLibrary::MakeRotator(0,45,0).Quaternion();
	auto nowrot=GetActorRotation().Quaternion();
	auto newrot=q1*nowrot;
	SetActorRotation(newrot,ETeleportType::TeleportPhysics);
}
void AActSoccer::f3()
{
	auto q1=UKismetMathLibrary::MakeRotator(45,0,0).Quaternion();
	auto q2=UKismetMathLibrary::MakeRotator(0,45,0).Quaternion();
	auto nowrot=GetActorRotation().Quaternion();
	auto newrot=q1*q2*nowrot;
	SetActorRotation(newrot,ETeleportType::TeleportPhysics);
}
*/