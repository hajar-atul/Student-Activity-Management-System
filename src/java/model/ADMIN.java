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
public class ADMIN {
    private int studID;
    private String adminName;
    private String adminEmail;
       
    public void setStudId(int studID) {
        this.studID = studID;
    }

    public int getStudId() {
        return studID;
    }
    
    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    public String getAdminName() {
        return adminName;
    }
    
    public void setAdminEmail(String adminEmail) {
        this.adminEmail = adminEmail;
    }

    public String getAdminEmail() {
        return adminEmail;
    }
}
