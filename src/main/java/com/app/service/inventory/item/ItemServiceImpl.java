package com.app.service.inventory.item;

import com.app.entity.ItemEntity;
import com.app.entity.ItemTypeEntity;
import com.app.entity.MeasurementEntity;
import com.app.entity.TaxTypeEntity;
import com.app.repository.ItemRepository;
import com.app.repository.ItemTypeRepository;
import com.app.repository.MeasurementRepository;
import com.app.repository.TaxTypeRepository;
import com.app.utility.Utility;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@AllArgsConstructor
public class ItemServiceImpl implements ItemService{

    private Utility utility;
    private ItemTypeRepository itemTypeRepository;
    private MeasurementRepository measurementRepository;
    private TaxTypeRepository taxTypeRepository;

    private final ItemRepository itemRepository;


    public Map<String,Object> getItemBasicDetails(){

        List<ItemTypeEntity> itemTypeEntities = itemTypeRepository.findAll();
        List<MeasurementEntity> measurementEntities = measurementRepository.findAll();
        List<TaxTypeEntity> taxTypeEntities = taxTypeRepository.findAll();

        Map<String,Object>map= new HashMap<>();
        map.put("itemTypeList",itemTypeEntities);
        map.put("measurementTypeList",measurementEntities);
        map.put("taxTypeList",taxTypeEntities);

        return map;
    }
// id -null ---- price -zero

    private String generateItemCode(Long itemTypeId){
        ItemTypeEntity itemTypeEntity = itemTypeRepository.findById(itemTypeId).orElseThrow(()->new RuntimeException("Item Type Not Found"));
        Long nextNumber = itemTypeEntity.getLastNo() + 1L;
        String itemCode = itemTypeEntity.getPrefix() + itemTypeEntity.getSeparator() + String.format("%0" + itemTypeEntity.getZeroPadding() + "d", nextNumber);
        itemTypeEntity.setLastNo(nextNumber);
        itemTypeRepository.save(itemTypeEntity);
        return itemCode;
    }
    @Override
    public ItemEntity saveUpdateItemData(Map<String, Object> param) {
        String itemName =String.valueOf(param.get("itemName"));
//        String itemCode = String.valueOf(param.get("itemCode"));
        String description = String.valueOf(param.get("description"));
        Double purchasePrice =utility.doubleZeroValue(param.get("purchasePrice"));
        Double salePrice = utility.doubleZeroValue(param.get("salePrice"));
        Long id =utility.longNullValue(param.get("id"));

        Long itemTypeId = utility.longNullValue(param.get("itemTypeId"));
        Long measurementTypeId = utility.longNullValue(param.get("measurementTypeId"));
        Long taxTypeId = utility.longNullValue(param.get("taxTypeId"));

        ItemEntity itemEntity = new ItemEntity();

        if (id != null){
            itemEntity = itemRepository.findById(id).get();
        }
        if (id == null) {
            itemEntity.setItemCode(generateItemCode(itemTypeId));
        }
        itemEntity.setItemName(itemName);
//        itemEntity.setItemCode(itemCode);
        itemEntity.setDescription(description);
        itemEntity.setPurchasePrice(purchasePrice);
        itemEntity.setSalePrice(salePrice);
        itemEntity.setItemTypeId(itemTypeId);
        itemEntity.setMeasurementTypeId(measurementTypeId);
        itemEntity.setTaxTypeId(taxTypeId);

        return itemRepository.save(itemEntity);
    }

    @Override
    public List<ItemEntity> getAllItemData(Map<String, Object> param) {
        List<ItemEntity> entities=itemRepository.findAll();
        List<ItemEntity> allData = new ArrayList<>();
        for (ItemEntity itemEntity:entities){

            String measurementName = "";
            String itemTypeName = "";
            String taxTypeName = "";

            Long id = itemEntity.getId();
            Long measurement_id = itemEntity.getMeasurementTypeId();

            if (measurement_id != null && measurement_id > 0){
                Optional<MeasurementEntity> measurement  = measurementRepository.findById(measurement_id);
                if (measurement.isPresent()){
                    measurementName = measurement.get().getName();
                }
            }
            Long itemTypeId =itemEntity.getItemTypeId();
            if (itemTypeId != null && itemTypeId > 0){
                Optional<ItemTypeEntity> itemTypeEntity  = itemTypeRepository.findById(itemEntity.getItemTypeId());
                 if (itemTypeEntity.isPresent()){
                     itemTypeName = itemTypeEntity.get().getName();
                 }
            }
            if (itemEntity.getTaxTypeId() != null){
                Optional<TaxTypeEntity> taxType = taxTypeRepository.findById(itemEntity.getTaxTypeId());
                if (taxType.isPresent()){
                    taxTypeName = taxType.get().getTaxName();
                }
            }
            ItemEntity entity = new ItemEntity();

            entity.setId(itemEntity.getId());
            entity.setItemName(itemEntity.getItemName());
            entity.setItemCode(itemEntity.getItemCode());
            entity.setPurchasePrice(itemEntity.getPurchasePrice());
            entity.setSalePrice(itemEntity.getSalePrice());
            entity.setDescription(itemEntity.getDescription());

            entity.setMeasurementName(measurementName);
            entity.setItemTypeName(itemTypeName);
            entity.setTaxTypeName(taxTypeName);

            allData.add(entity);
        }
        return allData;
    }
    @Override
    public ItemEntity getItemDataById(Map<String,Object> param){
        Long id = utility.longNullValue(param.get("id"));
        if (id == null) {
            throw new RuntimeException("Id Not Found" + id);
        }
        return itemRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Item Not Found"));
    }
    @Override
    public void itemDataDeleteById(Map<String,Object> param){
        Long id = utility.longNullValue(param.get("id"));
        if (id == null) throw new RuntimeException("Item id is not found");
        itemRepository.deleteById(id);
    }

}
