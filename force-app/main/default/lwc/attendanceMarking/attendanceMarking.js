import { LightningElement, api, track } from 'lwc';
import getAttendances from '@salesforce/apex/AttendanceLWCController.getAttendances';
import updateAttendances from '@salesforce/apex/AttendanceLWCController.updateAttendances';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AttendanceMarking extends LightningElement {

    @api recordId;
    @track attendanceList = [];
connectedCallback() {
    console.log('Record Id:', this.recordId);
    this.loadAttendance();
}

    loadAttendance() {
       getAttendances({ attendanceSessionId: this.recordId })
            .then(result => {

                this.attendanceList = result.map(record => {
                    return {
                        Id: record.Id,
                        studentId: record.Student__c,
                        studentName: record.Student__r.Name,
                        rollNo: record.Student__r.Roll_Number__c,
                        status: record.Status__c,
                        presentVariant: record.Status__c === 'Present' ? 'success' : 'neutral',
                        absentVariant: record.Status__c === 'Absent' ? 'destructive' : 'neutral'
                    };
                });

            })
            .catch(error => {
                console.error(error);
            });
    }

    handleStatusChange(event) {
        const recordId = event.target.dataset.id;
        const value = event.target.dataset.value;

        this.attendanceList = this.attendanceList.map(item => {
            if (item.Id === recordId) {
                return {
                    ...item,
                    status: value,
                    presentVariant: value === 'Present' ? 'success' : 'neutral',
                    absentVariant: value === 'Absent' ? 'destructive' : 'neutral'
                };
            }
            return item;
        });
    }

    handleSave() {

    const recordsToUpdate = this.attendanceList.map(item => {
        return {
            Id: item.Id,
            Status__c: item.status,
            Student__c: item.studentId
        };
    });

    updateAttendances({ attendances: recordsToUpdate })
        .then(() => {

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Attendance Saved Successfully',
                    variant: 'success'
                })
            );

            // Reload fresh data from database
            this.loadAttendance();

        })
        .catch(error => {
            console.error(error);
        });
}

}