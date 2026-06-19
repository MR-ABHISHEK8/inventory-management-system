package com.app.rest;

import com.app.service.inventory.taxType.TaxTypeService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@AllArgsConstructor
@RequestMapping("/taxType")
public class TaxTypeRestController {

    private final TaxTypeService taxTypeService;

    @PostMapping("/saveUpdateTaxTypeData")
    public ResponseEntity<?> saveUpdateTaxTypeData(@RequestBody Map<String,Object> param){
        try {
            taxTypeService.saveUpdateTaxType(param);
            return ResponseEntity.ok("Vendor Saved Successfully");
        }catch (Exception e){
            System.err.println("Error While Saving Tax Type : " + e.getMessage());
            return new ResponseEntity<>("Failed To Tax Type : "+ e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @GetMapping("/getAllTaxTypeData")
    public ResponseEntity<?> getAllTaxTypeData(Map<String,Object> param){
                try {
                    return new ResponseEntity<>(taxTypeService.getAllTaxTypeData(param),HttpStatus.OK);
                }catch (Exception e){
                    System.err.println("Error While Saving Tax Type :" + e.getMessage());
                    return new ResponseEntity<>("Failed To Tax Type : "+ e.getMessage() , HttpStatus.INTERNAL_SERVER_ERROR);
                }
    }
    @GetMapping("/getTaxTypeDataById")
    public ResponseEntity<?> getTaxTypeDataById(@RequestParam Map<String,Object> param){
            try {
                return new ResponseEntity<>(taxTypeService.getTaxTypeDataById(param) ,HttpStatus.OK);
            }catch (Exception e){
                System.err.println("Error While Saving Tax Type :" + e.getMessage());
                return new ResponseEntity<>("Failed To Tax Type : "+ e.getMessage() , HttpStatus.INTERNAL_SERVER_ERROR);
            }
    }
    @PostMapping("/deleteTaxTypeById")
    public ResponseEntity<?> deleteTaxTypeById(@RequestBody Map<String,Object> param){
        try {
            taxTypeService.getTaxTypeDataDeleteById(param);
            return ResponseEntity.ok("Tax Type deleted successfully");
        }catch (Exception e){
            System.err.println("Error While Saving Tax Type :" + e.getMessage());
            return new ResponseEntity<>("Failed To Tax Type : "+ e.getMessage() , HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
