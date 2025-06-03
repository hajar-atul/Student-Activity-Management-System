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
    private int clubId;
    private int staffId;
    private String venue;
    private String logistic;
    
    public void setClubId(int clubId) {
        this.clubId = clubId;
    }

    public int getClubId() {
        return clubId;
    }
    
    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public int getStaffId() {
        return staffId;
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
