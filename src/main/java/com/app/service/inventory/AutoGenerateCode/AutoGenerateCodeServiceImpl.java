package com.app.service.inventory.AutoGenerateCode;

import com.app.entity.AutoGenerateCodeEntity;
import com.app.repository.AutoGenerateCodeRepository;
import com.app.utility.Utility;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@AllArgsConstructor
public class AutoGenerateCodeServiceImpl implements AutoGenerateCodeService{

    private final AutoGenerateCodeRepository autoGenerateCodeRepository;
    private final Utility utility;

    @Override
    public AutoGenerateCodeEntity saveUpdateAutoGenerateCode(Map<String, Object> param) {

        String prefix = String.valueOf(param.get("prefix"));
        Long zeroPadding =utility.longNullValue(param.get("zeroPadding"));
        String separator =String.valueOf(param.get("separator"));
        String postFix = String.valueOf(param.get("postFix"));
        Long startNo = utility.longZeroValue(param.get("startNo"));
        Long lastNo = utility.longZeroValue(param.get("lastNo"));
        String views = String.valueOf(param.get("views"));

        Long id = utility.longNullValue(param.get("id"));

        AutoGenerateCodeEntity codeEntity = new AutoGenerateCodeEntity();

        if (id != null){
              codeEntity = autoGenerateCodeRepository.findById(id).get();
        }
        codeEntity.setPrefix(prefix);
        codeEntity.setZeroPadding(zeroPadding);
        codeEntity.setSeparator(separator);
        codeEntity.setPostFix(postFix);
        codeEntity.setStartNo(startNo);
        codeEntity.setLastNo(lastNo);
        codeEntity.setUpdatedAt(utility.getCurrentDateInUsFormat());
        codeEntity.setViews(views);

        return autoGenerateCodeRepository.save(codeEntity);
    }

    @Override
    public List<AutoGenerateCodeEntity> getAllAutoGenerateCode(Map<String, Object> param) {
        return autoGenerateCodeRepository.findAll();
    }

    @Override
    public AutoGenerateCodeEntity getAutoGenerateCodeById(Map<String, Object> param) {
        Long id = utility.longNullValue(param.get("id"));
        if (id == null) throw new RuntimeException("Id not found");
        return autoGenerateCodeRepository.findById(id).orElseThrow(()-> new RuntimeException("AAutoGenerateCode data not found !"));
    }

    @Override
    public void autoGenerateCodeDeleteById(Map<String, Object> param) {
            Long id =utility.longNullValue(param.get("id"));
            if (id == null) throw new RuntimeException("Id not found ");
            autoGenerateCodeRepository.deleteById(id);
    }
}
