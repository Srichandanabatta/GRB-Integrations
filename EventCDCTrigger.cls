public class EventCDCTrigger implements Queueable {
    private List<String> eventIds;

    public EventCDCTrigger(List<String> eventIds) {
        this.eventIds = eventIds;
    }

    public void execute(QueueableContext context) {
        for (String eventId : eventIds) {
            System.debug('calling handler');
            System.enqueueJob(new GoogleCalendarEventQueueable(eventId));
        }
    }

    @InvocableMethod
    public static void processEventChanges(List<EventChangeEvent> eventChanges) {
        List<String> eventIdsToProcess = new List<String>();

        for (EventChangeEvent ev : eventChanges) {
            if (ev.ChangeEventHeader.getChangeType() == 'CREATE') {
                eventIdsToProcess.add(ev.Id);
            }
        }

        if (!eventIdsToProcess.isEmpty()) {
            System.enqueueJob(new EventCDCTrigger(eventIdsToProcess));
        }
    }
}