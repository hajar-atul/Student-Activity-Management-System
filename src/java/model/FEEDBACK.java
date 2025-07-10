package model;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import util.DBConnection;

/**
 *
 * @author User
 */
public class FEEDBACK {
    private String feedbackID;
    private int feedRating;
    private int studID;
    private String feedComment;
    private String DateSubmit;
    private String activityID;

    // Setter and Getter for feedBackID
    public void setFeedbackId(String feedbackID) {
        this.feedbackID = feedbackID;
    }

    public String getFeedbackId() {
        return feedbackID;
    }

    // Setter and Getter for feedRating
    public void setFeedRating(int feedRating) {
        this.feedRating = feedRating;
    }

    public int getFeedRating() {
        return feedRating;
    }

    // Setter and Getter for studID
    public void setStudId(int studID) {
        this.studID = studID;
    }

    public int getStudID() {
        return studID;
    }

    // Setter and Getter for feedComment
    public void setFeedComment(String feedComment) {
        this.feedComment = feedComment;
    }

    public String getFeedComment() {
        return feedComment;
    }

    // Setter and Getter for DateSubmit
    public void setDateSubmit(String dateSubmit) {
        this.DateSubmit = dateSubmit;
    }

    public String getDateSubmit() {
        return DateSubmit;
    }

    public void setActivityID(String activityID) { this.activityID = activityID; }
    public String getActivityID() { return activityID; }

    // DAO: Insert feedback
    public static boolean insertFeedback(String feedComment, int feedRating, int studID, String activityID) {
        boolean success = false;
        try (
            java.sql.Connection conn = DBConnection.getConnection();
            java.sql.PreparedStatement ps = conn.prepareStatement("INSERT INTO feedback (feedComment, feedRating, DateSubmit, studID, activityID) VALUES (?, ?, NOW(), ?, ?)")
        ) {
            ps.setString(1, feedComment);
            ps.setInt(2, feedRating);
            ps.setInt(3, studID);
            ps.setString(4, activityID);
            int result = ps.executeUpdate();
            if (result > 0) success = true;
        } catch (Exception e) { e.printStackTrace(); }
        return success;
    }

    // DAO: Get feedbacks by activityID
    public static java.util.List<FEEDBACK> getFeedbacksByActivityId(String activityID) {
        java.util.List<FEEDBACK> list = new java.util.ArrayList<>();
        try (
            java.sql.Connection conn = DBConnection.getConnection();
            java.sql.PreparedStatement ps = conn.prepareStatement("SELECT * FROM feedback WHERE activityID = ? ORDER BY DateSubmit DESC")
        ) {
            ps.setString(1, activityID);
            java.sql.ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                FEEDBACK f = new FEEDBACK();
                f.setFeedbackId(rs.getString("feedbackID"));
                f.setFeedComment(rs.getString("feedComment"));
                f.setFeedRating(rs.getInt("feedRating"));
                f.setDateSubmit(rs.getString("DateSubmit"));
                f.setStudId(rs.getInt("studID"));
                f.setActivityID(rs.getString("activityID"));
                list.add(f);
            }
            rs.close();
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // DAO: Get feedbacks by studentID
    public static java.util.List<FEEDBACK> getFeedbacksByStudentId(int studID) {
        java.util.List<FEEDBACK> list = new java.util.ArrayList<>();
        try (
            java.sql.Connection conn = DBConnection.getConnection();
            java.sql.PreparedStatement ps = conn.prepareStatement("SELECT * FROM feedback WHERE studID = ? ORDER BY DateSubmit DESC")
        ) {
            ps.setInt(1, studID);
            java.sql.ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                FEEDBACK f = new FEEDBACK();
                f.setFeedbackId(rs.getString("feedbackID"));
                f.setFeedComment(rs.getString("feedComment"));
                f.setFeedRating(rs.getInt("feedRating"));
                f.setDateSubmit(rs.getString("DateSubmit"));
                f.setStudId(rs.getInt("studID"));
                f.setActivityID(rs.getString("activityID"));
                list.add(f);
            }
            rs.close();
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}

