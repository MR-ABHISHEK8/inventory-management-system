<%--
  Created by IntelliJ IDEA.
  User: abhis
  Date: 28-05-2026
  Time: 22:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Item Master</title>

    <jsp:include page="../common/common_link.jsp"></jsp:include>
</head>

<body>

<jsp:include page="../common/side-bar.jsp"></jsp:include>

<div class="main" id="main">
    <div class="page-card">

        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="fw-bold">Item Master</h2>

            <button class="btn btn-primary px-4" onclick="addItem()">
                <i class="fa-solid fa-plus me-2"></i>Add Item</button>
        </div>
        <div class="table-responsive">
            <table class="table table-hover table-bordered text-center align-middle">
                <thead class="table-dark">
                <tr>
                    <th>Sr No.</th>
                    <th>Item Name</th>
                    <th>Item Code</th>
                    <th>Item Type</th>
                    <th>Measurement</th>
                    <th>Tax</th>
                    <th>Purchase Price</th>
                    <th>Sale Price</th>
                    <th width="180">Action</th>
                </tr>
                </thead>
                <tbody id="table-body">

                </tbody>
            </table>
        </div>

    </div>
</div>


<!-- Modal -->
<div class="modal fade" id="itemModal" tabindex="-1">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="modal-title">Add Item</h5>
                <button type="button" class="btn-close btn-close-white" onclick="hideModal()"></button>
            </div>

            <div class="modal-body">
                <form id="main-form">
                    <input type="hidden" id="item_id">
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label class="form-label">Item Name</label>
                            <input type="text" id="itemName" name="itemName" class="form-control" placeholder="Enter item name">
                        </div>

                        <div class="col-md-4 mb-3">
                            <label class="form-label">Item Code</label>
                            <input type="text" id="itemCode" name="itemCode" class="form-control" placeholder="Enter item code">
                        </div>

                        <div class="col-md-4 mb-3">
                            <label class="form-label">Item Type</label>
                            <select id="itemTypeId" class="form-select">
                                <option value="">Select Item Type</option>
                            </select>
                        </div>

                        <div class="col-md-4 mb-3">
                            <label class="form-label">Measurement Type</label>
                            <select id="measurementTypeId" class="form-select">
                                <option value="">Select Measurement</option>
                            </select>
                        </div>


                        <div class="col-md-4 mb-3">
                            <label class="form-label">Tax Type</label>
                            <select id="taxTypeId" class="form-select">
                                <option value="">Select Tax</option>
                            </select>
                        </div>

                        <div class="col-md-4 mb-3">
                            <label class="form-label">Purchase Price</label>
                            <input type="number" id="purchasePrice" name="purchasePrice" class="form-control">
                        </div>

                        <div class="col-md-4 mb-3">
                            <label class="form-label">Sale Price</label>
                            <input type="number" id="salePrice" name="salePrice" class="form-control">
                        </div>

                        <div class="col-md-4 mb-3">
                            <label class="form-label">Status</label>
                            <select id="status" name="status" class="form-select">
                                <option value="ACTIVE">ACTIVE</option>
                                <option value="INACTIVE">INACTIVE</option>
                            </select>
                        </div>

                        <div class="col-md-12 mb-3">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" name="description" id="description" rows="3"></textarea>
                        </div>
                    </div>
                </form>

            </div>

            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="hideModal()">Close</button>
                <button class="btn btn-success" onclick="saveItem()" id="btn-save">Save Item</button>
            </div>
        </div>
    </div>
</div>

<script src="../../js/side-nav-bar-js.js"></script>

</body>
</html>

