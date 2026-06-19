package com.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class User {

    @GetMapping({"/","/item"})
    public String handleItem() {
        return "item";
    }
    @GetMapping("/measurement")
    public String handleMeasurementType() {
        return "measurementType";
    }
    @GetMapping("/itemType")
    public String handleItemType() {
        return "itemType";
    }
    @GetMapping("/vendor")
    public String handleVendor() {
        return "vendor";
    }
    @GetMapping("/taxType")
    public String handleTax() {
        return "taxType";
    }
    @GetMapping("/purchaseOrder")
    public String handlePurchaseOrder() {
        return "purchaseOrder";
    }
    @GetMapping("/addEditPurchaseOrder")
    public String handleAddEditPurchaseOrder() {
        return "addEditPurchaseOrder";
    }
}
