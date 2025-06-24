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
public class ADAB_POINT {
    private int studID;
    private int staffID;
    private int activityID;
    private int adabPoint;
    
    public void setStudId(int studID) {
        this.studID = studID;
    }

    public int getStudId() {
        return studID;
    }
    
    public void setStaffId(int staffID) {
        this.staffID = staffID;
    }

    public int getStaffId() {
        return staffID;
    }
    
    public void setActivityID(int activityID) {
        this.activityID = activityID;
    }

    public int getActivityID() {
        return activityID;
    }
    
    public void setAdabPoint(int adabPoint) {
        this.adabPoint= adabPoint;
    }

    public int getAdabPoint() {
        return adabPoint;
    }
}
