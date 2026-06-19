package com.app.service.inventory.taxType;

import com.app.entity.TaxTypeEntity;
import com.app.repository.TaxTypeRepository;
import com.app.utility.Utility;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@AllArgsConstructor
public class TaxTypeServiceImpl implements TaxTypeService{

    private final TaxTypeRepository taxTypeRepository;
    private final Utility utility;

    @Override
    public TaxTypeEntity saveUpdateTaxType(Map<String, Object> param) {
         String taxName = String.valueOf(param.get("taxName"));
         String taxCode = String.valueOf(param.get("taxCode"));
         Double taxPercentage = utility.doubleZeroValue(param.get("taxPercentage"));
         String description = String.valueOf(param.get("description"));

        Long id = utility.longNullValue(param.get("id"));

         TaxTypeEntity taxTypeEntity = new TaxTypeEntity();

        if (id != null) {
            taxTypeEntity = taxTypeRepository.findById(id).orElseThrow(()->new RuntimeException("Tax Type Not Found"));
        }

         taxTypeEntity.setTaxName(taxName);
         taxTypeEntity.setTaxCode(taxCode);
         taxTypeEntity.setTaxPercentage(taxPercentage);
         taxTypeEntity.setDescription(description);
        return taxTypeRepository.save(taxTypeEntity);
    }

    @Override
    public List<TaxTypeEntity> getAllTaxTypeData(Map<String, Object> param) {
        return taxTypeRepository.findAll();
    }

    @Override
    public TaxTypeEntity getTaxTypeDataById(Map<String, Object> param) {
        Long id = Long.parseLong(String.valueOf(param.get("id")));
        if (id == null) throw new RuntimeException("id not found !");
        TaxTypeEntity entity = taxTypeRepository.findById(id).get();
        return entity;
    }

    @Override
    public void getTaxTypeDataDeleteById(Map<String, Object> param) {
            Long id = Long.parseLong(String.valueOf(param.get("id")));
            if (id == null) throw new RuntimeException("id not found !");
            taxTypeRepository.deleteById(id);
    }
}
