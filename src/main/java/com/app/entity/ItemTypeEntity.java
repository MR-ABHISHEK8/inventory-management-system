package com.app.entity;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "item_Type")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class ItemTypeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String prefix;
//    private String suffix;
    @Column(name = "zero_padding")
    private Long zeroPadding;
    @Column(name = "data_separator")
    private String separator;
    @Column(name = "start_no")
    private Long startNo;
    @Column(name = "last_no")
    private Long lastNo;
}
