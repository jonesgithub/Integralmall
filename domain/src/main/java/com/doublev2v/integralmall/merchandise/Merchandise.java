package com.doublev2v.integralmall.merchandise;

import java.util.Date;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.DiscriminatorColumn;
import javax.persistence.DiscriminatorType;
import javax.persistence.Entity;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinTable;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import com.doublev2v.foundation.core.entity.UUIDBaseModel;
import com.doublev2v.foundation.dics.CategoryItem;
import com.doublev2v.foundation.media.MediaContent;
import com.doublev2v.integralmall.shop.branch.BranchShop;
@Entity
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name="type",discriminatorType=DiscriminatorType.STRING)
public class Merchandise extends UUIDBaseModel{
	private String seq;//编号
	private CategoryItem classify;//商品分类
	private CategoryItem brand;//商品品牌
	private String name;//商品名称
	private long integralCount;//所需积分
	private long stock;//库存
	private String original;//渠道专享
	private String remark;//简介
	private String isShelve;//是否下架:true.上架，false.下架
	private MediaContent mainPicMedia;
	private Set<MediaContent> medias;
	private String type;
	private BranchShop shop;
	private Date startDate;
	private Date endDate;
	private String brief;//概要
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	@ManyToOne
	public CategoryItem getClassify() {
		return classify;
	}
	public void setClassify(CategoryItem classify) {
		this.classify = classify;
	}
	@ManyToOne
	public CategoryItem getBrand() {
		return brand;
	}
	public void setBrand(CategoryItem brand) {
		this.brand = brand;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getOriginal() {
		return original;
	}
	public void setOriginal(String original) {
		this.original = original;
	}
	public long getIntegralCount() {
		return integralCount;
	}
	public void setIntegralCount(long integralCount) {
		this.integralCount = integralCount;
	}
	public long getStock() {
		return stock;
	}
	public void setStock(long stock) {
		this.stock = stock;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getIsShelve() {
		return isShelve;
	}
	public void setIsShelve(String isShelve) {
		this.isShelve = isShelve;
	}
	@OneToMany
	@JoinTable
	public Set<MediaContent> getMedias() {
		return medias;
	}
	public void setMedias(Set<MediaContent> medias) {
		this.medias = medias;
	}
	@OneToOne
	public MediaContent getMainPicMedia() {
		return mainPicMedia;
	}
	public void setMainPicMedia(MediaContent mainPicMedia) {
		this.mainPicMedia = mainPicMedia;
	}
	@Column(name="type",insertable=false,updatable=false)
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	@ManyToOne
	public BranchShop getShop() {
		return shop;
	}
	public void setShop(BranchShop shop) {
		this.shop = shop;
	}
	
	public String getBrief() {
		return brief;
	}
	public void setBrief(String brief) {
		this.brief = brief;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	
		
}