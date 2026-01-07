package com.MainApp.Entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "request")
public class Request {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(nullable = false)
    private String requestTitle;

    @Column(nullable = false)
    private String requestType;

    @Column(nullable = false, length = 1000)
    private String requestMessage;

    @Column(nullable = false)
    private long userId;

    @Column(nullable = false)
    private String status; // PENDING / ACCEPTED / REJECTED

    @Column(nullable = false)
    private LocalDate requestDate;

    /* Automatically set default values before insert */
    @PrePersist
    public void prePersist() 
    {
        if (this.status == null) 
        {
            this.status = "PENDING";
        }
        if (this.requestDate == null) 
        {
            this.requestDate = LocalDate.now();
        }
    }

    // GETTERS & SETTERS
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getRequestTitle() {
        return requestTitle;
    }

    public void setRequestTitle(String requestTitle) {
        this.requestTitle = requestTitle;
    }

    public String getRequestType() {
        return requestType;
    }

    public void setRequestType(String requestType) {
        this.requestType = requestType;
    }

    public String getRequestMessage() {
        return requestMessage;
    }

    public void setRequestMessage(String requestMessage) {
        this.requestMessage = requestMessage;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDate getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(LocalDate requestDate) {
        this.requestDate = requestDate;
    }
}
