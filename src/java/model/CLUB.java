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
public class CLUB {
       private int clubId;
       private String clubName;
       private String clubContact;
       private String clubDesc;
       private String clubStatus;
       private String clubEstablishedDate;
       
       public void setClubId(int clubId) {
        this.clubId = clubId;
    }

    public int getClubId() {
        return clubId;
    }
    
    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public String getClubName() {
        return clubName;
    }
    
     public void setClubContact(String clubContact) {
        this.clubContact = clubContact;
    }

    public String getClubContact() {
        return clubContact;
    }
    
     public void setClubDesc(String clubDesc) {
        this.clubDesc = clubDesc;
    }

    public String getClubDesc() {
        return clubDesc;
    }
    
     public void setClubStatus(String clubStatus) {
        this.clubStatus = clubStatus;
    }

    public String getClubStatus() {
        return clubStatus;
    }
    
    public void setClubEstablishedDate(String clubEstablishedDate) {
        this.clubEstablishedDate = clubEstablishedDate;
    }

    public String getClubEstablisedDate() {
        return clubEstablishedDate;
    }
}
