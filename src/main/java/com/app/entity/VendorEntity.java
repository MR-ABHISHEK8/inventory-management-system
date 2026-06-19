package com.app.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "vendor")
@Data
public class VendorEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "vendor_name")
    private String vendorName;
    private String email;
    @Column(name = "phone_No")
    private String phoneNo;
    @Column(name = "gst_no")
    private String gstNo;
    private String city;
    private String address;
}
