package com.app.service.inventory.ItemType;

import com.app.entity.ItemTypeEntity;
import com.app.repository.ItemTypeRepository;
import com.app.utility.Utility;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@AllArgsConstructor
public class ItemTypeServiceImpl implements ItemTypeService{

    private final ItemTypeRepository itemTypeRepository;
    private final Utility utility;
    @Override
    public ItemTypeEntity saveUpdateItemType(Map<String, Object> param) {
        String name= String.valueOf(param.get("name"));
        String prefix = String.valueOf(param.get("prefix"));
//        String suffix = String.valueOf(param.get("suffix"));
        String zeroPadding = String.valueOf(param.get("zeroPadding"));
        String separator = String.valueOf(param.get("separator"));
        String startNo = String.valueOf(param.get("startNo"));
        String lastNo = String.valueOf(param.get("lastNo"));

        Long id = utility.longNullValue(param.get("id"));

        ItemTypeEntity entity= new ItemTypeEntity();
        if (id!=null){
            entity=itemTypeRepository.findById(id).get();
        }
        entity.setName(name);
        entity.setPrefix(prefix);
//        entity.setSuffix(suffix);
        entity.setSeparator(separator);
        entity.setZeroPadding(Long.valueOf(zeroPadding));
        entity.setStartNo(Long.valueOf(startNo));
        entity.setLastNo(Long.valueOf(lastNo));
        return itemTypeRepository.save(entity);
    }

    @Override
    public List<ItemTypeEntity> getAllItemTypeData(Map<String, Object> param) {
        List<ItemTypeEntity> entityList = itemTypeRepository.findAll();
        return entityList.stream().toList();
    }

    @Override
    public ItemTypeEntity getItemTypeDataById(Map<String, Object> param) {
        Long id =Long.parseLong(String.valueOf(param.get("id")));
        if (id == null) throw new RuntimeException("Item id is not found");
        ItemTypeEntity itemTypeEntity = itemTypeRepository.findById(id).get();
        return itemTypeEntity;
    }

    @Override
    public void deleteItemTypeById(Map<String, Object> param) {
        Long id = Long.parseLong(String.valueOf(param.get("id")));
        if (id == null) throw new RuntimeException("Item id is not found");
        itemTypeRepository.deleteById(id);
    }
}
