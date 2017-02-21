-- =============================================
-- Author:		Justin Gordon
-- Create date: 11.17.2015
-- Description:	Determines if the vehicle owner
--				is eligible for a new company
--				vehicle
-- =============================================
declare	@VehicleId		int,
		@IsPurchase	varchar(3),
		@PurchasePrice	varchar(8),
		@PurchaseDate	datetime;

--manually set the VehicleId to check
set	@VehicleId = 10;

--set @IsPurchased to the value of the column 'IsPurchased' based on the VehicleId set by @VehicleId
set @IsPurchase = (	select	IsPurchase
					from	dbo.Vehicle
					where	VehicleId = @VehicleId)

--check if vehicle was purchased or not
if(@IsPurchase = 'Yes')
	GOTO CHECK_PURCHASED_PRICE
else
	GOTO NOT_PURCHASED;

CHECK_PURCHASED_PRICE:
	--set @PurchasedPrice to value of the column 'PurchasedPrice' based on the VehicleId set by @VehicleId
	select @PurchasePrice = (	select	PurchasePrice
								from	dbo.Vehicle
								where	VehicleId = @VehicleId);

	--check if vehicle was under $30,000
	if(@PurchasePrice < 30000)
		GOTO CHECK_PURCHASE_DATE
	else
		GOTO NOT_UNDER_30000;

CHECK_PURCHASE_DATE:
	
	--set @PurchaseDate to value of 'PurchaseDate' based on the VehicleId set by @VehicleId
	set @PurchaseDate = (	select	PurchaseDate
							from	Vehicle
							where	VehicleId = @VehicleId)

	if(@PurchaseDate < '1/1/2011')
		GOTO ALLOW_PURCHASE
	else
		GOTO NOT_OLD_PURCHASE


--End of flow
ALLOW_PURCHASE:
	print	'You are eligible for a new vehicle. For more information, please speak with a fleet department manager.'
	GOTO EXIT_SECTION

NOT_PURCHASED:
	print	'Your current vehicle is not a purchase. To determine if you are able to receive a new company vehicle, please speak with a fleet department manager.'
	GOTO EXIT_SECTION

NOT_UNDER_30000:
	print	'Vehicle was over $30,000. Due to the money spent and the date of purchase, you are not elegible for a new vehicle at this time. For more information, please speak with a fleet department manager.'
	GOTO EXIT_SECTION

NOT_OLD_PURCHASE:
	print	'Your vehicle was purchased before 1/1/2012. You are not elegible for a new vehicle at this time. For more information, please speak with a fleet department manager.'
	GOTO EXIT_SECTION

EXIT_SECTION: