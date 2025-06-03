package model;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author User
 */
public class ACTIVITY {
       private int activityId;
       private String activityName;
       private String activityDesc;
       private String activity_Date;
       private String activityVenue;
       private String activityStatus;
       private double activityBudget;
       private boolean attendance; 
       
        public void setActivityId(int activityId) {
        this.activityId = activityId;
    }

    public int getActivityId() {
        return activityId;
    }
    
     public void setActivtyName(String activityName) {
        this.activityName = activityName;
    }

    public String getactivityName() {
        return activityName;
    }
    
     public void setActivityDesc(String activityDesc) {
        this.activityDesc = activityDesc;
    }

    public String getActivityDesc() {
        return activityDesc;
    }
    
      public void setActivityDate(String activity_Date) {
        this.activity_Date = activity_Date;
    }

    public String getActivityDate() {
        return activity_Date;
    }
    
      public void setActivityVenue(String activityVenue) {
        this.activityVenue = activityVenue;
    }

    public String getActivityVenue() {
        return activityVenue;
    }
    
      public void setActivityStatus(String activityStatus) {
        this.activityStatus = activityStatus;
    }

    public String getActivityStatus() {
        return activityDesc;
    }
    
      public void setActivityBudget(double activityBudget) {
        this.activityBudget = activityBudget;
    }

    public double getActivityBudget() {
        return activityBudget;
    }
    
      public void setAttendance(boolean attendance) {
        this.attendance = attendance;
    }

    public boolean getAttendance() {
        return attendance;
    }
}
