package com.doublev2v.foundation.dics;

import javax.persistence.Cacheable;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.doublev2v.foundation.core.entity.UUIDBaseModel;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "categoryitem")
@Cacheable
public class CategoryItem extends UUIDBaseModel {
	private String name;
	@JsonIgnore
	private String attr;            // 预留
	@JsonIgnore
	private String attr2;           // 其他属性信息
	@JsonIgnore
	private String remark; 	        // 描述
	@JsonIgnore
	private Category category;      // 所属分类
	@JsonIgnore
	private Integer priority;

	@ManyToOne(optional=false)
	@JoinColumn(name = "category_id")
	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public String getAttr() {
		return attr;
	}

	public void setAttr(String attr) {
		this.attr = attr;
	}
	
	public String getAttr2() {
		return attr2;
	}

	public void setAttr2(String attr2) {
		this.attr2 = attr2;
	}
	
	@JsonIgnore
	@Transient
	public String getType() {
		return category.getType();
	}

	/**
	 * @return the priority
	 */
	public Integer getPriority() {
		return priority;
	}

	/**
	 * @param priority the priority to set
	 */
	public void setPriority(Integer priority) {
		this.priority = priority;
	}
}
