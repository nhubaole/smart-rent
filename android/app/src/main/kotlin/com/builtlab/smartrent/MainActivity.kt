package com.builtlab.smartrent

import android.content.ContentResolver
import android.content.Intent
import android.provider.CalendarContract
import android.util.Log
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.database.Cursor

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.builtlab.smartrent/reminder"
    private val REMINDER_METHOD = "createReminder"
    private val TAG = "MainActivity"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                REMINDER_METHOD -> {
                    try {
                        val success = createReminder(
                            title = call.argument("title") ?: "",
                            desc = call.argument("description"),
                            loc = call.argument("location"),
                            start = call.argument("startTime") ?: 0L,
                            end = call.argument("endTime") ?: 0L
                        )
                        result.success(success)
                    } catch (e: Exception) {
                        Log.e(TAG, "Error creating reminder", e)
                        result.error("ERROR", e.message, null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun createReminder(
        title: String,
        desc: String?,
        loc: String?,
        start: Long,
        end: Long
    ): Boolean {
        if (title.isEmpty() || start == 0L || end == 0L) {
            Log.e(TAG, "Invalid event details")
            return false
        }

        val calendarUri = CalendarContract.Calendars.CONTENT_URI
        val resolver: ContentResolver = contentResolver
        val cursor: Cursor? = resolver.query(
            calendarUri,
            arrayOf(CalendarContract.Calendars._ID, CalendarContract.Calendars.NAME),
            null,
            null,
            null
        )

        val calendarId: String
        if (cursor != null && cursor.moveToFirst()) {
            calendarId = cursor.getString(cursor.getColumnIndex(CalendarContract.Calendars._ID))
            cursor.close()
        } else {
            Log.e(TAG, "No calendar found, using default calendar")
            calendarId = "1"
        }

        val intent = Intent(Intent.ACTION_INSERT).apply {
            data = CalendarContract.Events.CONTENT_URI
            putExtra(CalendarContract.Events.TITLE, title)
            if (!desc.isNullOrEmpty()) putExtra(CalendarContract.Events.DESCRIPTION, desc)
            if (!loc.isNullOrEmpty()) putExtra(CalendarContract.Events.EVENT_LOCATION, loc)
            putExtra(CalendarContract.EXTRA_EVENT_BEGIN_TIME, start)
            putExtra(CalendarContract.EXTRA_EVENT_END_TIME, end)
            putExtra(CalendarContract.EXTRA_EVENT_ALL_DAY, false)
            putExtra(CalendarContract.Events.CALENDAR_ID, calendarId)
        }

        return if (intent.resolveActivity(packageManager) != null) {
            startActivity(intent)
            Log.d(TAG, "Calendar event created successfully")
            true
        } else {
            Log.e(TAG, "No calendar app found")
            runOnUiThread {
                Toast.makeText(this, "No calendar app found", Toast.LENGTH_LONG).show()
            }
            false
        }
    }
}
