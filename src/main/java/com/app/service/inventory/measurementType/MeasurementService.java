package com.app.service.inventory.measurementType;

import com.app.entity.MeasurementEntity;

import java.util.List;
import java.util.Map;

public interface MeasurementService {

    public MeasurementEntity createMeasurementType(Map<String, Object> param);
    public List<MeasurementEntity> getAllMeasurementType(Map<String,Object>param);
    public MeasurementEntity getMeasurementTypeDataById(Map<String,Object>param);
    void deleteMeasurementTypeById(Map<String,Object>param);
}
