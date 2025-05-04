package com.codingdojo.chorestrackerpro.models;

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
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "subChores")
public class SubChore {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@NotNull(message = "Sub chore title is required!")
	@Size(min = 3, max = 200, message = "Sub chore title must be at least 3 characters.")
	private String title;
	
	private boolean doneSub;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "chore_id")
	private Chore choreSub;

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
	
	public SubChore() {}

	public SubChore(Long id, String title, Chore chore_sub) {
		super();
		this.id = id;
		this.title = title;
		this.choreSub = chore_sub;
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

	public Chore getChore_sub() {
		return choreSub;
	}

	public void setChore_sub(Chore chore_sub) {
		this.choreSub = chore_sub;
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

	public boolean isDoneSub() {
		return doneSub;
	}

	public void setDoneSub(boolean doneSub) {
		this.doneSub = doneSub;
	}

	public Chore getChoreSub() {
		return choreSub;
	}

	public void setChoreSub(Chore choreSub) {
		this.choreSub = choreSub;
	}
	
	
	
	
}
