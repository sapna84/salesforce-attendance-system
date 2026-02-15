trigger AttendanceSessionTrigger on Attendance_Session__c (after insert) {
    AttendanceSessionHandler.createAttendanceRecords(Trigger.new);
}