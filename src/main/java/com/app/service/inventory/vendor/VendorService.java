package com.app.service.inventory.vendor;

import com.app.entity.VendorEntity;

import java.util.List;
import java.util.Map;

public interface VendorService {

    public VendorEntity saveUpdateVendor(Map<String,Object> param);
    public List<VendorEntity> getAllVendorData(Map<String,Object> param);
    public VendorEntity getVendorDataById(Map<String,Object> param);
    public void deleteVendorById(Map<String,Object> param);
}
