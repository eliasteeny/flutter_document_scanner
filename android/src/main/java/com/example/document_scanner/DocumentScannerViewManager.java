package com.example.document_scanner;

import android.app.Activity;
import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.View;

import com.example.document_scanner.views.MainView;
import com.example.document_scanner.views.OpenNoteCameraView;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.platform.PlatformView;


/**
 * Created by Andre on 29/11/2017.
 */

public class DocumentScannerViewManager implements PlatformView {


    private MainView view = null;
    Context context;
    Activity activity;




    final MethodChannel channel;

    Map<String, Object> params;

    DocumentScannerViewManager(Context context,Activity activity, Map<String, Object> params,MethodChannel channel){
        this.context = context;
        this.activity = activity;
        this.params = params;
        this.channel = channel;
    }



    @Override
    public View getView() {
        MainView.createInstance(context,activity);
        view = MainView.getInstance();
        setParams();
        return view;
    }

    @Override
    public void dispose() {

    }

    void setParams(){
        view.setOnProcessingListener(new OpenNoteCameraView.OnProcessingListener() {

            @Override
            public void onProcessingChange(Map data) {
//Log.d("debug",path.toString());
                Handler uiThreadHandler = new Handler(context.getMainLooper());
                Runnable runnable = new Runnable() {
                    @Override
                    public void run() {

                        channel.invokeMethod("onPictureTaken",data);
                    }
                };
                uiThreadHandler.postAtFrontOfQueue(runnable );
            }
        });

        view.setOnScannerListener(new OpenNoteCameraView.OnScannerListener() {

            @Override
            public void onPictureTaken(Map data) {

                 Handler uiThreadHandler = new Handler(context.getMainLooper());
                 Runnable runnable = new Runnable() {
                     @Override
                     public void run() {
                        
                       channel.invokeMethod("onPictureTaken",data);
                     }
                 };
uiThreadHandler.postAtFrontOfQueue(runnable );


            }
        });

        boolean documentAnimation;
        if(params.containsKey("documentAnimation")){
            documentAnimation =(boolean) params.get("documentAnimation");
        }else{
            documentAnimation = false;
        }

        view.setDocumentAnimation(documentAnimation);

        String overlayColor;
        if(params.containsKey("overlayColor")){
            overlayColor = (String ) params.get("overlayColor");
            view.setOverlayColor(overlayColor);
        }

        int detectionCountBeforeCapture;
        if(params.containsKey("detectionCountBeforeCapture")){
            detectionCountBeforeCapture =(int) params.get("detectionCountBeforeCapture");
        }else{
            detectionCountBeforeCapture = 15;
        }
        view.setDetectionCountBeforeCapture(detectionCountBeforeCapture);


        boolean enableTorch;
        if(params.containsKey("enableTorch")){
            enableTorch =(boolean) params.get("enableTorch");
        }else{
            enableTorch = false;
        }

        view.setEnableTorch(enableTorch);


        boolean manualOnly;
        if(params.containsKey("manualOnly")){
            manualOnly =(boolean) params.get("manualOnly");
        }else{
            manualOnly = false;
        }

        view.setManualOnly(manualOnly);

        boolean noGrayScale;
        if(params.containsKey("noGrayScale")){
            noGrayScale =(boolean) params.get("noGrayScale");
        }else{
            noGrayScale = false;
        }

        view.setRemoveGrayScale(noGrayScale);

        double brightness;
        if(params.containsKey("brightness")){
            brightness =(double) params.get("brightness");
        }else{
            brightness = 10;
        }
        view.setBrightness(brightness);


        double contrast;
        if(params.containsKey("contrast")){
            contrast =(double) params.get("contrast");
        }else{
            contrast = 1;
        }
        view.setContrast(contrast);
    }




}
