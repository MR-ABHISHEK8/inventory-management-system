package com.app.service.inventory.taxType;

import com.app.entity.TaxTypeEntity;

import java.util.List;
import java.util.Map;

public interface TaxTypeService {

    public TaxTypeEntity saveUpdateTaxType(Map<String,Object> param);
    public List<TaxTypeEntity> getAllTaxTypeData(Map<String,Object> param);
    public TaxTypeEntity getTaxTypeDataById(Map<String,Object> param);
    void getTaxTypeDataDeleteById(Map<String,Object> param);
}

