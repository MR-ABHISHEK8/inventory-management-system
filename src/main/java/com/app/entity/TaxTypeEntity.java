package com.app.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Data
@Table(name = "tax_type")
public class TaxTypeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "tax_name")
    private String taxName;
    @Column(name = "tax_code")
    private String taxCode;
    @Column(name = "tax_percentage")
    private Double taxPercentage;
    private String description;
}
