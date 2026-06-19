package com.app.service.inventory.measurementType;

import com.app.entity.MeasurementEntity;
import com.app.repository.MeasurementRepository;
import com.app.utility.Utility;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@AllArgsConstructor
public class MeasurementServiceImpl implements MeasurementService {

    private final MeasurementRepository measurementRepository;
    private final Utility utility;

    @Override
    public MeasurementEntity createMeasurementType(Map<String, Object> param) {
        String name = String.valueOf(param.get("name"));
        String shortName=String.valueOf(param.get("shortName"));
        String description=String.valueOf(param.get("description"));
//        Long id=Long.parseLong(String.valueOf(param.get("id")));
        Long id=utility.longNullValue(param.get("id"));

        MeasurementEntity measurement = new MeasurementEntity();
        // update code
//        if (id!=null){
//            measurement=measurementRepository.findById(id).get();
//        }
        if(id != null){
            measurement = measurementRepository.findById(id).orElseThrow(() -> new RuntimeException("Measurement Type Not Found"));
        }

        measurement.setName(name);
        measurement.setShortName(shortName);
        measurement.setDescription(description);
        measurement.setCreatedOn(utility.getCurrentDateInUsFormat());
        return measurementRepository.save(measurement);
    }

    @Override
    public List<MeasurementEntity> getAllMeasurementType(Map<String,Object>param) {
        return measurementRepository.findAll();
    }

    public MeasurementEntity getMeasurementTypeDataById(Map<String,Object>param){
        Long id=Long.parseLong(String.valueOf(param.get("id")));
        if (id==null)throw new RuntimeException("Invalid Data");
        MeasurementEntity measurementEntity = measurementRepository.findById(id).get();
        return measurementEntity;

    }
    public void deleteMeasurementTypeById(Map<String,Object>param){
        Long id=Long.parseLong(String.valueOf(param.get("id")));
        if (id==null)throw new RuntimeException("Invalid Data");
        measurementRepository.deleteById(id);
    }
}
