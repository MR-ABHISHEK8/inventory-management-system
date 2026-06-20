package com.app.service.inventory.AutoGenerateCode;

import com.app.entity.AutoGenerateCodeEntity;

import java.util.List;
import java.util.Map;

public interface AutoGenerateCodeService {

    public AutoGenerateCodeEntity saveUpdateAutoGenerateCode(Map<String,Object> param);
    public List<AutoGenerateCodeEntity> getAllAutoGenerateCode(Map<String,Object> param);
    public AutoGenerateCodeEntity getAutoGenerateCodeById(Map<String,Object> param);
    void autoGenerateCodeDeleteById(Map<String,Object> param);

}
