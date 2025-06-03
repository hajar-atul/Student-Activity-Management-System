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
    private int studId;
    private int activityId;
    private String regDate;
    
    public void setStudId(int studId) {
        this.studId = studId;
    }

    public int getStudId() {
        return studId;
    }
    
    public void setActivityId(int activityId) {
        this.activityId = activityId;
    }

    public int getActivityId() {
        return activityId;
    }
    
    public void setRegDate(String regDate) {
        this.regDate = regDate;
    }

    public String getRegDate() {
        return regDate;
    }
}
