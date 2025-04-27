package com.VirtuMuse.VirtuMuse

import android.os.Bundle
import android.util.Log
import androidx.lifecycle.lifecycleScope
import com.appsflyerext.ext.FireBaseApp
import com.google.firebase.Firebase
import com.google.firebase.firestore.firestore
import io.flutter.embedding.android.FlutterFragmentActivity
import kotlinx.coroutines.CoroutineExceptionHandler
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class MainActivity : FlutterFragmentActivity() {
    val f = FireBaseApp(this, lifecycleScope)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d("Result","Main")
        f.onCreate()

        lifecycleScope.launch(Dispatchers.IO + CoroutineExceptionHandler { coroutineContext, throwable ->
            Log.e("Result","Error:${throwable.message}")
            throwable.printStackTrace()
        }) {
            val db = Firebase.firestore;
            db.collection("rec")
                .get()
                .addOnSuccessListener { result ->
                    Log.d("Result","${result.size()}")
                }.addOnFailureListener {
                    Log.e("Result","${it.message}")
                    it.printStackTrace()
                }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        f.onDestroy()
    }
}
