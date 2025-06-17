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
public class BOOKING {
    private int clubID;
    private int staffID;
    private String venue;
    private String logistic;
    
    public void setClubId(int clubID) {
        this.clubID = clubID;
    }

    public int getClubId() {
        return clubID;
    }
    
    public void setStaffId(int staffID) {
        this.staffID = staffID;
    }

    public int getStaffId() {
        return staffID;
    }
    
    public void setVenue(String venue) {
        this.venue = venue;
    }

    public String getVenue() {
        return venue;
    }
    
    public void setLogistic(String logistic) {
        this.logistic = logistic;
    }

    public String getLogistic() {
        return logistic;
    }
}
