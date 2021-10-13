
#include <iostream>
#include "ContourDetectionSample.h"

//! Gets a sample name
std::string ContourDetectionSample::getName() const
{
    return "Dashboard";
}

//! Returns a detailed sample description
std::string ContourDetectionSample::getDescription() const
{
    return "Image contour detection is fundamental to many image analysis applications, including image segmentation, object recognition and classiﬁcation.";
}

std::string ContourDetectionSample::getSampleIcon() const
{
    return "ContourDetectionSampleIcon.png";
}

//! Processes a frame and returns output image
bool ContourDetectionSample::processFrame(const cv::Mat& inputFrame, cv::Mat& outputFrame)
{
    
    cv::Mat m;
    cv::Mat inputImage(inputFrame);
    getGray(inputImage, gray);
    cv::Mat gray;
    cv::cvtColor( inputImage, gray, cv::COLOR_RGB2GRAY );
    //Cool, let's compute the laplacian of the gray image:
    cv::Mat laplacianImage;
    cv::Laplacian( gray, laplacianImage, CV_64F );
    //Prepare to compute the mean and standard deviation of the laplacian:
    cv::Scalar mean, stddev;
    cv::meanStdDev( laplacianImage, mean, stddev, cv::Mat() );

    //Let’s compute the variance:
    double variance = stddev.val[0] * stddev.val[0];
    double blurThreshold = 37.0000;
    inputFrame.copyTo(outputFrame);
    
    if ( variance <= blurThreshold ) {
        printf("blur");
        return true;

    }else {
        printf("Not");
        return false;
    }
}

//! Processes a frame and returns output image
std::string ContourDetectionSample::processFrameStr(const cv::Mat& inputFrame, cv::Mat& outputFrame)
{
    
    //MARK: - Low Light
    const int darkness_threshold = 15;   //you need to determine what threshold to use
    cv::Mat m2;
    cv::Mat inputImageLL(inputFrame);
    getGray(inputImageLL, gray);
    cv::cvtColor(inputImageLL, gray, cv::COLOR_BGR2HSV);
    const auto result = cv::mean(gray);
    std::cout<<"Light Result "<<result<<std::endl;
    if (result[2] <= darkness_threshold)
    {
        return "Low Light Detected";
    }
    
    
    //MARK: - BLUR
        cv::Mat m1;
        cv::Mat inputImageBlur(inputFrame);
        getGray(inputImageBlur, gray);
        cv::Mat grayBlur;
        cv::cvtColor( inputImageBlur, grayBlur, cv::COLOR_RGB2GRAY );
        inputFrame.copyTo(outputFrame);
        //Cool, let's compute the laplacian of the gray image:
        cv::Mat newGray;
        cv::Mat laplacianImage;
        cv::Laplacian( gray, laplacianImage, CV_64F );
        //Prepare to compute the mean and standard deviation of the laplacian:
        cv::Scalar mean, stddev;
        cv::meanStdDev( laplacianImage, mean, stddev, cv::Mat() );
        //Let’s compute the variance:
        double variance = stddev.val[0] * stddev.val[0];
        double blurThreshold = 37.0000;
    
    
        if ( variance <= blurThreshold ) {
            return "blur Detected";
        }
    
    
    
    //MARK: - Glare
    cv::Mat m;
    cv::Mat inputImage(inputFrame);
    getGray(inputImage, gray);
    cv::Mat gray;
    cv::cvtColor( inputImage, gray, cv::COLOR_BGR2GRAY );
    cv::threshold(gray, gray, 30, 255, cv::THRESH_OTSU);
//    cv::Scalar mean,stddev;
    meanStdDev(gray,mean,stddev,cv::Mat());
    std::cout<<"Standard deviation: "<<stddev.val[0]<<std::endl;
    
    if (stddev.val[0] > 110.00 && stddev.val[0] < 120.00)
    {
        return  "glare Detected";
    }
    inputFrame.copyTo(outputFrame);
    
    return "Image Perfect";
    
    //    double  sigmaX = 0.0;
    //    double minVal;
    //    double maxVal;
    
    //    cv::meanStdDev(gray, gray, gray);
    //    cv::minMaxLoc(gray, &minVal, &maxVal);
    //    std::cout << "The maximum value is : " << &minVal << std::endl;
    //    std::cout << "The maximum value is : " << &maxVal << std::endl;
    
    //    if (maxVal > 253.0 && minVal > 0.0 && minVal < 20 ) {
    //        return "Image is glared";
    //    }
    
    
    //MARK: - Shadow detection
    //    cv::Mat frame;
    //    cv::Mat back;
    //    cv::Mat fore;
    //    cv::Mat inputImageShadowObj(inputFrame);
    //    cv::cvtColor(inputImageShadowObj, gray, cv::COLOR_BGR2HSV);
    //    cv::Mat channel[3];
    //    split(gray, channel);
    //    channel[2] = cv::Mat(hsvImg.rows, hsvImg.cols, CV_8UC1, 180);
    
}
