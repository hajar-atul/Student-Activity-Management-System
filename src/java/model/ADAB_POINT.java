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
    private int studId;
    private int staffId;
    private int adabPoint;
    
    public void setStudId(int studId) {
        this.studId = studId;
    }

    public int getStudId() {
        return studId;
    }
    
    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public int getStaffId() {
        return staffId;
    }
    
    public void setAdabPoint(int adabPoint) {
        this.adabPoint= adabPoint;
    }

    public int getAdabPoint() {
        return adabPoint;
    }
}
