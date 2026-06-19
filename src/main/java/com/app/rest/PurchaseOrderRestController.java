package com.app.rest;

import com.app.service.inventory.purchaseOrder.PurchaseOrderService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@AllArgsConstructor
@RestController
@RequestMapping("/rest/purchaseOrder/")
public class PurchaseOrderRestController {

    private final PurchaseOrderService purchaseOrderService;

    @GetMapping("getVendorAndItemTypeBasicDetails")
    public ResponseEntity<?> getVendorAndItemTypeBasicDetails(){
        try {
            return new ResponseEntity<>(purchaseOrderService.getVendorAndItemTypeBasicDetails(), HttpStatus.OK);
        }catch (Exception e) {
            System.err.println("Error While Fetching Add edit vendor Basic Details : " + e.getMessage());
            return new ResponseEntity<>("Failed To Fetch Add edit vendor Basic Details Type : " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
