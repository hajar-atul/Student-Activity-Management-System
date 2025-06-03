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
public class STAFF {
    private int staffId;
    private String staffName;
    private String staffEmail;
    private String staffPosition;
    private String staffNoPhone;
    private String staffDepartment;
    private String staffPassword;
    
    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public int getStaffId() {
        return staffId;
    }
    
    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public String getStaffName() {
        return staffName;
    }
    
    public void setStaffEmail(String staffEmail) {
        this.staffEmail = staffEmail;
    }

    public String getStaffEmail() {
        return staffEmail;
    }
    
    public void setStaffPosition(String staffPosition) {
        this.staffPosition = staffPosition;
    }

    public String getStaffPosition() {
        return staffPosition;
    }
    
    public void setStaffNoPhone(String staffNoPhone) {
        this.staffNoPhone = staffNoPhone;
    }

    public String getStaffNoPhone() {
        return staffNoPhone;
    }
    
    public void setStaffDepartment(String staffDepartment) {
        this.staffDepartment = staffDepartment;
    }

    public String getStaffDepartment() {
        return staffDepartment;
    }
}
