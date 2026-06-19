package com.app.rest;

import com.app.service.inventory.vendor.VendorService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/vendor")
@AllArgsConstructor
public class VendorRestController {

    private final VendorService vendorService;

    @PostMapping("/saveUpdateVendor")
    public ResponseEntity<?> saveUpdateVendor(@RequestBody Map<String,Object> param){
        try {
            vendorService.saveUpdateVendor(param);
            return ResponseEntity.ok("Vendor Saved Successfully");
        }catch (Exception e){
            System.err.println("Error While Saving Vendor : " + e.getMessage());
            return new ResponseEntity<>("Failed To Save Vendor : "+ e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }
    @GetMapping("/getAllVendorData")
    public ResponseEntity<?> getAllVendorData(Map<String,Object> param){
        try {
            return new ResponseEntity<>(vendorService.getAllVendorData(param) ,HttpStatus.OK);
        }catch (Exception e) {
            System.err.println("Error While Fetching Vendors : " + e.getMessage());
            return new ResponseEntity<>("Failed To Fetch Vendors : " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @GetMapping("/getVendorDataById")
    public ResponseEntity<?> getVendorDataById(@RequestParam Map<String,Object> param){
        try {
            return new ResponseEntity<>(vendorService.getVendorDataById(param),HttpStatus.OK);
        }catch (Exception e){
            System.err.println("Error While Fetching Vendor : " + e.getMessage());
            return new ResponseEntity<>("Failed To Fetch Vendor : " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @PostMapping("/deleteVendorById")
    public ResponseEntity<?> deleteVendorById(@RequestBody Map<String,Object> param){
            try {
                vendorService.deleteVendorById(param);
                return ResponseEntity.ok("Vendor Deleted Successfully");
            }catch (Exception e){
                System.err.println("Error While Deleting Vendor : " + e.getMessage());
                return new ResponseEntity<>("Failed To Delete Vendor : " + e.getMessage(),
                        HttpStatus.INTERNAL_SERVER_ERROR);
            }
    }
}