<script>
    function showModal(){
        $("#itemModal").modal('show');
    }
    function hideModal() {
        $("#itemModal").modal('hide');
    }
    // this is modal dropdown method.....

    function getBasicDetails(){
        $.ajax({
            url:"/rest/item/getItemBasicDetails",
            type:"GET",
            success:function (res){
                let itemTypeList=res.itemTypeList;
                let measurementTypeList=res.measurementTypeList;
                let taxTypeList=res.taxTypeList;

                let itemTypeOption="<option value=''>Select Item Type</>"
                for(let i=0;i<itemTypeList.length;i++){
                    let data=itemTypeList[i];
                    itemTypeOption +="<option value='"+data.id+"'>"+data.name+"</>"
                }
                $("#itemTypeId").html(itemTypeOption)

                let measurementTypeOption="<option value=''>Select Item Type</>"
                for(let i=0;i<measurementTypeList.length;i++){
                    let data=measurementTypeList[i];
                    measurementTypeOption +="<option value='"+data.id+"'>"+data.name+"</>"
                }
                $("#measurementTypeId").html(measurementTypeOption)


                let taxTypeOption = "<option value=''>Select Tax Type</option>";
                for(let i=0;i<taxTypeList.length;i++){
                    let data=taxTypeList[i];
                    taxTypeOption +="<option value='"+data.id+"'>"+data.taxName+"</>"
                }
                $("#taxTypeId").html(taxTypeOption)


                console.log(res);
            }
        })

    }

    function saveItem() {
       let data ={
           "id" : $("#item_id").val(),
           "itemName" : $("#itemName").val(),
           "itemCode" : $("#itemCode").val(),
           "purchasePrice" : $("#purchasePrice").val(),
           "salePrice" : $("#salePrice").val(),
           "description" : $("#description").val(),
           "measurementTypeId" : $("#measurementTypeId").val(),
           "itemTypeId" : $("#itemTypeId").val(),
           "taxTypeId" : $("#taxTypeId").val()
       };
       console.log(data)
       $.ajax({
           url: "/rest/item/saveUpdateItemData",
           type: "POST",
           data :JSON.stringify(data),
           contentType :"application/json",
           success: function (res){
               console.log("success : " + JSON.stringify(res));
               getAllItemData();
               clearForm();
               hideModal();
           },error : function (res){
               console.log("Error : "+ JSON.stringify(res));
           }
       });

    }

    function getAllItemData() {

        $.ajax({
            url: "/rest/item/getAllItemData",
            type: "GET",
            success: function (res) {
                let table_data = "";
                for (let i = 0; i < res.length; i++) {
                    let data = res[i];
                    table_data += "<tr>" +
                        "<td>" + (i + 1) + "</td>" +
                        "<td>" + data.itemName + "</td>" +
                        "<td>" + data.itemCode + "</td>" +
                        "<td>" + data.itemTypeName + "</td>" +
                        "<td>" + data.measurementName + "</td>" +
                        "<td>" + data.taxTypeName + "</td>" +
                        "<td>" + data.purchasePrice + "</td>" +
                        "<td>" + data.salePrice + "</td>" +
                        "<td>" +
                        "<div class='d-flex justify-content-center'>" +

                        "<button type='button' " +
                        "class='btn btn-outline-primary btn-sm mx-1 rounded-pill shadow-sm' " +
                        "onclick='editItemData(" + data.id + ")'>" +
                        "<i class='bi bi-pencil-square'></i> Edit" +
                        "</button>" +

                        "<button type='button' " +
                        "class='btn btn-outline-danger btn-sm mx-1 rounded-pill shadow-sm' " +
                        "onclick='itemDataDeleteById(" + data.id + ")'>" +
                        "<i class='bi bi-trash'></i> Delete" +
                        "</button>" +

                        "</div>" +
                        "</td>" +
                        "</tr>";
                }

                $("#table-body").html(table_data);
            },
            error: function (xhr) {
                console.log(xhr);
                alert("Error loading item data");
            }
        });
    }

    function editItemData(id) {
          $.ajax({
              url : "/rest/item/getItemTypeDataById?id="+ id,
              type :"GET",
              success : function (res) {
                  if (res) {
                      console.log("item Name : " + JSON.stringify(res))
                      $("#item_id").val(res.id);
                      $("#itemName").val(res.itemName);
                      $("#itemCode").val(res.itemCode);
                      $("#itemTypeId").val(res.itemTypeId);
                      $("#measurementTypeId").val(res.measurementTypeId);
                      $("#taxTypeId").val(res.taxTypeId);
                      $("#purchasePrice").val(res.purchasePrice);
                      $("#salePrice").val(res.salePrice);
                      $("#description").val(res.description);

                  }
                  showModal();
              },error : function (res){
                  console.log("error block :" +  JSON.stringify(res));
              }
          })
    }

    function itemDataDeleteById(id) {
        let confirmDelete = confirm("Do you want to delete this item ?");
        if (!confirmDelete) {
            return;
        }
        let data ={
            "id" :id
        };
        $.ajax({
            url : "/rest/item/deleteItemTypeById",
            type :"POST",
            data :JSON.stringify(data),
            contentType: "application/json",
                success: function(res) {
                    alert(res);
                    getAllItemData();
                },
                error: function(res) {
                    console.log(res);
                    alert("Delete Failed");
                }
        });
    }

    function clearForm() {
        $("#item_id").val('');
        $("#itemName").val('');
        $("#itemCode").val('');
        $("#purchasePrice").val('');
        $("#salePrice").val('');
        $("#description").val('');
        $("#measurementTypeId").val('');
        $("#itemTypeId").val('');
        $("#taxTypeId").val('');
    }
    function addItem() {
        clearForm();
        showModal();
    }

    $(document).ready(function () {
        getBasicDetails();
        getAllItemData();
    });

</script>