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
    private int staffID;
    private String staffName;
    private String staffEmail;
    private String staffPhone;
    private String staffDepartment;
    private String staffPassword;
    
    public void setStaffId(int staffID) {
        this.staffID = staffID;
    }

    public int getStaffId() {
        return staffID;
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
    
    public void setStaffPhone(String staffPhone) {
        this.staffPhone = staffPhone;
    }

    public String getStaffPhone() {
        return staffPhone;
    }
    
    public void setStaffDepartment(String staffDepartment) {
        this.staffDepartment = staffDepartment;
    }

    public String getStaffDepartment() {
        return staffDepartment;
    }
    public void setStaffPassword(String staffPassword) {
        this.staffPassword = staffPassword;
    }

    public String getStaffPassword() {
        return staffPassword;
    }
}
