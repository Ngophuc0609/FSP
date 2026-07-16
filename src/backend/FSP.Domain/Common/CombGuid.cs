using System;

namespace FSP.Domain.Common;

/// <summary>
/// Generates COMB (Combined GUID/Timestamp) GUIDs optimized for SQL Server clustered index insertions.
/// Prevents index fragmentation (page splits) while maintaining pure domain-level ID generation without EF Core dependencies per DEC-REM-002.
/// </summary>
public static class CombGuid
{
    private static readonly DateTime BaseDate = new DateTime(1900, 1, 1);

    public static Guid NewGuid()
    {
        byte[] guidArray = Guid.NewGuid().ToByteArray();

        DateTime now = DateTime.UtcNow;

        TimeSpan days = new TimeSpan(now.Ticks - BaseDate.Ticks);
        TimeSpan msecs = now.TimeOfDay;

        byte[] daysArray = BitConverter.GetBytes(days.Days);
        byte[] msecsArray = BitConverter.GetBytes((long)(msecs.TotalMilliseconds / 3.333333));

        Array.Reverse(daysArray);
        Array.Reverse(msecsArray);

        Array.Copy(daysArray, daysArray.Length - 2, guidArray, guidArray.Length - 6, 2);
        Array.Copy(msecsArray, msecsArray.Length - 4, guidArray, guidArray.Length - 4, 4);

        return new Guid(guidArray);
    }
}
