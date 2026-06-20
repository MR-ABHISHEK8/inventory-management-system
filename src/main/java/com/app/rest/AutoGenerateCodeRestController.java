package com.app.rest;

import com.app.service.inventory.AutoGenerateCode.AutoGenerateCodeService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@AllArgsConstructor
@RequestMapping("/rest/autoGenerateCode")
public class AutoGenerateCodeRestController {

    private final AutoGenerateCodeService autoGenerateCodeService;

    @PostMapping("saveUpdateAutoGenerateCode")
    public ResponseEntity<?> saveUpdateAutoGenerateCode(@RequestBody Map<String,Object> param){
        try {
            return new ResponseEntity<>(autoGenerateCodeService.saveUpdateAutoGenerateCode(param) , HttpStatus.OK);
        }catch (Exception e){
            System.err.println("Error While Fetching AutoGenerateCode : " + e.getMessage());
            return new ResponseEntity<>("Failed To Fetch AutoGenerateCode :" + e.getMessage(),HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @GetMapping("getAllAutoGenerateCode")
    public ResponseEntity<?> getAllAutoGenerateCode( Map<String, Object> param){
        try {
            return new ResponseEntity<>(autoGenerateCodeService.getAllAutoGenerateCode(param),HttpStatus.OK);
        }catch (Exception e){
            System.err.println("Error While Fetching AutoGenerateCode :"  + e.getMessage());
            return new ResponseEntity<>("Failed To Get AutoGenerateCode :" + e.getMessage() ,HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @GetMapping("getAutoGenerateCodeById")
    public ResponseEntity<?> getAutoGenerateCodeById(@RequestParam Map<String,Object> param){
        try {
            return new ResponseEntity<>(autoGenerateCodeService.getAutoGenerateCodeById(param) ,HttpStatus.OK);
        }catch (Exception e){
            System.err.println("Error While Fetching AutoGenerateCode :"  + e.getMessage());
            return new ResponseEntity<>("Failed To Get AutoGenerateCode :" + e.getMessage(),HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @PostMapping("autoGenerateCodeDeleteById")
   public ResponseEntity<?> autoGenerateCodeDeleteById(@RequestBody Map<String,Object> param){
        try {
            autoGenerateCodeService.autoGenerateCodeDeleteById(param);
            return ResponseEntity.ok("AutoGenerateCode Delete Successfully ");
        }catch (Exception e){
            System.err.println("Error While Fetching AutoGenerateCode :"  + e.getMessage());
            return new ResponseEntity<>("Failed To delete AutoGenerateCode :" + e.getMessage() ,HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
