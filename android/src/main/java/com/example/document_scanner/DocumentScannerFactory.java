package com.example.document_scanner;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.content.ContextWrapper;
import android.util.Log;

import androidx.lifecycle.Lifecycle;

import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class DocumentScannerFactory extends PlatformViewFactory {
    private final AtomicInteger mActivityState;
    private final BinaryMessenger binaryMessenger;
    private final Application application;
    private final int activityHashCode;
    private final Lifecycle lifecycle;
    private final PluginRegistry.Registrar registrar; // V1 embedding only.
    private final Activity activity;
    private final MethodChannel channel;
    DocumentScannerFactory(
            AtomicInteger state,
            BinaryMessenger binaryMessenger,
            Application application,
            Lifecycle lifecycle,
            PluginRegistry.Registrar registrar,
            int activityHashCode,Activity activity,
            MethodChannel channel) {
        super(StandardMessageCodec.INSTANCE);
        mActivityState = state;
        this.binaryMessenger = binaryMessenger;
        this.application = application;
        this.activityHashCode = activityHashCode;
        this.lifecycle = lifecycle;
        this.registrar = registrar;
        this.activity = activity;
        this.channel = channel;
    }

    @SuppressWarnings("unchecked")
    @Override
    public PlatformView create(Context context, int id, Object args) {
        Map<String, Object> params = (Map<String, Object>) args;
//        final GoogleMapBuilder builder = new GoogleMapBuilder();

//        Convert.interpretGoogleMapOptions(params.get("options"), builder);
//        if (params.containsKey("initialCameraPosition")) {
//
////            builder.setInitialCameraPosition(position);
//        }
//        if (params.containsKey("markersToAdd")) {
////            builder.setInitialMarkers(params.get("markersToAdd"));
//        }
//        if (params.containsKey("polygonsToAdd")) {
////            builder.setInitialPolygons(params.get("polygonsToAdd"));
//        }
//        if (params.containsKey("polylinesToAdd")) {
////            builder.setInitialPolylines(params.get("polylinesToAdd"));
//        }
//        if (params.containsKey("circlesToAdd")) {
////            builder.setInitialCircles(params.get("circlesToAdd"));
//        }

        return new DocumentScannerViewManager(activity.getApplicationContext(),activity ,params,channel);
    }

    public Activity getActivity(Context context)
    {
        if (context == null)
        {
            Log.d("debug", "context null");
            return null;
        }
        else if (context instanceof ContextWrapper)
        {
            if (context instanceof Activity)
            {
                Log.d("debug", "context found 1");
                return (Activity) context;
            }
            else
            {
                Log.d("debug", "context found 2");
                return getActivity(((ContextWrapper) context).getBaseContext());
            }
        }
        Log.d("debug", "returned null");
        return null;
    }
}
