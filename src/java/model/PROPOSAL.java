/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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
    
    // Database connection details
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/student?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";
    
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
    
    public static List<PROPOSAL> getPendingProposals() {
        List<PROPOSAL> proposals = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "SELECT * FROM proposal WHERE status = 'pending'";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);
                while (rs.next()) {
                    PROPOSAL proposal = new PROPOSAL();
                    proposal.setProposalID(rs.getInt("proposalID"));
                    proposal.setProposalName(rs.getString("proposalName"));
                    proposal.setSubmissionDate(rs.getString("submissionDate"));
                    proposal.setClubID(rs.getInt("clubID"));
                    proposal.setStatus(rs.getString("status"));
                    proposals.add(proposal);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return proposals;
    }

    public static List<PROPOSAL> getReviewedProposals() {
        List<PROPOSAL> proposals = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "SELECT * FROM proposal WHERE status IN ('approved', 'rejected')";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);
                while (rs.next()) {
                    PROPOSAL proposal = new PROPOSAL();
                    proposal.setProposalID(rs.getInt("proposalID"));
                    proposal.setProposalName(rs.getString("proposalName"));
                    proposal.setSubmissionDate(rs.getString("submissionDate"));
                    proposal.setClubID(rs.getInt("clubID"));
                    proposal.setStatus(rs.getString("status"));
                    proposals.add(proposal);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return proposals;
    }

    public static PROPOSAL getProposalById(int proposalId) {
        PROPOSAL proposal = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "SELECT * FROM proposal WHERE proposalID = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, proposalId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    proposal = new PROPOSAL();
                    proposal.setProposalID(rs.getInt("proposalID"));
                    proposal.setProposalName(rs.getString("proposalName"));
                    proposal.setProposalDetails(rs.getString("proposalDetails"));
                    proposal.setSubmissionDate(rs.getString("submissionDate"));
                    proposal.setClubID(rs.getInt("clubID"));
                    proposal.setStatus(rs.getString("status"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return proposal;
    }

    public static boolean updateProposalStatus(int proposalId, String status) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String query = "UPDATE proposal SET status = ? WHERE proposalID = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, status);
                stmt.setInt(2, proposalId);
                return stmt.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
