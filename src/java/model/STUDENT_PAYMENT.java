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
public class STUDENT_PAYMENT {
    private int studID;
    private int paymentID;
    
    public void setStudId(int studID) {
        this.studID = studID;
    }

    public int getStudId() {
        return studID;
    }
    
    public void setPaymentId(int paymentID) {
        this.paymentID = paymentID;
    }

    public int getPaymentId() {
        return paymentID;
    }
}
