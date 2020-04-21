package com.example.document_scanner;

import android.app.Activity;
import android.app.Application;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.lifecycle.DefaultLifecycleObserver;
import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleOwner;

import io.flutter.app.FlutterActivity;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.embedding.engine.plugins.lifecycle.FlutterLifecycleAdapter;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import java.util.concurrent.atomic.AtomicInteger;


public class DocumentScannerPlugin
        implements Application.ActivityLifecycleCallbacks,
        FlutterPlugin,
        ActivityAware,
        DefaultLifecycleObserver, MethodChannel.MethodCallHandler {
  static final int CREATED = 1;
  static final int STARTED = 2;
  static final int RESUMED = 3;
  static final int PAUSED = 4;
  static final int STOPPED = 5;
  static final int DESTROYED = 6;
  private final AtomicInteger state = new AtomicInteger(0);
  private int registrarActivityHashCode;
  private FlutterPluginBinding pluginBinding;
  private Lifecycle lifecycle;
  static MethodChannel methodChannel;

  private static final String VIEW_TYPE = "document_scanner";

//    @Override
//  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
////    final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "document_scanner");
////    channel.setMethodCallHandler(new DocumentScannerPlugin());
//    flutterPluginBinding.getPlatformViewRegistry().registerViewFactory("document_scanner",new DocumentScannerViewManager(flutterPluginBinding.));
//
//
//  }



  public static void registerWith(Registrar registrar) {

        final MethodChannel channel = new MethodChannel(registrar.messenger(), "document_scanner");
    channel.setMethodCallHandler(new DocumentScannerPlugin());
methodChannel = channel;
    if (registrar.activity() == null) {
      // When a background flutter view tries to register the plugin, the registrar has no activity.
      // We stop the registration process as this plugin is foreground only.
      return;
    }
    final DocumentScannerPlugin plugin = new DocumentScannerPlugin(registrar.activity());
    registrar.activity().getApplication().registerActivityLifecycleCallbacks(plugin);
    registrar
            .platformViewRegistry()
            .registerViewFactory(
                    VIEW_TYPE,
                    new DocumentScannerFactory(plugin.state, registrar.messenger(), null, null, registrar, -1,registrar.activity(),channel));
  }

  public DocumentScannerPlugin() {}

  // FlutterPlugin


  @Override
  public void onAttachedToEngine(FlutterPluginBinding binding) {

    final MethodChannel channel = new MethodChannel(binding.getFlutterEngine().getDartExecutor(), "document_scanner");
    channel.setMethodCallHandler(new DocumentScannerPlugin());

    methodChannel= channel;
    pluginBinding = binding;
  }

  @Override
  public void onDetachedFromEngine(FlutterPluginBinding binding) {
    pluginBinding = null;
  }

  // ActivityAware

  @Override
  public void onAttachedToActivity(ActivityPluginBinding binding) {
    lifecycle = FlutterLifecycleAdapter.getActivityLifecycle(binding);




    lifecycle.addObserver(this);
    pluginBinding
            .getPlatformViewRegistry()
            .registerViewFactory(
                    VIEW_TYPE,
                    new DocumentScannerFactory(
                            state,
                            pluginBinding.getBinaryMessenger(),
                            binding.getActivity().getApplication(),
                            lifecycle,
                            null,
                            binding.getActivity().hashCode(),binding.getActivity(),methodChannel));
  }

  @Override
  public void onDetachedFromActivity() {
    lifecycle.removeObserver(this);
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    this.onDetachedFromActivity();
  }

  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {
    lifecycle = FlutterLifecycleAdapter.getActivityLifecycle(binding);
    lifecycle.addObserver(this);
  }

  // DefaultLifecycleObserver methods

  @Override
  public void onCreate(@NonNull LifecycleOwner owner) {
    state.set(CREATED);
  }

  @Override
  public void onStart(@NonNull LifecycleOwner owner) {
    state.set(STARTED);
  }

  @Override
  public void onResume(@NonNull LifecycleOwner owner) {
    state.set(RESUMED);
  }

  @Override
  public void onPause(@NonNull LifecycleOwner owner) {
    state.set(PAUSED);
  }

  @Override
  public void onStop(@NonNull LifecycleOwner owner) {
    state.set(STOPPED);
  }

  @Override
  public void onDestroy(@NonNull LifecycleOwner owner) {
    state.set(DESTROYED);
  }

  // Application.ActivityLifecycleCallbacks methods

  @Override
  public void onActivityCreated(Activity activity, Bundle savedInstanceState) {

    if (activity.hashCode() != registrarActivityHashCode) {
      return;
    }
    state.set(CREATED);
  }

  @Override
  public void onActivityStarted(Activity activity) {

    if (activity.hashCode() != registrarActivityHashCode) {
      return;
    }
    state.set(STARTED);
  }

  @Override
  public void onActivityResumed(Activity activity) {
    if (activity.hashCode() != registrarActivityHashCode) {
      return;
    }
    state.set(RESUMED);
  }

  @Override
  public void onActivityPaused(Activity activity) {
    if (activity.hashCode() != registrarActivityHashCode) {
      return;
    }
    state.set(PAUSED);
  }

  @Override
  public void onActivityStopped(Activity activity) {
    if (activity.hashCode() != registrarActivityHashCode) {
      return;
    }
    state.set(STOPPED);
  }

  @Override
  public void onActivitySaveInstanceState(Activity activity, Bundle outState) {}

  @Override
  public void onActivityDestroyed(Activity activity) {
    if (activity.hashCode() != registrarActivityHashCode) {
      return;
    }
    activity.getApplication().unregisterActivityLifecycleCallbacks(this);
    state.set(DESTROYED);
  }

  private DocumentScannerPlugin(Activity activity) {

    this.registrarActivityHashCode = activity.hashCode();
  }

  @Override
  public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
    if (methodCall.method.equals("getPlatformVersion")) {
      Log.d("debug","sucess");
      Log.d("debug","success");
      Log.d("debug","sucess");
      Log.d("debug","success");
      Log.d("debug","sucess");
      Log.d("debug","success");
      Log.d("debug","sucess");
      result.success("Androiddd " + android.os.Build.VERSION.RELEASE);
    } else {
      result.notImplemented();
    }
  }
}
////package com.example.document_scanner;
////
////import androidx.annotation.NonNull;
////import io.flutter.embedding.engine.plugins.FlutterPlugin;
////import io.flutter.plugin.common.MethodCall;
////import io.flutter.plugin.common.MethodChannel;
////import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
////import io.flutter.plugin.common.MethodChannel.Result;
////import io.flutter.plugin.common.PluginRegistry.Registrar;
////
////import com.example.document_scanner.views.MainView;
////import com.example.document_scanner.views.OpenNoteCameraView;
////
////import android.app.Activity;
////import android.content.Context;
////
////import java.util.HashMap;
////
/////** DocumentScannerPlugin */
////public class DocumentScannerPlugin implements FlutterPlugin, MethodCallHandler {
////  private MainView view = null;
////
////  @Override
////  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
//////    final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "document_scanner");
//////    channel.setMethodCallHandler(new DocumentScannerPlugin());
////    flutterPluginBinding.getPlatformViewRegistry().registerViewFactory("document_scanner",new DocumentScannerViewManager(flutterPluginBinding.));
////
////
////  }
////
////  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
////  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
////  // plugin registration via this function while apps migrate to use the new Android APIs
////  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
////  //
////  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
////  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
////  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
////  // in the same class.
////  public static void registerWith(Registrar registrar) {
//////    final MethodChannel channel = new MethodChannel(registrar.messenger(), "document_scanner");
//////    channel.setMethodCallHandler(new DocumentScannerPlugin());
////
////registrar.platformViewRegistry().registerViewFactory("document_scanner",new DocumentScannerViewManager(registrar.));
////  }
////
////  @Override
////  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
////    if (call.method.equals("getPlatformVersion")) {
////
////      result.success("Androiddd " + android.os.Build.VERSION.RELEASE);
////    } else {
////      result.notImplemented();
////    }
////  }
////
////  @Override
////  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
////  }
////
////  public void openScanner(Context context){
//////    MainView.createInstance(context, );
////
////    view = MainView.getInstance();
//////    view.setOnProcessingListener(new OpenNoteCameraView.OnProcessingListener() {
//////      @Override
//////      public void onProcessingChange(HashMap data) {
//////        dispatchEvent(reactContext, "onProcessingChange", data);
//////      }
//////    });
////
//////    view.setOnScannerListener(new OpenNoteCameraView.OnScannerListener() {
//////      @Override
//////      public void onPictureTaken(WritableMap data) {
//////        dispatchEvent(reactContext, "onPictureTaken", data);
//////      }
//////    });
////
//////    return view;
////  }
////}
