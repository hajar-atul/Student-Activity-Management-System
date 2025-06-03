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
    private int approvalId;
    private String approvalActivity;
    private String approvalBudget;
    private int proposalId;
    private int studId;
    
    public void setApprovalId(int approvalId) {
        this.approvalId = approvalId;
    }

    public int getApprovalId() {
        return approvalId;
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
    
    public void setProposallId(int proposallId) {
        this.proposalId = proposalId;
    }

    public int getProposalId() {
        return proposalId;
    }
    
    public void setStudlId(int studlId) {
        this.studId = studId;
    }

    public int getStudId() {
        return studId;
    }
}
