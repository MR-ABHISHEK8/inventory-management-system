<%--
  Created by IntelliJ IDEA.
  User: abhis
  Date: 26-05-2026
  Time: 23:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Item Type</title>
  <jsp:include page="../common/common_link.jsp"></jsp:include>
</head>

<body>
<jsp:include page="../common/side-bar.jsp"></jsp:include>

<div class="main" id="main">
  <div class="page-card">

    <div class="d-flex justify-content-between align-items-center mb-2">
      <div>
        <h2 class="fw-bold mb-1">Item Type</h2>
      </div>
      <button class="btn btn-primary px-4" data-bs-toggle="modal" data-bs-target="#itemTypeModal">
        <i class="fa-solid fa-plus me-2"></i>Add Item
      </button>
    </div>

    <div class="table-responsive">
      <table class="table table-hover table-bordered align-middle text-center">
        <thead class="table-dark">
        <tr>
          <th scope="col">Sr No.</th>
          <th scope="col">Name</th>
          <th scope="col">Prefix</th>
<%--          <th scope="col">Suffix</th>--%>
          <th scope="col">Zero Padding</th>
          <th scope="col">Separator</th>
          <th scope="col">Start No.</th>
          <th scope="col">Last No.</th>
          <th width="180">Action</th>
        </tr>
        </thead>
        <tbody id="table-body">

        </tbody>
      </table>
    </div>

  </div>
</div>

<div class="modal fade" id="itemTypeModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title" id="modal-title">Add Item Type</h5>
        <button type="button" class="btn-close btn-close-white" onclick="hideModal()"></button>
      </div>

      <div class="modal-body">
        <form id="main-form">
          <input type="hidden" id="item_id" value="">

          <div class="row">
            <div class="col-md-6 mb-3">
              <label class="form-label">Name</label>
              <input type="text" id="name" class="form-control" placeholder="Enter name">
            </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">Prefix</label>
              <input type="text" id="prefix" class="form-control" placeholder="Enter prefix">
            </div>
<%--            <div class="col-md-6 mb-3">--%>
<%--              <label class="form-label">Suffix</label>--%>
<%--              <input type="text" id="suffix" class="form-control" placeholder="Enter suffix">--%>
<%--            </div>--%>
            <div class="col-md-6 mb-3">
              <label class="form-label">Zero Padding</label>
              <input type="number" id="zeroPadding" class="form-control" placeholder="Enter zero padding">
            </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">Separator</label>
              <input type="text" id="separator" class="form-control" placeholder="Enter separator">
            </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">Start No.</label>
              <input type="number" id="startNo" class="form-control" placeholder="Enter start number">
            </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">Last No.</label>
              <input type="number" id="lastNo" class="form-control" placeholder="Enter last number">
            </div>
          </div>
        </form>
      </div>

      <div class="modal-footer">
        <button class="btn btn-secondary" data-bs-dismiss="modal" onclick="hideModal()">Close</button>
        <button class="btn btn-success" onclick="saveItemType()" id="btn-save">Save Item Type</button>
      </div>
    </div>
  </div>
</div>

<script src="../../js/side-nav-bar-js.js"></script>
</body>
</html>
<script>

         $(document).ready(function (){
                getAllItemTypeData();
         })
        function saveItemType(){
               let data={
                 "id":$("#item_id").val(),
                 "name":$("#name").val(),
                 "prefix":$("#prefix").val(),
                 "zeroPadding":$("#zeroPadding").val(),
                 "separator" :$("#separator").val(),
                 "startNo":$("#startNo").val(),
                 "lastNo" :$("#lastNo").val()
               };
               $.ajax({
                 url :"/itemType/saveUpdateItemType",
                 type:"POST",
                 data : JSON.stringify(data),
                 contentType:"application/json",
                 success: function (res) {
                   console.log("Success Block "+JSON.stringify(res));
                   getAllItemTypeData();
                 //  rest form code logic
                 //   $("#item_id").val(null);
                 //   $("#name").val('');
                 //   $("#prefix").val('');
                 //   $("#suffix").val('');
                 //   $("#zeroPadding").val('');
                 //   $("#separator").val('');
                 //   $("#startNo").val('');
                 //   $("#lastNo").val('');

                   hideModal();
                 },error(res) {
                   console.log("Error Block " + JSON.stringify(res))
                 }
               })
        }

        function getAllItemTypeData(){
              $.ajax({
                url: "/itemType/getAllItemTypeData",
                type: "GET",
                success : function (res) {
                    let table_data='';
                  if (res){
                      for(let  i = 0 ; i < res.length ;i++){
                        let data= res[i];

                            table_data += "<tr>" +
                                    "<td>" + (i +1) + "</td>"+
                                    "<td>" + data.name + "</td>"+
                                    "<td>" + data.prefix + "</td>"+
                                    "<td>" + data.zeroPadding + "</td>"+
                                    "<td>" + data.separator + "</td>"+
                                    "<td>" + data.startNo + "</td>"+
                                    "<td>" + data.lastNo + "</td>"+

                                    "<td>" +
                                    "<div class='d-flex justify-content-center'>" + "<button type='button' " + "class='btn btn-outline-primary btn-sm mx-1 rounded-pill shadow-sm' " +
                                    "onclick='editItemType(" + data.id + ")'>" +
                                    "<i class='bi bi-pencil-square'></i> Edit" +
                                    "</button>" +

                                    "<button type='button' " +
                                    "class='btn btn-outline-danger btn-sm mx-1 rounded-pill shadow-sm' " + "onclick='deleteItemType(" + data.id + ")'>" +
                                    "<i class='bi bi-trash'></i> Delete" +
                                    "</button>" +

                                    "</div>" +
                                    "</td>"+
                                    "</tr>"
                      }
                  }
                  $("#table-body").html(table_data);
                }
              });
        }

        function editItemType(id) {
             $.ajax({
               url:"/itemType/getItemTypeDataById?id="+id,
               type : "GET",
               success : function (res) {
                 if (res) {
                   $("#item_id").val(res.id);
                   $("#name").val(res.name);
                   $("#prefix").val(res.prefix);
                   $("#separator").val(res.separator);
                   $("#zeroPadding").val(res.zeroPadding);
                   $("#startNo").val(res.startNo);
                   $("#lastNo").val(res.lastNo);
                 }
                 showModal();
               },error(res) {
                 console.log("Error Block "+JSON.stringify(res));
               }
             });
        }

         function deleteItemType(id) {
           let confirmDelete = confirm("Do you want to delete this item type?");
           if (!confirmDelete) return;

           let data = {
             "id": id
           };
           $.ajax({
             url: "/itemType/deleteItemTypeById",
             type: "POST",
             data: JSON.stringify(data),
             contentType: "application/json",
             success: function(res) {
               alert(res);
               getAllItemTypeData();
             },
             error: function(res) {
               console.log(res);
               alert("Delete Failed");
             }
           });
         }
         // clear form data
         function clearForm() {
           $("#item_id").val('');
           $("#name").val('');
           $("#prefix").val('');
           $("#zeroPadding").val('');
           $("#separator").val('');
           $("#startNo").val('');
           $("#lastNo").val('');
         }
         function addItemType() {
           clearForm();
           showModal();
         }
         function showModal(){
           $("#itemTypeModal").modal('show')
         }
         function hideModal(){
           clearForm();
           $("#itemTypeModal").modal('hide')

         }
</script>