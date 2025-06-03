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
    private int studId;
    private int paymentId;
    private String transferDate;
    
    public void setStudId(int studId) {
        this.studId = studId;
    }

    public int getStudId() {
        return studId;
    }
    
    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public int getPaymentId() {
        return paymentId;
    }
    
    public void setTransferDate(String transferDate) {
        this.transferDate = transferDate;
    }

    public String getTransferDate() {
        return transferDate;
    }
}
