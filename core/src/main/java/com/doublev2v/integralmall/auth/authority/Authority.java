package com.doublev2v.integralmall.auth.authority;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.springframework.security.core.GrantedAuthority;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="auth")
public class Authority implements GrantedAuthority {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private String authority;
	private String name;
	private String description;
	@JsonIgnore
	private AuthorityGroup group;
	private String groupid;
	@Id
	@GenericGenerator(name="idGenerator",strategy="uuid")
	@GeneratedValue(generator="idGenerator")
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * @return the gourp
	 */
	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="group_id")
	public AuthorityGroup getGroup() {
		return group;
	}
	/**
	 * @param gourp the gourp to set
	 */
	public void setGroup(AuthorityGroup group) {
		this.group = group;
	}	
	/**
	 * 提供显示外键关联，同时方便传参
	 * @return the groupid
	 */
	@Column(name="group_id",insertable=false,updatable=false)
	public String getGroupid() {
		return groupid;
	}
	/**
	 * @param groupid the groupid to set
	 */
	public void setGroupid(String groupid) {
		this.groupid = groupid;
	}
	/**
	 * @return the authority
	 */
	@Override
	@Column(unique=true,nullable=false)
	public String getAuthority() {
		return authority;
	}
	/**
	 * @param authority the authority to set
	 */
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}
}
