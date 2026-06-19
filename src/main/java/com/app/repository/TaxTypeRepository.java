package com.app.repository;

import com.app.entity.TaxTypeEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TaxTypeRepository extends JpaRepository<TaxTypeEntity,Long> {
}
