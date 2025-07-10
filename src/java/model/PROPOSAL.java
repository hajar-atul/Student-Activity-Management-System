/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DBConnection;

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
    private String status; // pending, approved, rejected
    
    public void setProposalID(int proposalID) {
        this.proposalID = proposalID;
    }

    public int getProposalID() {
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
    
    public void setClubID(int clubID) {
        this.clubID = clubID;
    }

    public int getClubID() {
        return clubID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    public static java.util.List<PROPOSAL> getPendingProposals() {
        java.util.List<PROPOSAL> proposals = new java.util.ArrayList<>();
        try (
            java.sql.Connection conn = DBConnection.getConnection();
            java.sql.Statement stmt = conn.createStatement();
            java.sql.ResultSet rs = stmt.executeQuery("SELECT * FROM proposal WHERE status = 'pending'")
        ) {
            while (rs.next()) {
                PROPOSAL proposal = new PROPOSAL();
                proposal.setProposalID(rs.getInt("proposalID"));
                proposal.setProposalName(rs.getString("proposalName"));
                proposal.setSubmissionDate(rs.getString("submissionDate"));
                proposal.setClubID(rs.getInt("clubID"));
                proposal.setStatus(rs.getString("status"));
                proposals.add(proposal);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return proposals;
    }

    public static java.util.List<PROPOSAL> getReviewedProposals() {
        java.util.List<PROPOSAL> proposals = new java.util.ArrayList<>();
        try (
            java.sql.Connection conn = DBConnection.getConnection();
            java.sql.Statement stmt = conn.createStatement();
            java.sql.ResultSet rs = stmt.executeQuery("SELECT * FROM proposal WHERE status IN ('approved', 'rejected')")
        ) {
            while (rs.next()) {
                PROPOSAL proposal = new PROPOSAL();
                proposal.setProposalID(rs.getInt("proposalID"));
                proposal.setProposalName(rs.getString("proposalName"));
                proposal.setSubmissionDate(rs.getString("submissionDate"));
                proposal.setClubID(rs.getInt("clubID"));
                proposal.setStatus(rs.getString("status"));
                proposals.add(proposal);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return proposals;
    }

    public static PROPOSAL getProposalById(int proposalId) {
        PROPOSAL proposal = null;
        try (
            java.sql.Connection conn = DBConnection.getConnection();
            java.sql.PreparedStatement stmt = conn.prepareStatement("SELECT * FROM proposal WHERE proposalID = ?")
        ) {
            stmt.setInt(1, proposalId);
            java.sql.ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                proposal = new PROPOSAL();
                proposal.setProposalID(rs.getInt("proposalID"));
                proposal.setProposalName(rs.getString("proposalName"));
                proposal.setProposalDetails(rs.getString("proposalDetails"));
                proposal.setSubmissionDate(rs.getString("submissionDate"));
                proposal.setClubID(rs.getInt("clubID"));
                proposal.setStatus(rs.getString("status"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return proposal;
    }

    public static boolean updateProposalStatus(int proposalId, String status) {
        try (
            java.sql.Connection conn = DBConnection.getConnection();
            java.sql.PreparedStatement stmt = conn.prepareStatement("UPDATE proposal SET status = ? WHERE proposalID = ?")
        ) {
            stmt.setString(1, status);
            stmt.setInt(2, proposalId);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
