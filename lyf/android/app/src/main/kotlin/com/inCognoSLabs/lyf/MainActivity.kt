package com.inCognoSLabs.lyf
import android.os.Bundle
import android.view.WindowManager.LayoutParams
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    public override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        window.addFlags(LayoutParams.FLAG_DIM_BEHIND)
        window.addFlags(LayoutParams.FLAG_BLUR_BEHIND)
    }
}
