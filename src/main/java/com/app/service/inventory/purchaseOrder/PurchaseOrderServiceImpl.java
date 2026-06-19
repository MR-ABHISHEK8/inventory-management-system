package com.app.service.inventory.purchaseOrder;

import com.app.entity.ItemEntity;
import com.app.entity.ItemTypeEntity;
import com.app.entity.TaxTypeEntity;
import com.app.entity.VendorEntity;
import com.app.repository.ItemRepository;
import com.app.repository.ItemTypeRepository;
import com.app.repository.TaxTypeRepository;
import com.app.repository.VendorRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@AllArgsConstructor
public class PurchaseOrderServiceImpl implements PurchaseOrderService{

    private final ItemTypeRepository itemTypeRepository;
    private final VendorRepository vendorRepository;
    private final TaxTypeRepository taxTypeRepository;

    private final ItemRepository itemRepository;
    public Map<String,Object> getVendorAndItemTypeBasicDetails(){
        List<ItemTypeEntity> itemTypeEntityList = itemTypeRepository.findAll();
        List<VendorEntity> vendorEntityList = vendorRepository.findAll();
        List<ItemEntity> itemEntityList = itemRepository.findAll();
        List<TaxTypeEntity> taxTypeEntityList = taxTypeRepository.findAll();
        HashMap<String,Object> map = new HashMap<>();
        map.put("itemTypeList" ,itemTypeEntityList);
        map.put("vendorList",vendorEntityList);
        map.put("itemList" ,itemEntityList);
        map.put("taxTypeList",taxTypeEntityList);

        return map;
    }

}
