package model;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author User
 */
public class FEEDBACK {
    private int feedbackID;
    private int feedRating;
    private int studID;
    private String feedComment;
    private String DateSubmit;

    // Setter and Getter for feedBackID
    public void setFeedbackId(int feedbackID) {
        this.feedbackID = feedbackID;
    }

    public int getFeedbackId() {
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
}

