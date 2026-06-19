<%--
  Created by IntelliJ IDEA.
  User: abhis
  Date: 26-05-2026
  Time: 23:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Vendor</title>

  <jsp:include page="../common/common_link.jsp"></jsp:include>
</head>

<body>

<jsp:include page="../common/side-bar.jsp"></jsp:include>

<div class="main" id="main">
  <div class="page-card">
    <div class="d-flex justify-content-between align-items-center mb-2">
      <div>
        <h2 class="fw-bold mb-1">Vendor</h2>
      </div>
      <button class="btn btn-primary px-4" onclick="showModal()">
        <i class="fa-solid fa-plus me-2"></i>Add Vendor</button>
    </div>

    <div class="table-responsive">
      <table class="table table-hover table-bordered align-middle text-center">
        <thead class="table-dark">
        <tr>
          <th scope="col">Sr No.</th>
          <th scope="col">Vendor Name</th>
          <th scope="col">Email</th>
          <th scope="col">Phone No.</th>
          <th scope="col">GST No.</th>
          <th scope="col">City</th>
          <th scope="col">Address</th>
          <th width="180">Action</th>
        </tr>
        </thead>

        <tbody id="table-body">
        </tbody>

      </table>
    </div>
  </div>
</div>

<div class="modal fade" id="vendorModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title" id="modal-title">Add Vendor</h5>
        <button type="button" class="btn-close btn-close-white" onclick="hideModal()"></button>
      </div>
      <div class="modal-body">
        <form id="main-form">
          <input type="hidden" id="vendor_id" value="">

          <div class="row">
            <div class="col-md-6 mb-3">
              <label class="form-label">Vendor Name</label>
              <input type="text" id="vendorName" class="form-control" placeholder="Enter vendor name">
            </div>

            <div class="col-md-6 mb-3">
              <label class="form-label">Email</label>
              <input type="email" id="email" class="form-control" placeholder="Enter email">
            </div>

            <div class="col-md-6 mb-3">
              <label class="form-label">Phone No.</label>
              <input type="text" id="phoneNo" class="form-control" placeholder="Enter mobile number">
            </div>

            <div class="col-md-6 mb-3">
              <label class="form-label">GST No.</label>
              <input type="text" id="gstNo" class="form-control" placeholder="Enter GST number">
            </div>

            <div class="col-md-6 mb-3">
              <label class="form-label">City</label>
              <input type="text" id="city" class="form-control" placeholder="Enter city">
            </div>

            <div class="col-md-6 mb-3">
              <label class="form-label">Address</label>
              <input type="text" id="address" class="form-control" placeholder="Enter address">
            </div>

          </div>
        </form>
      </div>

      <div class="modal-footer">
        <button class="btn btn-secondary" onclick="hideModal()">Close</button>
        <button type="button" onclick="saveVendor();" class="btn btn-success" id="btn-save">Save Vendor</button>
      </div>
    </div>
  </div>

</div>

<script src="../../js/side-nav-bar-js.js"></script>

</body>
</html>

<script>

  $(document).ready(function() {
          getAllVendorData();
  });
  function saveVendor() {
        //json
        let data = {
          "id" : $("#vendor_id").val(),
          "vendorName" : $("#vendorName").val(),
          "email" : $("#email").val(),
          "phoneNo" : $("#phoneNo").val(),
          "gstNo" : $("#gstNo").val(),
          "city" : $("#city").val(),
          "address" : $("#address").val()
        };

        $.ajax({
          url : "/vendor/saveUpdateVendor",
          type : "POST",
          data : JSON.stringify(data),
          contentType : "application/json",
          success : function(res) {
            console.log("success block :", res);
            getAllVendorData();
            // console.log("================Edit ID:", res.id);

            hideModal();
          },
          error : function(res) {
            console.log("Status :", res.status);
            console.log("Response :", res.responseText);
          }
        });
      }

      function getAllVendorData() {
               $.ajax({
                 url: "/vendor/getAllVendorData",
                 type: "GET",
                 success :function (res) {
                       let table_data ="";
                       if (res){
                           for (let i= 0; i<res.length ;i++ ){
                                 let data = res[i];

                                 table_data +=
                                         "<tr>" +
                                           "<td>"+ (i + 1) +"</td>"+
                                           "<td>"+ data.vendorName +"</td>"+
                                           "<td>"+ data.email +"</td>"+
                                           "<td>"+ data.phoneNo +"</td>"+
                                           "<td>"+ data.gstNo +"</td>"+
                                           "<td>"+ data.city +"</td>"+
                                           "<td>"+ data.address +"</td>"+
                                         "<td>"+
                                         "<div class='d-flex justify-content-center'>"+
                                         "<button type='button' " +
                                         "class='btn btn-outline-primary btn-sm mx-1 rounded-pill shadow-sm' " +
                                         "onclick='editVendor("+data.id+")'>"+
                                         "<i class='bi bi-pencil-square'></i> Edit" +
                                         "</button>" +

                                         "<button type='button' " +
                                         "class='btn btn-outline-danger btn-sm mx-1 rounded-pill shadow-sm' " +
                                         "onclick='deleteVendor("+data.id+")'>"+
                                         "<i class='bi bi-trash'></i> Delete" +
                                         "</button>" +
                                         "</div>" +
                                         "</td>" +
                                         "</tr>";
                         }
                       }
                       $("#table-body").html(table_data);
                 },error : function (res) {
                   console.log("Error Block " + JSON.stringify(res));
                 }
               });
      }
        function editVendor(id) {
          $.ajax({
            url : "/vendor/getVendorDataById?id=" + id,
            type :"GET",
            success : function (res){
              if (res){
                $("#vendor_id").val(res.id);
                $("#vendorName").val(res.vendorName);
                $("#email").val(res.email);
                $("#phoneNo").val(res.phoneNo);
                $("#gstNo").val(res.gstNo);
                $("#city").val(res.city);
                $("#address").val(res.address);
              }
              showModal();
            },error :function (res){
              console.log("Error Block "+JSON.stringify(res));
            }
          });
        }

        function deleteVendor(id) {
          let b = confirm("You want to delete vendor type ?");
          if (!b)return;
          let data = {
            "id" :id
          };
              $.ajax({
                url :"/vendor/deleteVendorById",
                type : "POST",
                data: JSON.stringify(data),
                contentType: "application/json",
                success :function (res){
                  alert(res);
                  getAllVendorData();
                }, error:function (res){
                  console.log("Error Block "+JSON.stringify(res));
                }
              });
        }

        function clearForm(){
          $("#vendor_id").val('');
          $("#vendorName").val('');
          $("#email").val('');
          $("#phoneNo").val('');
          $("#gstNo").val('');
          $("#city").val('');
          $("#address").val('');
        }

      function showModal() {
            $("#vendorModal").modal("show");
      }
      function hideModal() {
           $("#vendorModal").modal("hide");
        clearForm();
      }
</script>