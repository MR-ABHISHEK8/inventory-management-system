package com.app.service.inventory.vendor;

import com.app.entity.VendorEntity;
import com.app.repository.VendorRepository;
import com.app.utility.Utility;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@AllArgsConstructor
public class VendorServiceImpl implements VendorService{

    private final VendorRepository vendorRepository;
    private final Utility utility;
    @Override
    public VendorEntity saveUpdateVendor(Map<String, Object> param) {
        String vendorName = String.valueOf(param.get("vendorName"));
        String email = String.valueOf(param.get("email"));
        String phoneNo = String.valueOf(param.get("phoneNo"));
        String gstNo = String.valueOf(param.get("gstNo"));
        String city = String.valueOf(param.get("city"));
        String address = String.valueOf(param.get("address"));

//        Long id = Long.parseLong(String.valueOf(param.get("id")));
        Long id = utility.longNullValue(param.get("id"));
        VendorEntity vendorEntity= new VendorEntity();

        if (id != null) {
              vendorEntity = vendorRepository.findById(id).orElseThrow(()->new RuntimeException("Vendor Not Found"));
        }

        vendorEntity.setVendorName(vendorName);
        vendorEntity.setEmail(email);
        vendorEntity.setPhoneNo(phoneNo);
        vendorEntity.setGstNo(gstNo);
        vendorEntity.setCity(city);
        vendorEntity.setAddress(address);
        return vendorRepository.save(vendorEntity);
    }

    @Override
    public List<VendorEntity> getAllVendorData(Map<String, Object> param) {
        return vendorRepository.findAll();
    }

    @Override
    public VendorEntity getVendorDataById(Map<String, Object> param) {
        Long id =Long.parseLong(String.valueOf(param.get("id")));
        if (id == null) throw new RuntimeException("id not found !");
        VendorEntity vendorEntity = vendorRepository.findById(id).get();
        return vendorEntity;
    }
    @Override
    public void deleteVendorById(Map<String, Object> param) {
        Long id = Long.parseLong(String.valueOf(param.get("id")));
        if (id == null) throw new RuntimeException("id not found !");
         vendorRepository.deleteById(id);
    }
}
