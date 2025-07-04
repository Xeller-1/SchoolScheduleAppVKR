//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SchoolScheduleApp
{
    using System;
    using System.Collections.Generic;
    
    public partial class Schedule
    {
        public int ScheduleID { get; set; }
        public Nullable<int> WeekID { get; set; }
        public int GroupID { get; set; }
        public Nullable<int> SubgroupID { get; set; }
        public int SubjectID { get; set; }
        public int TeacherID { get; set; }
        public int RoomID { get; set; }
        public System.TimeSpan StartTime { get; set; }
        public System.TimeSpan EndTime { get; set; }
        public Nullable<int> VersionID { get; set; }
        public Nullable<int> CallID { get; set; }
    
        public virtual Calls Calls { get; set; }
        public virtual Groups Groups { get; set; }
        public virtual Rooms Rooms { get; set; }
        public virtual Subgroups Subgroups { get; set; }
        public virtual Subjects Subjects { get; set; }
        public virtual ScheduleVersions ScheduleVersions { get; set; }
        public virtual Weeks Weeks { get; set; }
        public virtual Teachers Teachers { get; set; }
    }
}
