package com.jeff.bible_app

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Context
import android.content.Intent
import android.graphics.BitmapFactory
import android.graphics.Color
import android.os.Build
import android.os.IBinder
import androidx.annotation.NonNull
import androidx.annotation.Nullable
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
abstract class SilentLogBaseService : Service() {

    protected abstract val foregroundNotificationId: Int

    protected abstract val channelName: String

    @NonNull
    override fun onBind(intent: Intent): IBinder? {
        return null
    }

    internal fun startForeground() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return

        val notification = createNotification() ?: return
        startForeground(foregroundNotificationId, notification)
    }

    @RequiresApi(Build.VERSION_CODES.O)
    @Nullable
    private fun createNotification(): Notification? {
        val channelId = "RFLForegroundService"
        val chan = NotificationChannel(channelId, channelName, NotificationManager.IMPORTANCE_HIGH)

        chan.lightColor = Color.BLUE
        chan.importance = NotificationManager.IMPORTANCE_NONE
        chan.lockscreenVisibility = Notification.VISIBILITY_PRIVATE

        val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        notificationManager.createNotificationChannel(chan)

        return NotificationCompat.Builder(this, channelId)
            .setAutoCancel(true)
            .setLargeIcon(BitmapFactory.decodeResource(resources, R.mipmap.ic_launcher))
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle(channelName)
            .setContentText("")
            .setOngoing(true)
            .setWhen(System.currentTimeMillis())
            .setChannelId(channelId)
            .build()
    }

}
