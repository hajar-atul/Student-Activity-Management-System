/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author User
 */
public class REPORT {
    private int reportID;
    private String reportDetails;
    private String reportDate;
    private int clubID;     
    private int activityID;
    
    public void setReportId(int reportID) {
        this.reportID = reportID;
    }

    public int getReportId() {
        return reportID;        
    }
    
    public void setReportDetails(String reportDetails) {
        this.reportDetails = reportDetails;
    }

    public String getReportDetails() {
        return reportDetails;
    }
    
    public void setReportDate(String reportDate) {
        this.reportDate = reportDate;
    }

    public String getReportDate() {
        return reportDate;
    }
    
    public void setClubId(int clubID) {
        this.clubID = clubID;
    }

    public int getClubId() {
        return clubID;
    }
    
    public void setActivityId(int activityID) {
        this.activityID = activityID;
    }

    public int getActivityId() {
        return activityID;
    }
}
