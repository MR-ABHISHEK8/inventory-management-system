package com.app.rest;

import com.app.service.inventory.measurementType.MeasurementService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@AllArgsConstructor
@RequestMapping("/rest/measurement")
public class MeasurementRestController {

    private final MeasurementService measurementService;

    @PostMapping("/saveUpdateMeasurementType")
    public ResponseEntity<?> saveUpdateMeasurementType(@RequestBody Map<String, Object> param) {
        try {
            measurementService.createMeasurementType(param);
            return ResponseEntity.ok("Measurement Type Saved Successfully");

        } catch (Exception e) {
            System.err.println("Error While Saving Measurement Type : " + e.getMessage());
            return new ResponseEntity<>("Failed To Save Measurement Type : " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/getMeasurementTypeData")
    public ResponseEntity<?> getMeasurementTypeData(@RequestParam Map<String, Object> param) {
        try {
            return new ResponseEntity<>(measurementService.getAllMeasurementType(param), HttpStatus.OK);
        } catch (Exception e) {
            System.err.println("Error While Fetching Measurement Types : " + e.getMessage());
            return new ResponseEntity<>("Failed To Fetch Measurement Types : " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/getMeasurementTypeDataById")
    public ResponseEntity<?> getMeasurementTypeDataById(@RequestParam Map<String, Object> param) {
        try {
            return new ResponseEntity<>(measurementService.getMeasurementTypeDataById(param), HttpStatus.OK);
        } catch (Exception e) {
            System.err.println("Error While Fetching Measurement Type : " + e.getMessage());
            return new ResponseEntity<>("Failed To Fetch Measurement Type : " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/deleteMeasurementTypeById")
    public ResponseEntity<?> deleteMeasurementTypeById(@RequestBody Map<String, Object> param) {
        try {
            measurementService.deleteMeasurementTypeById(param);
            return ResponseEntity.ok("Measurement Type Deleted Successfully");
        } catch (Exception e) {
            System.err.println("Error While Deleting Measurement Type : " + e.getMessage());
            return new ResponseEntity<>("Failed To Delete Measurement Type : " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
