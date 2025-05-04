package com.codingdojo.chorestrackerpro.models;

import java.util.Date;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.Size;
import jakarta.persistence.JoinColumn;

@Entity
@Table(name = "users")
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Size(min=3, max=30)
    private String firstName;
    
	@Size(min=3, max=30)
    private String lastName;
    
	@Size(min=5)
    private String email;
    
	@Size(min=5)
    private String password;
	
    private int totalPoints;
    
    @Transient
    private String confirm;
    
    @Column(updatable=false)
    private Date createdAt;
    
    @PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    
    private Date lastLogin;
    
	@OneToMany(mappedBy = "choreCreater", fetch = FetchType.LAZY)
	private List<Chore> choreCreater;
	
	@OneToMany(mappedBy = "userChores", fetch = FetchType.LAZY)
	private List<Chore> userChores;
    
    @ManyToMany(fetch=FetchType.EAGER)
    @JoinTable(
    		name = "user_roles",
    		joinColumns = @JoinColumn(name = "user_id"),
    		inverseJoinColumns = @JoinColumn(name = "role_id")
    		)
    private List<Role> roles;
    
    public User() {}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getConfirm() {
		return confirm;
	}

	public void setConfirm(String confirm) {
		this.confirm = confirm;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getLastLogin() {
		return lastLogin;
	}

	public void setLastLogin(Date lastLogin) {
		this.lastLogin = lastLogin;
	}

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}
	
	public List<Chore> getChores() {
		return choreCreater;
	}

	public void setChores(List<Chore> chores) {
		this.choreCreater = chores;
	}	

	public List<Chore> getUserChores() {
		return userChores;
	}

	public void setUserChores(List<Chore> userChores) {
		this.userChores = userChores;
	}

	public int getTotalPoints() {
		return totalPoints;
	}

	public void setTotalPoints(int totalPoints) {
		this.totalPoints = totalPoints;
	}

	public List<Chore> getChoreCreater() {
		return choreCreater;
	}

	public void setChoreCreater(List<Chore> choreCreater) {
		this.choreCreater = choreCreater;
	}
}
