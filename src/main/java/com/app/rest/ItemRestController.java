package com.app.rest;

import com.app.service.inventory.item.ItemService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/rest/item/")
@AllArgsConstructor
public class ItemRestController {


    private final ItemService itemService;

    @GetMapping("getItemBasicDetails")
    public ResponseEntity<?> getItemBasicDetails(){
        try {
            return new ResponseEntity<>(itemService.getItemBasicDetails(),HttpStatus.OK);
        }catch (Exception e) {
            System.err.println("Error While Fetching Measurement Type : " + e.getMessage());
            return new ResponseEntity<>("Failed To Fetch Measurement Type : " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("saveUpdateItemData")
    public ResponseEntity<?> saveUpdateItemData(@RequestBody Map<String,Object> param){
        try {
            return new ResponseEntity<>(itemService.saveUpdateItemData(param),HttpStatus.OK);
        }catch (Exception e) {
            System.err.println("Error While Fetching Measurement Type : " + e.getMessage());
            return new ResponseEntity<>("Failed To Fetch Measurement Type : " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("getAllItemData")
    public ResponseEntity<?> getAllItemData(Map<String,Object> param){
        try {
            return new ResponseEntity<>(itemService.getAllItemData(param),HttpStatus.OK);
        }catch (Exception e) {
            System.err.println("Error While Fetching Measurement Type : " + e.getMessage());
            return new ResponseEntity<>("Failed To Fetch Measurement Type : " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("getItemTypeDataById")
    public ResponseEntity<?> getItemTypeDataById(@RequestParam Map<String,Object> param){
        try {
            return new ResponseEntity<>(itemService.getItemDataById(param), HttpStatus.OK);
        } catch (Exception e) {
            System.err.println("Error While Fetching Item : " + e.getMessage());
            return new ResponseEntity<>("Failed To Fetch Item : " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @PostMapping("deleteItemTypeById")
    ResponseEntity<String> deleteItemTypeById(@RequestBody Map<String,Object>param){
        try {
            itemService.itemDataDeleteById(param);
            return ResponseEntity.ok("Item Deleted Successfully");
        }catch (Exception e) {
            System.err.println("Error While Fetching Measurement Type : " + e.getMessage());
            return new ResponseEntity<>("Failed To Fetch Measurement Type : " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
