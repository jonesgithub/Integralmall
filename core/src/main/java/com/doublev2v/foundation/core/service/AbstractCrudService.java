package com.doublev2v.foundation.core.service;

import java.io.Serializable;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.CrudRepository;
import org.springframework.transaction.annotation.Transactional;
@Transactional
public abstract class AbstractCrudService<T,ID extends Serializable> implements CrudService<T, ID> {
	
	private CrudRepository<T, ID> repository;
	

	public CrudRepository<T, ID> getRepository() {
		return repository;
	}

	@Autowired
	public void setRepository(CrudRepository<T, ID> repository) {
		this.repository = repository;
	}

	@Override
	public T add(T entity) {
		if(entity==null)return null;
		return getRepository().save(entity);
	}

	@Override
	public Iterable<T> addAll(Iterable<T> entities) {
		if(entities==null)return null;
		return getRepository().save(entities);
	}

	@Override
	public T findOne(ID id) {
		if(id==null)return null;
		return getRepository().findOne(id);
	}

	@Override
	public boolean exists(ID id) {
		return getRepository().exists(id);
	}

	@Override
	public Iterable<T> findAll() {
		return getRepository().findAll();
	}

	@Override
	public Iterable<T> findAll(Iterable<ID> ids) {
		if(ids==null)return null;
		return getRepository().findAll(ids);
	}

	@Override
	public long count() {
		return getRepository().count();
	}

	@Override
	public void delete(ID id) {
		if(id==null)return;
		getRepository().delete(id);
	}

	@Override
	public void delete(T entity) {
		if(entity==null)return;
		getRepository().delete(entity);
	}

	@Override
	public void delete(Iterable<? extends T> entities) {
		if(entities==null)return;
		getRepository().delete(entities);
	}

	@Override
	public void deleteAll(Iterable<ID> ids) {
		if(ids==null)return;
		for (ID id : ids) {
			delete(id);
		}
	}
}
