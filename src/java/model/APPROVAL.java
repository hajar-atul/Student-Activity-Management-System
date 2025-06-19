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
public class APPROVAL {
    private int approvalID;
    private String approvalActivity;
    private String approvalBudget;
    private int proposalID;
    private int studID;
    
    public void setApprovalId(int approvalID) {
        this.approvalID = approvalID;
    }

    public int getApprovalId() {
        return approvalID;
    }
    
    public void setApprovalActivity(String approvalActivity) {
        this.approvalActivity = approvalActivity;
    }

    public String getApprovalActivity() {
        return approvalActivity;
    }
    
    public void setApprovalBudget(String approvalBudget) {
        this.approvalBudget = approvalBudget;
    }

    public String getApprovalBudget() {
        return approvalBudget;
    }
    
    public void setProposallId(int proposalID) {
        this.proposalID = proposalID;
    }

    public int getProposalId() {
        return proposalID;
    }
    
    public void setStudlId(int studID) {
        this.studID = studID;   
    }

    public int getStudId() {
        return studID;
    }
}
