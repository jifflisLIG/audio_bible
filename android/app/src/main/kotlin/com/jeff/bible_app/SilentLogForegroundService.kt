
import android.content.Intent
import com.jeff.bible_app.SilentLogBaseService

class SilentLogForegroundService : SilentLogBaseService() {

    override val foregroundNotificationId = 5052

    override val channelName: String = "位置更新"

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        super.onStartCommand(intent, flags, startId)
        startForeground()
        return START_STICKY
    }

}
