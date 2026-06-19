<%--
  Created by IntelliJ IDEA.
  User: abhis
  Date: 18-06-2026
  Time: 22:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add / Edit Purchase Order</title>
    <jsp:include page="../common/common_link.jsp"/>
</head>
<body>

<jsp:include page="../common/side-bar.jsp"/>

<div class="main" id="main">

    <div class="page-card">

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold">Add / Edit Purchase Order</h2>

            <button class="btn btn-success" onclick="savePurchaseOrder()">
                <i class="fa-solid fa-floppy-disk me-2"></i>
                Save Purchase Order
            </button>
        </div>

        <!-- Purchase Details -->

        <div class="card shadow-sm mb-4">
            <div class="card-header bg-primary text-white">Purchase Details</div>
            <div class="card-body">
                <input type="hidden" id="purchaseOrderId">
                <div class="row">
                    <div class="col-md-3 mb-3">
                        <label class="form-label">PO Number</label>
                        <input type="text" id="poNumber" class="form-control" readonly>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Purchase Date</label>
                        <input type="date" id="purchaseDate" class="form-control">
                    </div>
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Vendor</label>
                        <select id="vendorId" class="form-select">
                            <option value="">Select Vendor</option>
                        </select>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label class="form-label">Expected Date</label>
                        <input type="date" id="expectedDate" class="form-control">
                    </div>
                    <div class="col-md-12">
                        <label class="form-label">Remarks</label>
                        <textarea id="remarks" rows="2" class="form-control"></textarea>
                    </div>
                </div>
            </div>
        </div>

        <!-- Purchase Items -->
        <div class="card shadow-sm">
            <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center">
                <span>Purchase Items</span>
                <button type="button" class="btn btn-warning btn-sm" onclick="addItemRow()">
                    <i class="fa-solid fa-plus"></i>Add Item
                </button>

            </div>

            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover text-center">
                        <thead class="table-secondary">
                        <tr>
                            <th width="5%">Sr No</th>
                            <th width="15%">Item Type</th>
                            <th width="20%">Item</th>
                            <th width="10%">Qty</th>
                            <th width="12%">Purchase Price</th>
                            <th width="12%">Sale Price</th>
                            <th width="8%">Tax %</th>
                            <th width="10%">Amount</th>
                            <th width="8%">Action</th>
                        </tr>
                        </thead>

                        <tbody id="purchaseItemTbody">

                        </tbody>

                    </table>

                </div>

            </div>

        </div>

        <!-- Total -->

        <div class="row mt-4">
            <div class="col-md-4 offset-md-8">
                <table class="table table-bordered">
                    <tr>
                        <th>Base Amount</th>
                        <td id="subTotal">0.00</td>
                    </tr>

                    <tr>
                        <th>Tax Amount</th>
                        <td id="taxAmount">0.00</td>
                    </tr>
                    <tr class="table-success">
                        <th>Final Amount</th>
                        <td id="grandTotal">0.00</td>
                    </tr>
                </table>
            </div>
        </div>

    </div>

</div>

<script src="../../js/side-nav-bar-js.js"></script>

</body>
</html>

