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
public class PAYMENT {
    private int paymentID;
    private String paymentMethod;
    private String paymentDate;
    private String paymentTime;
    private double payment_total;
    
    public void setPaymentId(int paymentID) {
        this.paymentID = paymentID;
    }

    public int getPaymentId() {
        return paymentID;
    }
    
    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }
    
    public void setPaymentDate(String paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getPaymentDate() {
        return paymentDate;
    }
    
    public void setPaymentTime(String paymentTime) {
        this.paymentTime = paymentTime;
    }

    public String getPaymentTime() {
        return paymentTime;
    }
    
    public void setPaymentTotal(double payment_total) {
        this.payment_total = payment_total;
    }

    public double getPaymentTotal() {
        return payment_total;
    }
}
