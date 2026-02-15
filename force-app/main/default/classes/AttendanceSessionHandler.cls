public class AttendanceSessionHandler {

    public static void createAttendanceRecords(List<Attendance_Session__c> sessions) {

        // Collect Class Ids
        Set<Id> classIds = new Set<Id>();
        for (Attendance_Session__c session : sessions) {
            if (session.Class__c != null) {
                classIds.add(session.Class__c);
            }
        }

        if (classIds.isEmpty()) return;

        // Fetch students of those classes
        List<Student__c> students = [
            SELECT Id, Class__c
            FROM Student__c
            WHERE Class__c IN :classIds
        ];

        // Map Class → Students
        Map<Id, List<Student__c>> classStudentMap = new Map<Id, List<Student__c>>();
        for (Student__c stu : students) {
            if (!classStudentMap.containsKey(stu.Class__c)) {
                classStudentMap.put(stu.Class__c, new List<Student__c>());
            }
            classStudentMap.get(stu.Class__c).add(stu);
        }

        // Create Attendance records
        List<Attendance__c> attendanceList = new List<Attendance__c>();

        for (Attendance_Session__c session : sessions) {
            if (!classStudentMap.containsKey(session.Class__c)) continue;

            for (Student__c stu : classStudentMap.get(session.Class__c)) {
                attendanceList.add(new Attendance__c(
                    Attendance_Session__c = session.Id,
                    Student__c = stu.Id,
                    Status__c = 'Absent'
                ));
            }
        }

        if (!attendanceList.isEmpty()) {
            insert attendanceList;
        }
    }
}