<script>

    let itemTypeOption = "";
    let allItemList =[];
    let allTaxTypeList =[];

    function getVendorAndItemTypeBasicDetails() {
        $.ajax({
            url: "rest/purchaseOrder/getVendorAndItemTypeBasicDetails",
            type: "GET",
            success: function (res) {
                let itemTypeList = res.itemTypeList;
                let vendorList = res.vendorList;
                allItemList =  res.itemList;
                allTaxTypeList =res.taxTypeList;
                console.log(JSON.stringify(allTaxTypeList));
                // Item Type Dropdown
                itemTypeOption = "<option value=''>Select Item Type</option>";
                for (let i = 0; i < itemTypeList.length; i++) {
                    let data = itemTypeList[i];
                    itemTypeOption += "<option value='" + data.id + "'>" + data.name + "</option>";
                }
                // Vendor Dropdown
                let vendorListOption = "<option value=''>Select Vendor</option>";
                for (let i = 0; i < vendorList.length; i++) {
                    let data = vendorList[i];
                    vendorListOption += "<option value='" + data.id + "'>" + data.vendorName + "</option>";
                }
                $("#vendorId").html(vendorListOption);
            },
            error: function (xhr) {
                console.log(xhr.responseText);
            }
        });
    }

    // *********** filter item type to  item
    function getItemByItemType(res) {
           let itemId = res.value;
           let itemOption = "<option value=''>Select Item</option>";
           for (let i =0 ;i<allItemList.length ;i++){
                let data =allItemList[i];
                if (data.itemTypeId == itemId){
                    itemOption += "<option value='" + data.id + "'>" + data.itemName + "</option>";
                }
           }
           $(res).closest("tr").find(".itemId").html(itemOption);
    }
    // Set item-wise purchase price and sale price and tax
     function setItemDetails(res){
        let itemId= res.value;
        for (let i =0 ;i<allItemList.length ;i++){
             let data =allItemList[i];
            console.log(JSON.stringify(data));
            if (data.id == itemId) {
                $(res).closest("tr").find(".pPrice").val(data.purchasePrice || 0);
                $(res).closest("tr").find(".sPrice").val(data.salePrice || 0);

                // Tax Percentage
                for (let j =0;j<allTaxTypeList.length;j++){
                    let taxData = allTaxTypeList[j];
                    if (taxData.id == data.taxTypeId){
                        $(res).closest("tr").find(".tax").val(taxData.taxPercentage || 0);
                        break;
                    }
                }
                calculateRow($(res).closest("tr").find(".qty")[0]);
                break;
            }

        }
    }
    // Calculate amount based on quantity
    function calculateRow(res){
         let row = $(res).closest("tr");

        let quantity = parseFloat(row.find(".qty").val()) || 0;
        let price = parseFloat(row.find(".pPrice").val()) || 0;
        let tax = parseFloat(row.find(".tax").val()) || 0;

        // handle the quantity and amount
        let baseAmount = price * quantity ;
        // handle Tax calculation
        let taxAmount = ( baseAmount * tax ) / 100;

        let totalAmount = baseAmount + taxAmount;

        row.find(".amount").text(totalAmount.toFixed(2));
        calculateGrandTotal();

    }

    function calculateGrandTotal() {

        let subTotal = 0;
        let taxTotal = 0;

        $("#purchaseItemTbody tr").each(function () {

            let qty = +$(this).find(".qty").val() || 0;
            let price = +$(this).find(".pPrice").val() || 0;
            let tax = +$(this).find(".tax").val() || 0;

            let base = qty * price;
            let taxAmt = (base * tax) / 100;

            subTotal += base;
            taxTotal += taxAmt;
        });

        let grandTotal = subTotal + taxTotal;

        $("#subTotal").text(subTotal.toFixed(2));
        $("#taxAmount").text(taxTotal.toFixed(2));
        $("#grandTotal").text(grandTotal.toFixed(2));
    }

    function addItemRow() {

        let rowCount = $("#purchaseItemTbody tr").length + 1;

        let row =
            "<tr>" +
            "<td>" + rowCount + "</td>" +

            "<td>" +
            "<select class='form-select itemTypeId' onchange='getItemByItemType(this)'>" +
            itemTypeOption +
            "</select>" +
            "</td>" +

            "<td>" +
            "<select class='form-select itemId' onchange='setItemDetails(this)'>" +
            "<option value=''>Select Item</option>" +
            "</select>" +
            "</td>" +

            "<td>" +
            "<input type='number' class='form-control qty' value='1' min='1' onchange='calculateRow(this)'>" +
            "</td>" +

            "<td>" +
            "<input type='number' class='form-control pPrice' value='0' onchange='calculateRow(this)'>" +
            "</td>" +

            "<td>" +
            "<input type='number' readonly class='form-control sPrice' value='0' onchange='calculateRow(this)' >" +
            "</td>" +

            "<td>" +
            "<input type='number' class='form-control tax' value='0' onchange='calculateRow(this)'>" +
            "</td>" +

            "<td class='amount'>0.00</td>" +

            "<td>" +
            "<button type='button' class='btn btn-danger btn-sm' onclick='removeRow(this)'>" +
            "Delete" +
            "</button>" +
            "</td>" +

            "</tr>";

        $("#purchaseItemTbody").append(row);
    }

    $(document).ready(function () {
        getVendorAndItemTypeBasicDetails();
    });

</script>