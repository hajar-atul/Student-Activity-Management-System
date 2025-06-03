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
    private int reportId;
    private String reportAbout;
    private String reportCreatedDate;
    private int clubId;
    private int activityId;
    
    public void setReportId(int reportId) {
        this.reportId = reportId;
    }

    public int getReportId() {
        return reportId;
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
    
    public void setClubId(int clubId) {
        this.clubId = clubId;
    }

    public int getClubId() {
        return clubId;
    }
    
    public void setActivityId(int activityId) {
        this.activityId = activityId;
    }

    public int getActivityId() {
        return activityId;
    }
}
