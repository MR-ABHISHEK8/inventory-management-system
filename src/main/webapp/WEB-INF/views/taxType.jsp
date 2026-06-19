<%--
  Created by IntelliJ IDEA.
  User: abhis
  Date: 27-05-2026
  Time: 00:01
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Tax Type</title>
  <jsp:include page="../common/common_link.jsp"/>
</head>

<body>

<jsp:include page="../common/side-bar.jsp"/>

<div class="main" id="main">
  <div class="page-card">
    <div class="d-flex justify-content-between align-items-center mb-3">
      <div>
        <h2 class="fw-bold mb-1">Tax Type</h2>
      </div>
      <button class="btn btn-primary px-4" onclick="taxTypeRestButton()">
        <i class="fa-solid fa-plus me-2"></i>Add Tax Type
      </button>
    </div>

    <div class="table-responsive">
      <table class="table table-hover table-bordered align-middle text-center">
        <thead class="table-dark">
        <tr>
          <th scope="col">Sr No.</th>
          <th scope="col">Tax Name</th>
          <th scope="col">Tax Code</th>
          <th scope="col">Tax Percentage (%)</th>
          <th scope="col">Description</th>
          <th width="180">Action</th>
        </tr>
        </thead>
        <tbody id="table-body">
        </tbody>
      </table>
    </div>
  </div>
</div>

<div class="modal fade" id="taxTypeModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title" id="modalTitle">Add Tax Type</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">
        <form id="main-form">
          <input type="hidden" id="taxType_id" value="">
          <div class="row"> <div class="col-md-6 mb-3">
            <label class="form-label">Tax Name</label>
            <input type="text" class="form-control" id="taxName" name="taxName" placeholder="Enter tax name">
          </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">Tax Code</label>
              <input type="text" class="form-control" id="taxCode" name="taxCode" placeholder="Enter tax code">
            </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">Tax Percentage (%)</label>
              <input type="number" step="0.01" class="form-control" id="taxPercentage" name="taxPercentage" placeholder="Enter tax percentage">
            </div>
            <div class="col-md-12 mb-3">
              <label class="form-label">Description</label>
              <textarea class="form-control" rows="3" id="description" name="description" placeholder="Enter description"></textarea>
            </div>
          </div>
        </form>
      </div>

      <div class="modal-footer">
        <button class="btn btn-secondary" onclick="hideModal()">Close</button>
        <button class="btn btn-success" id="btn-save" onclick="saveTaxType();">Save Tax Type</button>
      </div>
    </div>
  </div>
</div>

<script src="../../js/side-nav-bar-js.js"></script>

<script>

  $(document).ready(function () {
     getAllTaxData();
  });
   function saveTaxType() {
       let  data = {
         "id" : $("#taxType_id").val(),
         "taxName" : $("#taxName").val(),
         "taxCode" : $("#taxCode").val(),
         "taxPercentage" : $("#taxPercentage").val(),
         "description" : $("#description").val()
       };
       console.log(data);
        $.ajax({
          url : "/taxType/saveUpdateTaxTypeData",
          type : "POST",
          data :JSON.stringify(data),
          contentType : "application/json",
          success : function (res) {
            console.log("success block :", res);
            getAllTaxData();
            clearForm();
            hideModal();
          },error : function (res) {
            console.log("Status :", res.status);
            console.log("Response :", res.responseText);
          }
        });
   }

   function getAllTaxData(){
         $.ajax({
           url: "/taxType/getAllTaxTypeData",
           type: "GET",
              success : function (res){
                  let table_data='';
                   if (res){
                     for (let i = 0 ;i<res.length ;i++ ){
                          let data =res[i];
                       table_data +=
                               "<tr>" +
                               "<td>" + (i + 1) + "</td>" +
                               "<td>" + data.taxName + "</td>" +
                               "<td>" + data.taxCode + "</td>" +
                               "<td>" + data.taxPercentage + "</td>" +
                               "<td>" + data.description + "</td>" +
                               "<td>" +
                               "<div class='d-flex justify-content-center'>" +
                               "<button type='button' " +
                               "class='btn btn-outline-primary btn-sm mx-1 rounded-pill shadow-sm' " +
                               "onclick='editTaxTypeData(" + data.id + ")'>" +
                               "<i class='bi bi-pencil-square'></i> Edit" +
                               "</button>" +
                               "<button type='button' " +
                               "class='btn btn-outline-danger btn-sm mx-1 rounded-pill shadow-sm' " +
                               "onclick='deleteTaxTypeData(" + data.id + ")'>" +
                               "<i class='bi bi-trash'></i> Delete" +
                               "</button>" +
                               "</div>" +
                               "</td>" +
                               "</tr>";
                     }
                   }
                   $("#table-body").html(table_data);
              },error : function (res){
                   console.log("Error Block " + JSON.stringify(res));
           }
         });
   }

   function editTaxTypeData(id) {
         $.ajax({
           url : "/taxType/getTaxTypeDataById?id=" + id,
           type :"GET",
             success : function (res){
                 if (res){
                       $("#taxType_id").val(res.id);
                       $("#taxName").val(res.taxName);
                       $("#taxCode").val(res.taxCode);
                       $("#taxPercentage").val(res.taxPercentage);
                       $("#description").val(res.description);
                 }
                 showModal();
             },error :function (res){
             console.log("Error Block "+JSON.stringify(res));
           }
         });
   }

   function deleteTaxTypeData(id) {
     let b = confirm("You want to delete Tax type ?");
     if (!b)return;
     let data = {
       "id" :id
     };
      $.ajax({
        url : "/taxType/deleteTaxTypeById",
        type :"POST",
        data : JSON.stringify(data),
        contentType: "application/json",
        success : function (res){
          alert(res);
          getAllTaxData();
        },error :function (res){
          console.log("Error Block : " +JSON.stringify(res));
        }
      });
   }

   function clearForm() {
     $("#taxType_id").val('');
     $("#taxName").val('');
     $("#taxCode").val('');
     $("#taxPercentage").val('');
     $("#description").val('');
   }
   function taxTypeRestButton() {
         clearForm();
         showModal();
   }

   function showModal() {
       $("#taxTypeModal").modal('show');
   }
   function hideModal() {
     $("#taxTypeModal").modal('hide');
   }

</script>
</body>
</html>