create table dbo.Drawing(
	DrawingId		int not null identity(1,1),
	DrawingDate		datetime null,
	Jackpot			int null,
	GameId			int not null
);


create table dbo.Game(
	GameId			int not null identity(1,1),
	GameName		varchar(50) not null,
	GameDescription	varchar(2000) null,
	Cost			int null,
	HowToPlay		varchar(2000) null,
	NumberOfBalls	int null,
	IsSpecial		varchar(1) null
);


create table dbo.MatchOddsWinnings(
	MatchOddsWinningsId	int not null identity(1,1),
	Match				varchar(10) null,
	Odds				varchar(10) null,
	Winnings			varchar(10) null,
	GameId				int not null
);


create table dbo.State(
	StateId			int not null identity(1,1),
	StateName		varchar(30) not null
);


create table dbo.GameState(
	GameStateId		int not null identity(1,1),
	StateId			int not null,
	GameId			int not null
);


create table dbo.WinningNumber(
	WinningNumberId	int not null identity(1,1),
	WinningNumber	smallint not null,
	BallTypeId		int not null,
	DrawingId		int not null
);


create table dbo.BallType(
	BallTypeId		int not null identity(1,1),
	BallName		varchar(30)
);