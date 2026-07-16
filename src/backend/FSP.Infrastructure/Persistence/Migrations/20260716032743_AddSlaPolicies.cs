using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FSP.Infrastructure.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class AddSlaPolicies : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "SlaAccumulatedMinutes",
                table: "WorkOrders",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "SlaBreachNotifiedUtc",
                table: "WorkOrders",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "SlaNextCheckpointUtc",
                table: "WorkOrders",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "SlaPolicyId",
                table: "WorkOrders",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "SlaStatus",
                table: "WorkOrders",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "SlaWarningNotifiedUtc",
                table: "WorkOrders",
                type: "datetime2",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "SlaPolicies",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    TargetResponseMinutes = table.Column<int>(type: "int", nullable: false),
                    TargetResolutionMinutes = table.Column<int>(type: "int", nullable: false),
                    CalendarId = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    TenantId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    CreatedAtUtc = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    LastModifiedAtUtc = table.Column<DateTime>(type: "datetime2", nullable: true),
                    LastModifiedBy = table.Column<Guid>(type: "uniqueidentifier", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SlaPolicies", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_WorkOrders_SlaPolicyId",
                table: "WorkOrders",
                column: "SlaPolicyId");

            migrationBuilder.CreateIndex(
                name: "IX_WorkOrders_SlaSweep",
                table: "WorkOrders",
                column: "SlaNextCheckpointUtc");

            migrationBuilder.CreateIndex(
                name: "IX_SlaPolicies_TenantId_Name",
                table: "SlaPolicies",
                columns: new[] { "TenantId", "Name" },
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_WorkOrders_SlaPolicies_SlaPolicyId",
                table: "WorkOrders",
                column: "SlaPolicyId",
                principalTable: "SlaPolicies",
                principalColumn: "Id",
                onDelete: ReferentialAction.SetNull);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_WorkOrders_SlaPolicies_SlaPolicyId",
                table: "WorkOrders");

            migrationBuilder.DropTable(
                name: "SlaPolicies");

            migrationBuilder.DropIndex(
                name: "IX_WorkOrders_SlaPolicyId",
                table: "WorkOrders");

            migrationBuilder.DropIndex(
                name: "IX_WorkOrders_SlaSweep",
                table: "WorkOrders");

            migrationBuilder.DropColumn(
                name: "SlaAccumulatedMinutes",
                table: "WorkOrders");

            migrationBuilder.DropColumn(
                name: "SlaBreachNotifiedUtc",
                table: "WorkOrders");

            migrationBuilder.DropColumn(
                name: "SlaNextCheckpointUtc",
                table: "WorkOrders");

            migrationBuilder.DropColumn(
                name: "SlaPolicyId",
                table: "WorkOrders");

            migrationBuilder.DropColumn(
                name: "SlaStatus",
                table: "WorkOrders");

            migrationBuilder.DropColumn(
                name: "SlaWarningNotifiedUtc",
                table: "WorkOrders");
        }
    }
}
