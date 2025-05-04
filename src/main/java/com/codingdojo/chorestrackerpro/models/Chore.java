package com.codingdojo.chorestrackerpro.models;

import java.time.LocalDate;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "chores")
public class Chore {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@NotNull(message = "Job title is required!")
	@Size(min = 3, max = 200, message = "Job title must be at least 3 characters.")
	private String title;

	@Column(columnDefinition = "TEXT")
	private String description;

	@NotNull(message = "Job location is required!")
	@Size(min = 3, max = 200, message = "Job location must be at least 3 characters.")
	private String location;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "chores_creater")
	private User choreCreater;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_chores")
	private User userChores;
	
	private boolean deleted;


	@NotNull(message = "Due Date is required!")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@FutureOrPresent(message = "Due date must be today or in the future.")
	private LocalDate dueDate;
	
	@NotNull(message = "Points are required!")
	@Min(value = 1, message = "Must be at least 1.")
	private int points;
	
	@Column(updatable = false)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date createdAt;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date updatedAt;

	@PrePersist
	protected void onCreate() {
		this.createdAt = new Date();
	}

	@PreUpdate
	protected void onUpdate() {
		this.updatedAt = new Date();
	}

	public Chore() {
	}

	

	public Chore(Long id, String title, String description, String location, User choreCreater, User userChores, LocalDate dueDate, int points) {
		super();
		this.id = id;
		this.title = title;
		this.description = description;
		this.location = location;
		this.choreCreater = choreCreater;
		this.userChores = userChores;
		this.dueDate = dueDate;
		this.points = points;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public User getChoreCreater() {
		return choreCreater;
	}

	public void setChoreCreater(User choreCreater) {
		this.choreCreater = choreCreater;
	}

	public User getUserChores() {
		return userChores;
	}

	public void setUserChores(User userChores) {
		this.userChores = userChores;
	}
	
	public LocalDate getDueDate() {
		return dueDate;
	}

	public void setDueDate(LocalDate dueDate) {
		this.dueDate = dueDate;
	}

	public int getPoints() {
		return points;
	}

	public void setPoints(int points) {
		this.points = points;
	}

	public boolean isDeleted() {
		return deleted;
	}

	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}
	
}
