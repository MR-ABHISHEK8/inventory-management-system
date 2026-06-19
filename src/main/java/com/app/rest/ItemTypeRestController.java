package com.app.rest;

import com.app.service.inventory.ItemType.ItemTypeService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/itemType")
@AllArgsConstructor
public class ItemTypeRestController {

    private final ItemTypeService itemTypeService;

    @PostMapping("/saveUpdateItemType")
    public ResponseEntity<?> saveUpdateItemType(@RequestBody Map<String, Object> param){
        try {
            itemTypeService.saveUpdateItemType(param);
            return ResponseEntity.ok("Item Type Saved Successfully");
        }
        catch (Exception e){
            System.err.println("Error While Deleting Measurement Type : " + e.getMessage());
            return new ResponseEntity<>("Failed To Save Measurement Type : " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @GetMapping("/getAllItemTypeData")
    public ResponseEntity<?> getAllItemTypeData(Map<String, Object>param){
        try {
            return new ResponseEntity<>(itemTypeService.getAllItemTypeData(param), HttpStatus.OK);
        }catch (Exception e) {
            System.err.println("Error While Fetching Measurement Type : " + e.getMessage());
            return new ResponseEntity<>("Failed To Fetch Measurement Type : " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @GetMapping("/getItemTypeDataById")
    public ResponseEntity<?> getItemTypeDataById(@RequestParam Map<String,Object>param){
        try {
            return new ResponseEntity<>(itemTypeService.getItemTypeDataById(param) ,HttpStatus.OK);
        }catch (Exception e) {
            System.err.println("Error While Fetching Measurement Type : " + e.getMessage());
            return new ResponseEntity<>("Failed To Fetch Measurement Type : " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @PostMapping("/deleteItemTypeById")
    public ResponseEntity<?> deleteItemTypeById(@RequestBody Map<String,Object>param){
        try {
            itemTypeService.deleteItemTypeById(param);
            return ResponseEntity.ok("Item Type Deleted Successfully");
        } catch (Exception e) {
            System.err.println("Error While Deleting Item Type : " + e.getMessage());
            return new ResponseEntity<>("Failed To Delete Item Type : " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
