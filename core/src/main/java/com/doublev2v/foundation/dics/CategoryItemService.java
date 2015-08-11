package com.doublev2v.foundation.dics;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.doublev2v.foundation.core.dto.DtoPagingService;
import com.doublev2v.foundation.dics.dto.CategoryItemDto;

@Service
@Transactional
public class CategoryItemService extends DtoPagingService<CategoryItem, CategoryItemDto, String> {

	@Autowired
	public void setCategoryItemRepository(CategoryItemRepository repository) {
		super.setRepository(repository);
	}
	
	@Override
	public CategoryItemRepository getRepository() {
		return (CategoryItemRepository)super.getRepository();
	}
	
	public List<CategoryItemDto> getCategoryItemsByType(String type) {
		List<CategoryItem> items=getRepository().findByCategoryType(type);
		if(items==null) return null;
		List<CategoryItemDto> result=new ArrayList<CategoryItemDto>();
		result.addAll(adapter.convertDoList(items));
		return result;
	}
}
