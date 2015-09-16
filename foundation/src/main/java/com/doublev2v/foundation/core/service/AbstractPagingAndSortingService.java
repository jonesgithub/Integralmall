package com.doublev2v.foundation.core.service;

import java.io.Serializable;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.doublev2v.foundation.core.model.PagedList;

public abstract class AbstractPagingAndSortingService<T, ID extends Serializable>
	extends AbstractCrudService<T, ID> implements PagingService<T, ID> {
	
	@Autowired
	public void setPagingAndSortingRepository(PagingAndSortingRepository<T, ID> repository) {
		super.setRepository(repository);
	}
	
	@Override
	public PagingAndSortingRepository<T, ID> getRepository() {
		return (PagingAndSortingRepository<T, ID>)super.getRepository();
	}
	
	@Override
	public PagedList<T> findPage(int page, int size) {
		page=page-1; //PageRequest从0开始，需要减一以匹配
		PageRequest pageable=new PageRequest(page, size);
		Page<T> result=getRepository().findAll(pageable);
		return new PagedList<>(result);
	}
}
