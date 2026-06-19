package com.app.entity;

import com.app.enums.Status;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "item")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class ItemEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "item_name")
    private String itemName;
    @Column(name = "item_code")
    private String itemCode;
    private String description;
    @Column(name = "purchase_price")
    private Double purchasePrice;
    private Double salePrice;
    private Status status;
    @Column(name = "item_type_id")
    private Long itemTypeId;
    @Column(name = "measurement_type_id")
    private Long measurementTypeId;
    @Column(name = "tax_type_id")
    private Long taxTypeId;

    @Transient
    private String measurementName;
    @Transient
    private String itemTypeName;
    @Transient
    private String taxTypeName;

}
