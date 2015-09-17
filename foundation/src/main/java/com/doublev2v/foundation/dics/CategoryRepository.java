package com.doublev2v.foundation.dics;

import javax.persistence.QueryHint;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.QueryHints;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface CategoryRepository extends PagingAndSortingRepository<Category, String> {
	@QueryHints({ @QueryHint(name = "org.hibernate.cacheable", value ="true") })
	Category getByType(String type);
	
	@Modifying
	@Query("delete from Category c where c.type=?1")
	void deleteByType(String type);
	
	@Query("select DISTINCT c from Category c where c.parent is null")
	@Override
	public Iterable<Category> findAll();
	
	@Override
	@Query("select DISTINCT c from Category c where c.parent is null")
	public Page<Category> findAll(Pageable pageable);
}
