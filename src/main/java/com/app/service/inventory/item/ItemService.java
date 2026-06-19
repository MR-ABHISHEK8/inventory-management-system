package com.app.service.inventory.item;

import com.app.entity.ItemEntity;
import org.springframework.http.ResponseEntity;

import java.util.List;
import java.util.Map;

public interface ItemService {
    Map<String,Object> getItemBasicDetails();
    public ItemEntity saveUpdateItemData(Map<String,Object>param);

    public List<ItemEntity> getAllItemData(Map<String,Object>param);
    public ItemEntity getItemDataById(Map<String,Object> param);
    public void itemDataDeleteById(Map<String,Object> param);
}
