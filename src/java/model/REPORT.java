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
    private String reportAbout;
    private String reportCreatedDate;
    private int clubID;
    private int activityID;
    
    public void setReportId(int reportID) {
        this.reportID = reportID;
    }

    public int getReportId() {
        return reportID;
    }
    
    public void setReportAbout(String reportAbout) {
        this.reportAbout = reportAbout;
    }

    public String getReportAbout() {
        return reportAbout;
    }
    
    public void setReportCreatedDate(String reportCreatedDate) {
        this.reportCreatedDate = reportCreatedDate;
    }

    public String getReportCreatedDate() {
        return reportCreatedDate;
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
