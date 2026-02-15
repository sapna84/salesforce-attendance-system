public with sharing class AttendanceLWCController {

    @AuraEnabled(cacheable=true)
    public static List<Attendance__c> getAttendances(Id attendanceSessionId) {
        return [
            SELECT Id,
                   Student__c,
                   Student__r.Name,
                   Student__r.Roll_No__c,
                   Status__c
            FROM Attendance__c
            WHERE Attendance_Session__c = :attendanceSessionId
            ORDER BY Student__r.Roll_No__c
        ];
    }

    @AuraEnabled
    public static void updateAttendances(List<Attendance__c> attendances) {

        // Update attendance records
        update attendances;

        // Collect affected student Ids directly from database
        Set<Id> studentIds = new Set<Id>();
        for(Attendance__c att : [
            SELECT Student__c
            FROM Attendance__c
            WHERE Id IN :attendances
            ]){
                studentIds.add(att.Student__c);
            }
        // Query all attendance records of those students
        List<Attendance__c> allAttendances = [
            SELECT Id, Student__c, Status__c
            FROM Attendance__c
            WHERE Student__c IN :studentIds
        ];

        // Map to count totals
        Map<Id, Integer> totalMap = new Map<Id, Integer>();
        Map<Id, Integer> presentMap = new Map<Id, Integer>();

        for(Attendance__c att : allAttendances){

            // total count
            totalMap.put(att.Student__c,
                (totalMap.containsKey(att.Student__c) ? totalMap.get(att.Student__c) : 0) + 1
            );

            // present count
            if(att.Status__c == 'Present'){
                presentMap.put(att.Student__c,
                    (presentMap.containsKey(att.Student__c) ? presentMap.get(att.Student__c) : 0) + 1
                );
            }
        }

        // Prepare student updates
        List<Student__c> studentsToUpdate = new List<Student__c>();

        for(Id stuId : studentIds){

            Integer total = totalMap.containsKey(stuId) ? totalMap.get(stuId) : 0;
            Integer present = presentMap.containsKey(stuId) ? presentMap.get(stuId) : 0;

            Decimal percentage = 0;

            if(total > 0){
                percentage = (Decimal.valueOf(present) / total) * 100;
            }

            studentsToUpdate.add(
                new Student__c(
                    Id = stuId,
                    Attendance_Percentage__c = percentage
                )
            );
        }

        if(!studentsToUpdate.isEmpty()){
            update studentsToUpdate;
        }
    }
}