package com.app.service.inventory.ItemType;

import com.app.entity.ItemTypeEntity;

import java.util.List;
import java.util.Map;

public interface ItemTypeService {

    public ItemTypeEntity saveUpdateItemType(Map<String, Object> param);
    public List<ItemTypeEntity> getAllItemTypeData(Map<String, Object>param);
    public ItemTypeEntity getItemTypeDataById(Map<String,Object>param);
    void deleteItemTypeById(Map<String,Object>param);
}
