package com.example.document_scanner.helpers;



import org.opencv.core.Mat;
import org.opencv.core.Point;
import org.opencv.core.Size;

import java.util.HashMap;

/**
 * Created by allgood on 05/03/16.
 */
public class ScannedDocument {

    public Mat original;
    public Mat processed;
    public Quadrilateral quadrilateral;
    public Point[] previewPoints;
    public Size previewSize;
    public Size originalSize;

    public Point[] originalPoints;

    public int heightWithRatio;
    public int widthWithRatio;

    public ScannedDocument(Mat original) {
        this.original = original;
    }

    public Mat getProcessed() {
        return processed;
    }

    public ScannedDocument setProcessed(Mat processed) {
        this.processed = processed;
        return this;
    }

    public HashMap previewPointsAsHash() {
        if (this.previewPoints == null) return null;
        HashMap rectangleCoordinates = new HashMap();

        HashMap topLeft = new HashMap();
        topLeft.put("x", this.originalPoints[0].x);
        topLeft.put("y", this.originalPoints[0].y);

        HashMap topRight = new HashMap();
        topRight.put("x", this.originalPoints[1].x);
        topRight.put("y", this.originalPoints[1].y);

        HashMap bottomRight = new HashMap();
        bottomRight.put("x", this.originalPoints[2].x);
        bottomRight.put("y", this.originalPoints[2].y);

        HashMap bottomLeft = new HashMap();
        bottomLeft.put("x", this.originalPoints[3].x);
        bottomLeft.put("y", this.originalPoints[3].y);



        rectangleCoordinates.put("topLeft", topLeft);
        rectangleCoordinates.put("topRight", topRight);
        rectangleCoordinates.put("bottomRight", bottomRight);
        rectangleCoordinates.put("bottomLeft", bottomLeft);

        return rectangleCoordinates;
    }

    public void release() {
        if (processed != null) {
            processed.release();
        }
        if (original != null) {
            original.release();
        }

        if (quadrilateral != null && quadrilateral.contour != null) {
            quadrilateral.contour.release();
        }
    }
}
