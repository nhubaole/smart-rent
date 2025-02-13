package com.builtlab.smartrent

import android.content.Context
import android.content.Intent
import android.provider.CalendarContract
import android.widget.Toast

public class ReminderService(private val context: Context) {

    public fun createReminder(
        title: String,
        description: String,
        location: String = "",
        allDay: Boolean = true,
        attendees: List<String> = emptyList()
    ): Boolean {
        return try {
            val intent = Intent(Intent.ACTION_INSERT).apply {
                data = CalendarContract.Events.CONTENT_URI
                putExtra(CalendarContract.Events.TITLE, title)
                putExtra(CalendarContract.Events.DESCRIPTION, description)
                putExtra(CalendarContract.Events.EVENT_LOCATION, location)
                putExtra(CalendarContract.Events.ALL_DAY, allDay)
                if (attendees.isNotEmpty()) {
                    putExtra(Intent.EXTRA_EMAIL, attendees.joinToString(","))
                }
            }

            if (intent.resolveActivity(context.packageManager) != null) {
                context.startActivity(intent)
                true
            } else {
                Toast.makeText(context, "No app supports this action", Toast.LENGTH_SHORT).show()
                false
            }
        } catch (e: Exception) {
            Toast.makeText(context, "Error creating reminder: ${e.message}", Toast.LENGTH_LONG)
                .show()
            false
        }
    }
}
