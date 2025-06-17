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
public class PROPOSAL {
    private int proposalID;
    private String proposalName;
    private String proposalDetails;
    private String submissionDate;
    private int clubID;
    
    public void setProposalId(int proposalID) {
        this.proposalID = proposalID;
    }

    public int getProposalId() {
        return proposalID;
    }
    
    public void setProposalName(String proposalName) {
        this.proposalName = proposalName;
    }

    public String getProposalName() {
        return proposalName;
    }
    
    public void setProposalDetails(String proposalDetails) {
        this.proposalDetails = proposalDetails;
    }

    public String getProposalDetails() {
        return proposalDetails;
    }
    
    public void setSubmissionDate(String submissionDate) {
        this.submissionDate = submissionDate;
    }

    public String getSubmissionDate() {
        return submissionDate;
    }
    
    public void setClubId(int clubID) {
        this.clubID = clubID;
    }

    public int getlubId() {
        return clubID;
    }
}
