USE [AstonEngineer]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetEmployee]    Script Date: 11/20/2015 12:56:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Justin Gordon
-- Create date: 11.20.2015
-- Description:	This procedure retrieves
--				Employee record(s)
-- =============================================
ALTER PROCEDURE [dbo].[usp_GetEmployee](
	@Page				int = 1,
	@NumberOfRecords	int = 10,
	@RecordStart		int = 1,
	@RecordEnd			int = 10,
	@EmployeeId			int = null,
	@QueryId			int = 10
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    if(@QueryId = 10) begin goto GET_ITEM end;
	if(@QueryId = 20) begin goto GET_COLLECTION end;
	if(@QueryId = 30) begin goto CALC_PAGING_VALUES end;

	goto EXIT_SECTION

--BEGIN		GET_ITEM SECTION
GET_ITEM:
	begin
		select	a.EmployeeId,
				a.HireDate,
				a.TermDate,
				a.BirthDate,
				a.PersonId
		from	dbo.Employee a
		where	a.EmployeeId = @EmployeeId

		goto EXIT_SECTION
	end
--END		GET_ITEM SECTION



--BEGIN		GET_COLLECTION SECTION
GET_COLLECTION:
	begin
		select	a.EmployeeId,
				a.HireDate,
				a.TermDate,
				a.BirthDate,
				a.PersonId
		from	dbo.Employee a

		goto EXIT_SECTION
	end
--END		GET_COLLECTION SECTION



--BEGIN		CALC_PAGING_VALUES SECTION
CALC_PAGING_VALUES:
	if(@Page = 1)
		begin
			set @RecordStart = 1;
			set @RecordEnd = @Page * @NumberOfRecords;

			--variable check
			print 'if(@Page = 1)'
			print '@Page = ' + cast(@Page as varchar)
			print '@NumberOfRecords = ' + cast(@NumberOfRecords as varchar)
			print '@RecordStart = ' + cast(@RecordStart as varchar)
			print '@RecordEnd = ' + cast(@RecordEnd as varchar)

			goto GET_COLLECTION_PAGED
		end
	else
		begin
			set @RecordStart = (@NumberOfRecords * (@Page - 1)) + 1;
			set @RecordEnd = (@RecordStart - 1) + @NumberOfRecords;

			--variable check
			print 'if(@Page <> 1)'
			print '@Page = ' + cast(@Page as varchar)
			print '@NumberOfRecords = ' + cast(@NumberOfRecords as varchar)
			print '@RecordStart = ' + cast(@RecordStart as varchar)
			print '@RecordEnd = ' + cast(@RecordEnd as varchar)

			goto GET_COLLECTION_PAGED
		end

	goto EXIT_SECTION
--END		CALC_PAGING_VALUES SECTION


--BEGIN		GET_COLLECTION_PAGED SECTION
GET_COLLECTION_PAGED:

	select	*
	from	dbo.Employee a
	where	a.EmployeeId between @RecordStart and @RecordEnd;
--END		GET_COLLECTION_PAGED SECTION




--BEGIN		EXIT_SECTION
EXIT_SECTION:
--END		EXIT_SECTION
END
