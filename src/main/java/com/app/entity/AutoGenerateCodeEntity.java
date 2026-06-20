package com.app.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "auto_code_config")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class AutoGenerateCodeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String prefix;
    @Column(name = "zero_padding")
    private Long zeroPadding;
    @Column(name = "data_separator")
    private String separator;
    @Column(name = "post_fix")
    private String postFix;
    @Column(name = "start_no")
    private Long startNo;
    @Column(name = "last_no")
    private Long lastNo;
    @Column(name = "created_at")
    private String createdAt = "Abhishek";
    @Column(name = "updated_at")
    private String updatedAt;
    private String views;
}
