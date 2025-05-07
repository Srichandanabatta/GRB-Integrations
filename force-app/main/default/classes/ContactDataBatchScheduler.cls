global class ContactDataBatchScheduler implements Schedulable {
    global void execute(SchedulableContext sc) {
        Database.executeBatch(new ContactDataBatch(), 50);
    }
}