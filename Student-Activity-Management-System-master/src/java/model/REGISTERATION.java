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
public class REGISTERATION {
    private int studID;
    private int activityID;
    private String regDate;
    
    public void setStudId(int studID) {
        this.studID = studID;
    }

    public int getStudId() {
        return studID;
    }
    
    public void setActivityId(int activityID) {
        this.activityID = activityID;
    }

    public int getActivityId() {
        return activityID;
    }
    
    public void setRegDate(String regDate) {
        this.regDate = regDate;
    }

    public String getRegDate() {
        return regDate;
    }
}
