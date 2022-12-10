<template>
    <div>
        <div v-if="!loading && user.new_bill">
            <!-- Pemding Bills -->
            <div
                class="modal fade"
                id="pending"
                tabindex="-1"
                role="dialog"
                aria-labelledby="pending"
                aria-hidden="true"
            >
                <div class="modal-dialog" role="document">
                    <div
                        class="modal-content"
                        style="width: 650px; overflow: auto"
                    >
                        <div class="modal-header">
                            <h5 class="modal-title">
                                {{ __("Pending Bills") }}
                            </h5>
                            <button
                                type="button"
                                class="close"
                                data-dismiss="modal"
                                aria-label="Close"
                            >
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <table
                                id="bills"
                                class="text-center sortTable"
                                style="
                                    cellpadding: 20px;
                                    cellspacing: 0px;
                                    width: 100%;
                                "
                            >
                                <thead>
                                    <tr>
                                        <th style="width: 5%">
                                            {{ __("Bill Number") }}
                                        </th>
                                        <th style="width: 10%">
                                            {{ __("Sum") }}
                                        </th>

                                        <th style="width: 10%">
                                            {{ __("Total") }}
                                        </th>

                                        <th style="width: 10%">
                                            {{ __("Customer Name") }}
                                        </th>
                                        <th style="width: 10%">
                                            {{ __("User Name") }}
                                        </th>
                                        <th style="width: 10%">
                                            {{ __("Notes") }}
                                        </th>
                                        <th style="width: 10%">
                                            {{ __("Settings") }}
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="bill in pending" :key="bill.id">
                                        <td
                                            :class="
                                                selected === bill.id
                                                    ? 'selected'
                                                    : ''
                                            "
                                        >
                                            {{ bill.id }}
                                        </td>
                                        <td
                                            :class="
                                                selected === bill.id
                                                    ? 'selected'
                                                    : ''
                                            "
                                        >
                                            {{ bill.bill_sum }}
                                        </td>

                                        <td
                                            :class="
                                                selected === bill.id
                                                    ? 'selected'
                                                    : ''
                                            "
                                        >
                                            {{ bill.bill_total }}
                                        </td>

                                        <td
                                            :class="
                                                selected === bill.id
                                                    ? 'selected'
                                                    : ''
                                            "
                                        >
                                            {{
                                                bill.customer
                                                    ? bill.customer.cust_name
                                                    : ""
                                            }}
                                        </td>
                                        <td
                                            :class="
                                                selected === bill.id
                                                    ? 'selected'
                                                    : ''
                                            "
                                        >
                                            {{
                                                bill.user ? bill.user.name : ""
                                            }}
                                        </td>

                                        <td
                                            :class="
                                                selected === bill.id
                                                    ? 'selected'
                                                    : ''
                                            "
                                        >
                                            {{ bill.bill_notes }}
                                        </td>
                                        <td
                                            :class="
                                                selected === bill.id
                                                    ? 'selected'
                                                    : ''
                                            "
                                        >
                                            <button
                                                data-dismiss="modal"
                                                class="btn btn-sm btn-success font-weight-bold text-light"
                                                @click="
                                                    onSelectPendingBill(bill)
                                                "
                                            >
                                                {{ __("Complete") }}
                                            </button>
                                            <button
                                                data-dismiss="modal"
                                                class="btn btn-sm btn-danger font-weight-bold text-light"
                                                @click="deletePind(bill.id)"
                                            >
                                                <i
                                                    data-dismiss="modal"
                                                    class="fa fa-trash"
                                                ></i>
                                            </button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button
                                type="button"
                                class="btn btn-secondary"
                                data-dismiss="modal"
                            >
                                {{ __("Close") }}
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- New Customer -->
            <div
                class="modal fade"
                id="newCustomer"
                role="dialog"
                aria-labelledby="newCustomerTitle"
            >
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button
                                type="button"
                                class="close"
                                data-dismiss="modal"
                                aria-label="Close"
                            >
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <form class="user w-100" @submit.prevent="create">
                            <div class="modal-body" style="width: 100%">
                                <div class="card-body">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                {{ __("Customer Name") }}</span
                                            >
                                        </div>
                                        <input
                                            class="form-control"
                                            v-model="customer.cust_name"
                                            type="text"
                                        />
                                    </div>

                                    <div class="input-group mb-3">
                                        <div class="input-group-append">
                                            <span class="input-group-text">
                                                {{ __("Customer Note") }}</span
                                            >
                                        </div>
                                        <input
                                            class="form-control"
                                            v-model="customer.notes"
                                            type="text"
                                        />
                                    </div>

                                    <div class="input-group mb-3">
                                        <div class="input-group-append">
                                            <span class="input-group-text">
                                                {{
                                                    __("Customer identity")
                                                }}</span
                                            >
                                        </div>
                                        <input
                                            class="form-control"
                                            v-model="customer.identity"
                                            type="text"
                                        />
                                    </div>
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">{{
                                                __("Address")
                                            }}</span>
                                        </div>
                                        <input
                                            class="form-control"
                                            v-model="customer.cust_address"
                                            type="text"
                                        />
                                    </div>
                                    <div class="input-group mb-3">
                                        <div class="input-group-append">
                                            <span class="input-group-text">{{
                                                __("mobile")
                                            }}</span>
                                        </div>
                                        <input
                                            class="form-control"
                                            v-model="customer.cust_mobile"
                                            type="text"
                                        />
                                    </div>
                                    <div class="input-group mb-3">
                                        <div class="input-group-append">
                                            <span class="input-group-text">
                                                {{
                                                    __("Customer Vat Number")
                                                }}</span
                                            >
                                        </div>
                                        <input
                                            class="form-control"
                                            v-model="customer.cust_vat_num"
                                            type="text"
                                        />
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">
                                    {{ __("Save") }}
                                </button>
                                <button
                                    id="closeDlg"
                                    type="button"
                                    class="btn btn-danger"
                                    data-dismiss="modal"
                                >
                                    {{ __("Close") }}
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!--        Search -->
            <div
                :class="
                    showSearchTypeModal
                        ? 'modal fade show d-block modaldrg'
                        : 'modal fade modaldrg'
                "
                aria-hidden="true"
                aria-labelledby="exampleModalLabel"
                role="dialog"
                tabindex="-1"
            >
                <div
                    class="modal-dialog modal-dialog-centered modal-dialog-scrollable"
                    role="document"
                >
                    <div class="modal-content m-auto" style="min-width: 850px">
                        <div class="modal-header">
                            <h5 class="modal-title" i>{{ __("Types") }}</h5>
                            <button
                                aria-label="Close"
                                class="close"
                                data-dismiss="modal"
                                type="button"
                            >
                                <span
                                    aria-hidden="true"
                                    @click="
                                        searchTypes = [];
                                        typeName = '';
                                        showSearchTypeModal = false;
                                    "
                                    >&times;</span
                                >
                            </button>
                        </div>
                        <div
                            class="modal-body min-h-50"
                            style="min-height: 500px; overflow: auto"
                        >
                            <input
                                v-model="typeName"
                                class="form-control"
                                :placeholder="__('Type Name')"
                                type="search"
                            />
                            <button
                                class="btn btn-sm btn-info"
                                @click="findTypeByLike()"
                            >
                                <i
                                    class="fa fa-search font-weight-bold text-light"
                                ></i>
                            </button>
                            <table
                                class="text-center"
                                style="
                                    position: absolute;
                                    z-index: 999;
                                    overflow: auto;
                                "
                            >
                                <thead>
                                    <tr>
                                        <th style="width: 10%">
                                            {{ __("Code") }}
                                        </th>
                                        <th style="width: 50%">
                                            {{ __("Type Name") }}
                                        </th>

                                        <th style="width: 10%">
                                            {{ __("Price") }}
                                        </th>
                                        <th style="width: 10%">
                                            {{ __("Select") }}
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr
                                        v-for="(
                                            searchType, index
                                        ) in searchTypes"
                                        :key="index"
                                    >
                                        <td>{{ searchType.type_id }}</td>
                                        <td>{{ searchType.type_name_ar }}</td>

                                        <td>
                                            {{ searchType.type_sill_price }}
                                        </td>
                                        <td>
                                            <i
                                                class="fa fa-plus btn-sm btn-success font-weight-bold text-light"
                                                @click="addToCart(searchType)"
                                            ></i>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button
                                class="btn btn-secondary"
                                data-dismiss="modal"
                                type="button"
                                @click="
                                    searchTypes = [];
                                    typeName = '';
                                    showSearchTypeModal = false;
                                "
                            >
                                {{ __("Close") }}
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <!--   END     Search -->
            <!--Start Calculation-->

            <div class="card-header" style="overflow-x: auto">
                <form class="w-100" direction="rtl">
                    <table
                        class="table-bordered text-lighten-1 text-center font-weight-bold"
                    >
                        <tbody>
                            <tr>
                                <td style="width: 10%">
                                    {{ __("Customer Code/Mobile") }}
                                </td>
                                <td style="width: 10%">
                                    <input
                                        v-model="search"
                                        class="form-control"
                                        type="text"
                                        @keyup="findCustomer"
                                    />
                                </td>
                                <td
                                    style="width: 10%"
                                    data-toggle="modal"
                                    data-target="#newCustomer"
                                >
                                    <i id="isNewCustomer" class="fa fa-plus">
                                    </i>
                                    {{ __("Customer Name") }}
                                </td>
                                <td style="width: 10%">
                                    <input
                                        :value="customer.cust_name"
                                        class="form-control"
                                        type="text"
                                        readonly
                                    />
                                </td>
                                <td style="width: 10%">
                                    <a
                                        :title="customer.cust_balance"
                                        class="btn btn-info btn-sm text-light"
                                        data-target="#exampleModal"
                                        data-toggle="modal"
                                        @click="allCustomers()"
                                        ><i
                                            class="fas fa-search font-weight-bold text-light"
                                        ></i
                                    ></a>
                                </td>

                                <td style="width: 10%">
                                    {{ __("Pay Methods") }}
                                </td>
                                <td style="width: 10%">
                                    <select
                                        id="payMethod"
                                        v-model="form.pay"
                                        class="form-control text-center w-100"
                                        @change="calcTotal()"
                                    >
                                        <option
                                            v-for="(pay, index) in payMethods"
                                            :key="index"
                                            :value="pay.id"
                                        >
                                            {{ pay.pay_method_name }}
                                        </option>
                                    </select>
                                </td>
                                <td style="width: 10%">{{ __("Paid") }}</td>

                                <td style="width: 10%">
                                    <input
                                        v-model="form.paid"
                                        class="num form-control form-control text-center"
                                        @keyup="calcRemain()"
                                    />
                                </td>
                                <td>{{ __("Remain") }}</td>

                                <td style="width: 10%">
                                    <input
                                        v-model="form.remain"
                                        class="num form-control form-control text-center"
                                        readonly
                                    />
                                </td>
                                <td style="width: 10%">
                                    <a
                                        title="CTRL+S"
                                        id="save"
                                        :disabled="cart.length <= 0 || disable"
                                        class="save btn btn-outline-success font-weight-bold text-dark"
                                        @click="saveBill"
                                    >
                                        {{ __("Print") }}
                                    </a>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <button
                                        id="showPend"
                                        type="button"
                                        class="btn btn-primary"
                                        data-toggle="modal"
                                        data-target="#pending"
                                        @click="allPendingBills()"
                                    >
                                        {{ __("Pending Bills") }}
                                        <small class="d-block">CTRL+H</small>
                                    </button>
                                </td>

                                <td style="width: 10%">{{ __("Sum") }}</td>
                                <td style="width: 10%">
                                    <input
                                        type="number"
                                        min="0"
                                        step="0.01"
                                        v-model="form.sum"
                                        class="form-control form-control float-left text-center"
                                        readonly
                                    />
                                </td>
                                <td
                                    v-show="user.bill_discount"
                                    style="width: 10%"
                                >
                                    <label for="discount">
                                        {{ __("Discount") }}
                                        %
                                    </label>
                                    <input
                                        disabled
                                        class="form-check-input d-none"
                                        type="checkbox"
                                        v-model="form.isPercentDiscount"
                                        id="discount"
                                        @change="calcSum()"
                                    />
                                </td>
                                <td
                                    v-show="user.bill_discount"
                                    style="width: 10%"
                                >
                                    <input
                                        onClick="this.select();"
                                        type="number"
                                        min="0"
                                        step="0.01"
                                        v-model="form.discount"
                                        class="form-control form-control float-left text-center"
                                        @change="calcSum()"
                                    />
                                </td>
                                <td v-show="user.bill_extra">
                                    {{ __("Extra") }}
                                </td>

                                <td style="width: 10%" v-show="user.bill_extra">
                                    <input
                                        type="number"
                                        v-model="form.extra"
                                        class="num form-control form-control text-center"
                                        @change="calcSum()"
                                    />
                                </td>
                                <td>{{ __("Vat") }}</td>

                                <td style="width: 10%">
                                    <input
                                        v-model="form.vat"
                                        class="num form-control form-control text-center"
                                        readonly
                                    />
                                </td>
                                <td>{{ __("Total") }}</td>

                                <td style="width: 10%">
                                    <input
                                        v-model="form.total"
                                        class="num form-control form-control text-center"
                                        readonly
                                    />
                                </td>

                                <td>
                                    <input
                                        v-model="form.note"
                                        class="form-control"
                                        :placeholder="__('Notes')"
                                    />
                                </td>
                                <td>
                                    <a
                                        id="reset"
                                        title="CTRL+R"
                                        class="btn font-weight-bold btn-outline-warning text-dark"
                                        @click="clearAll()"
                                        >{{ __("Reset") }}</a
                                    >
                                    <button
                                        type="button"
                                        id="pend"
                                        title="CTRL+SHIFT+S"
                                        class="btn font-weight-bold btn-outline-warning text-dark"
                                        @click="pendBill()"
                                    >
                                        {{ __("Pend") }}
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td
                                    v-show="
                                        salesTypes.length > 0 &&
                                        form.sale != null
                                    "
                                >
                                    {{ __("Sales Type") }}
                                </td>
                                <td
                                    v-show="
                                        salesTypes.length > 0 &&
                                        form.sale != null
                                    "
                                >
                                    <select
                                        v-model="form.sale"
                                        class="form-control text-center w-100"
                                        @change="calcTotal()"
                                    >
                                        <option
                                            v-for="(sale, index) in salesTypes"
                                            :key="index"
                                            :value="sale"
                                            class="border-bottom"
                                        >
                                            {{ sale.sill_type_name }}/
                                            {{ sale.sill_type_discount }}
                                        </option>
                                    </select>
                                </td>
                                <td class="d-none">
                                    <!-- <v-quagga
                                        :onDetected="logIt"
                                        :readerSize="readerSize"
                                        :readerTypes="['ean_reader']"
                                    ></v-quagga> -->
                                </td>

                                <td>
                                    <input
                                        id="barcode"
                                        v-model="barcode"
                                        class="form-control"
                                        :placeholder="__('Barcode')"
                                        type="search"
                                        autofocus
                                        @change="findType()"
                                        onclick="event.preventDefault();this.select();"
                                        onchange="event.preventDefault();"
                                        onkeyup="event.preventDefault();"
                                    />
                                </td>
                                <td>
                                    <input
                                        v-model="id"
                                        class="form-control"
                                        :placeholder="__('Simple Code')"
                                        type="search"
                                        @change="findTypeByCodeOrId()"
                                    />
                                </td>
                                <td>
                                    <button
                                        id="searchtype"
                                        title="CTRL+F1"
                                        type="button"
                                        class="btn btn-sm btn-info"
                                        @click="showSearchTypeModal = true"
                                    >
                                        <i
                                            class="fa fa-search font-weight-bold text-light"
                                        ></i>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </form>
            </div>
            <!--Start Calculation-->
            <div class="row mb-3 newBill card-body">
                <div
                    :class="
                        mixins.bill_with_main_type
                            ? 'col-lg-6 col-md-12'
                            : 'col-lg-12 float-right'
                    "
                >
                    <!--Start Selected Items-->

                    <div class="selected" style="border: 1px solid #ddd">
                        <div class="card-header inbill text-center">
                            <p class="h6">{{ __("Bill Types") }}</p>
                        </div>
                        <div class="card-body" style="overflow-x: auto">
                            <div v-if="mixins.as_card" class="row text-center">
                                <div
                                    v-for="(product, index) in cart"
                                    :key="product.id"
                                    :class="
                                        product.has_Offer
                                            ? mixins.count_in_row_bill +
                                              ' bg-secondary text-light'
                                            : mixins.count_in_row_bill
                                    "
                                >
                                    <div class="card" style="width: 100%">
                                        <img
                                            loading="lazy"
                                            :alt="product.type_name_ar"
                                            :src="
                                                product.type_icon != null &&
                                                product.type_icon != ''
                                                    ? product.type_icon
                                                    : 'backend/products/product.png'
                                            "
                                            class="card-img-top w-100 pointer"
                                            @click="
                                                removeFromCart(product, index)
                                            "
                                        />
                                        <div
                                            class="card-body w-100 p-0 text-center"
                                        >
                                            <p>
                                                {{ product.type_name_ar }}
                                            </p>
                                            <p class="w-100">
                                                <input
                                                    v-model="product.type_note"
                                                    style="
                                                        width: 100%;
                                                        padding: 0;
                                                        border: 0;
                                                        box-shadow: none;
                                                        text-align: center;
                                                    "
                                                    :placeholder="__('Notes')"
                                                />
                                            </p>
                                        </div>
                                        <ul class="list-group list-group-flush">
                                            <li class="list-group-item p-0">
                                                <select
                                                    v-if="product.sell_unit"
                                                    v-model="product.sell_unit"
                                                    class="form-control w-100"
                                                    @change="
                                                        calcTotalTypeCost(
                                                            product
                                                        )
                                                    "
                                                >
                                                    <option
                                                        v-for="(
                                                            unit, index
                                                        ) in product.units"
                                                        v-if="unit.unit"
                                                        :key="index"
                                                        :selected="
                                                            unit ===
                                                            product.sell_unit
                                                                .unit
                                                        "
                                                        :value="unit"
                                                    >
                                                        {{
                                                            unit.unit
                                                                .unit_ar_name
                                                        }}
                                                    </option>
                                                </select>
                                                <span v-else>-</span>
                                            </li>

                                            <li class="list-group-item p-0">
                                                <table
                                                    class="text-center font-weight-bold w-100"
                                                >
                                                    <thead>
                                                        <tr>
                                                            <th
                                                                class="w-25"
                                                                v-show="
                                                                    form.table
                                                                "
                                                            >
                                                                {{
                                                                    __(
                                                                        "In Kitchen"
                                                                    )
                                                                }}
                                                            </th>

                                                            <th class="w-25">
                                                                {{
                                                                    __("Price")
                                                                }}
                                                            </th>

                                                            <th class="w-25">
                                                                {{
                                                                    __(
                                                                        "Discount"
                                                                    )
                                                                }}
                                                            </th>
                                                            <th class="w-25">
                                                                {{
                                                                    __("Total")
                                                                }}
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td
                                                                v-show="
                                                                    form.table
                                                                "
                                                                class="font-weight-bold w-25"
                                                            >
                                                                <label
                                                                    :for="
                                                                        'for-' +
                                                                        index
                                                                    "
                                                                >
                                                                    تــــــــــــم
                                                                </label>
                                                                <input
                                                                    class="form-check-input"
                                                                    type="checkbox"
                                                                    v-model="
                                                                        product.is_print
                                                                    "
                                                                    :id="
                                                                        'for-' +
                                                                        index
                                                                    "
                                                                />
                                                            </td>

                                                            <td>
                                                                <input
                                                                    onClick="this.select();"
                                                                    type="number"
                                                                    min="0"
                                                                    step="0.01"
                                                                    v-model="
                                                                        product.type_sill_price
                                                                    "
                                                                    :readonly="
                                                                        !user.change_price ||
                                                                        product.has_Offer
                                                                    "
                                                                    class="btn w-100"
                                                                    @keyup="
                                                                        calcSum()
                                                                    "
                                                                />
                                                            </td>
                                                            <td>
                                                                <input
                                                                    v-model="
                                                                        product.type_discount_value
                                                                    "
                                                                    onClick="this.select();"
                                                                    type="number"
                                                                    min="0"
                                                                    step="0.01"
                                                                    class="btn text-bold w-100"
                                                                    @change="
                                                                        onChangeTypeCost(
                                                                            product
                                                                        )
                                                                    "
                                                                />
                                                            </td>

                                                            <td
                                                                class="text-center"
                                                            >
                                                                {{
                                                                    format(
                                                                        product.total_type_cost
                                                                    )
                                                                }}
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </li>
                                        </ul>
                                        <div class="card-body w-100 px-0">
                                            <a
                                                v-if="product.type_count <= 1"
                                                class="btn mx-2 btn-danger"
                                                @click="
                                                    removeFromCart(
                                                        product,
                                                        index
                                                    )
                                                "
                                                ><i
                                                    class="fa fa-trash text-light"
                                                ></i>
                                            </a>
                                            <button
                                                v-else
                                                :disabled="product.has_Offer"
                                                class="btn mx-2 btn-warning"
                                                @click="decrement(product)"
                                            >
                                                -
                                            </button>
                                            <input
                                                v-model="product.type_count"
                                                :readonly="product.has_Offer"
                                                min="0"
                                                step="0.01"
                                                onClick="this.select();"
                                                type="number"
                                                class="btn"
                                                style="width: 80px"
                                                @keyup="
                                                    calcTotalTypeCost(product)
                                                "
                                            />

                                            <button
                                                :disabled="product.has_Offer"
                                                class="btn mx-2 btn-success"
                                                @click="increment(product)"
                                            >
                                                +
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <table
                                v-else
                                class="text-center font-weight-bold"
                                style="overflow-x: auto"
                            >
                                <thead>
                                    <tr>
                                        <th style="width: 40%">
                                            {{ __("Type Name") }}
                                        </th>
                                        <th style="width: 10%">
                                            {{ __("Unit") }}
                                        </th>
                                        <th style="width: 10%">
                                            {{ __("Count") }}
                                        </th>
                                        <th style="width: 10%">
                                            {{ __("Price") }}
                                        </th>
                                        <th style="width: 10%">
                                            {{ __("Discount Value") }}
                                        </th>

                                        <th style="width: 10%">
                                            {{ __("Total") }}
                                        </th>
                                    </tr>
                                </thead>
                                <tbody v-if="cart.length > 0">
                                    <tr
                                        v-for="(product, index) in cart"
                                        :key="product.id"
                                        :style="
                                            (product.type_stock !== null &&
                                                product.type_stock
                                                    .mixins_type_stock <=
                                                    mixins.item_request_qty) ||
                                            product.type_stock === null
                                                ? 'color:red!important'
                                                : ''
                                        "
                                    >
                                        <td
                                            :style="
                                                product.has_Offer
                                                    ? 'color:red!important'
                                                    : ''
                                            "
                                            class="font-weight-bold"
                                            @dblclick="addToExitStock(product)"
                                        >
                                            {{ product.type_name_ar }}
                                            <br />
                                            <input
                                                v-model="product.type_note"
                                                style="
                                                    width: 100%;
                                                    padding: 0;
                                                    border: 0;
                                                    box-shadow: none;
                                                    text-align: center;
                                                "
                                                :placeholder="__('Notes')"
                                            />
                                        </td>
                                        <td>
                                            <select
                                                style="width: 80px"
                                                v-if="product.sell_unit"
                                                v-model="product.sell_unit"
                                                class="form-control"
                                                @change="
                                                    calcTotalTypeCost(product)
                                                "
                                            >
                                                <option
                                                    v-for="(
                                                        unit, index
                                                    ) in product.units"
                                                    :key="index"
                                                    :selected="
                                                        unit ===
                                                        product.sell_unit.unit
                                                    "
                                                    :value="unit"
                                                >
                                                    {{ unit.unit.unit_ar_name }}
                                                </option>
                                            </select>
                                            <span v-else>-</span>
                                        </td>
                                        <td>
                                            <a
                                                v-if="
                                                    product.type_count <= 1 ||
                                                    weight ===
                                                        product.type_count
                                                "
                                                class="btn mx-2 btn-danger"
                                                @click="
                                                    removeFromCart(
                                                        product,
                                                        index
                                                    )
                                                "
                                                ><i
                                                    class="fa fa-trash text-light"
                                                ></i>
                                            </a>
                                            <button
                                                v-else
                                                :disabled="product.has_Offer"
                                                class="btn mx-2 btn-warning"
                                                @click="decrement(product)"
                                            >
                                                -
                                            </button>
                                            <input
                                                v-model="product.type_count"
                                                :readonly="product.has_Offer"
                                                min="0"
                                                type="number"
                                                step="0.01"
                                                class="btn"
                                                style="width: 80px"
                                                @keyup="
                                                    calcTotalTypeCost(product)
                                                "
                                            />

                                            <button
                                                :disabled="product.has_Offer"
                                                class="btn mx-2 btn-success"
                                                @click="increment(product)"
                                            >
                                                +
                                            </button>
                                        </td>
                                        <td>
                                            <input
                                                v-model="
                                                    product.type_sill_price
                                                "
                                                :readonly="
                                                    !$root.$data.user
                                                        .change_price ||
                                                    product.has_Offer
                                                "
                                                class="btn"
                                                min="0"
                                                type="number"
                                                @keyup="calcSum()"
                                                style="width: 80px"
                                            />
                                        </td>
                                        <td>
                                            <input
                                                v-model="
                                                    product.type_discount_value
                                                "
                                                onClick="this.select();"
                                                type="number"
                                                min="0"
                                                step="0.01"
                                                class="btn text-bold"
                                                style="width: 80px"
                                                @change="
                                                    onChangeTypeCost(product)
                                                "
                                            />
                                        </td>
                                        <td class="text-center">
                                            {{
                                                format(product.total_type_cost)
                                            }}
                                        </td>
                                    </tr>
                                </tbody>
                                <tbody v-else>
                                    <tr class="w-100">
                                        <td
                                            class="m-auto font-weight-light"
                                            colspan="7"
                                        >
                                            {{ __("No Chosen Types") }}
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!-- End Selected Items-->
                </div>

                <!--Start  All Products -->
                <div
                    v-show="mixins.bill_with_main_type"
                    class="col-lg-6 col-md-12"
                >
                    <div class="row">
                        <div v-if="!mixins.pretty" class="col-12">
                            <ul
                                id="pills-tab"
                                class="nav nav-pills w-100 p-0"
                                role="tablist"
                            >
                                <li
                                    v-for="(
                                        cat, index
                                    ) in filterSearchInCategory"
                                    :id="'cat-' + index"
                                    :key="index"
                                    class="cat-0 nav-item my-1 mx-1 mb-1"
                                    role="presentation"
                                    style="border: 1px solid #ddd"
                                >
                                    <a
                                        v-if="category"
                                        :id="
                                            'pills-' + cat.main_type_id + '-tab'
                                        "
                                        :aria-controls="
                                            'pills-' + category.main_type_id
                                        "
                                        :class="
                                            cat === category
                                                ? 'nav-link active'
                                                : 'nav-link'
                                        "
                                        :data-bs-target="
                                            '#pills-' + cat.main_type_id
                                        "
                                        aria-selected="true"
                                        class="btn btn-outline-primary font-weight-bold text-dark"
                                        data-bs-toggle="pill"
                                        role="tab"
                                        type="button"
                                        @click="category = cat"
                                    >
                                        {{ cat.main_type_title_ar }}
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div
                            :class="
                                mixins.pretty
                                    ? 'col-md-9 col-sm-8'
                                    : 'col-md-12 col-sm-12'
                            "
                            style="border: 1px solid #ddd"
                        >
                            <div class="card-header inbill" v-if="category">
                                <p class="text-center float-right">
                                    <i
                                        v-if="mixins.pretty"
                                        class="fa fa-columns mx-2"
                                        @click="changeView()"
                                    ></i>
                                    <i
                                        v-else
                                        class="fa fa-table mx-2"
                                        @click="changeView()"
                                    ></i>
                                    {{ __("Items") }}
                                    {{ category.main_type_title_ar }}
                                </p>
                                <input
                                    v-model="searchTerm"
                                    class="form-control float-left w-50"
                                    :placeholder="__('Name ar')"
                                    type="text"
                                />
                            </div>
                            <div
                                v-if="category"
                                :id="'pills-' + category.main_type_id"
                                :aria-labelledby="
                                    'pills-' + category.main_type_id + '-tab'
                                "
                                class="tab-pane fade show"
                                role="tabpanel"
                            >
                                <div id="pills-tabContent" class="tab-content">
                                    <div class="row">
                                        <div
                                            v-for="product in filterSearchInCatType"
                                            :key="product.type_id"
                                            :class="mixins.count_in_row_main"
                                            @click="addToCart(product)"
                                        >
                                            <div
                                                class="pointer card text-center mb-2"
                                            >
                                                <span class="d-none"
                                                    >{{
                                                        product.type_id
                                                    }}></span
                                                >
                                                <img
                                                    loading="lazy"
                                                    :alt="product.type_name_ar"
                                                    :src="
                                                        product.type_icon !=
                                                            null &&
                                                        product.type_icon != ''
                                                            ? product.type_icon
                                                            : 'backend/products/product.png'
                                                    "
                                                    class="w-100"
                                                />
                                                <div
                                                    class="card__shop card-header py-0"
                                                >
                                                    <b
                                                        class="card__shop__price font-weight-bold text-light badge badge-info"
                                                        >{{
                                                            Number(
                                                                product.sell_unit
                                                                    ? product
                                                                          .sell_unit
                                                                          .price
                                                                    : product.type_sill_price
                                                            ).toFixed(
                                                                mixins.digit
                                                            )
                                                        }}</b
                                                    >
                                                    <h2
                                                        class="card__title w-100 font-weight-bold"
                                                    >
                                                        {{
                                                            product.type_name_ar
                                                        }}
                                                    </h2>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div
                            v-if="mixins.pretty"
                            class="col-md-3 col-sm-4"
                            style="border: 1px solid #ddd"
                        >
                            <div class="card-header inbill">
                                <p class="h6 text-center">
                                    {{ __("Categories") }}
                                </p>
                            </div>
                            <input
                                v-model="catName"
                                class="form-control"
                                :placeholder="__('Name ar')"
                                type="text"
                            />
                            <ul
                                id="pills-tab"
                                class="nav nav-pills w-100 p-0"
                                role="tablist"
                            >
                                <li
                                    v-for="(
                                        cat, index
                                    ) in filterSearchInCategory"
                                    :id="'cat-' + index"
                                    :key="index"
                                    class="cat-0 nav-item my-1 w-100"
                                    role="presentation"
                                    style="border: 1px solid #ddd"
                                >
                                    <a
                                        :id="
                                            'pills-' + cat.main_type_id + '-tab'
                                        "
                                        :aria-controls="
                                            'pills-' + category.main_type_id
                                        "
                                        :class="
                                            cat === category
                                                ? 'nav-link active'
                                                : 'nav-link'
                                        "
                                        :data-bs-target="
                                            '#pills-' + cat.main_type_id
                                        "
                                        aria-selected="true"
                                        class="btn btn-outline-primary font-weight-bold text-dark"
                                        data-bs-toggle="pill"
                                        role="tab"
                                        type="button"
                                        @click="category = cat"
                                    >
                                        {{ cat.main_type_title_ar }}
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!--  End All Products -->
            </div>

            <div
                id="exampleModal"
                aria-hidden="true"
                aria-labelledby="exampleModalLabel"
                class="modal fade"
                role="dialog"
                tabindex="-1"
            >
                <div
                    class="modal-dialog modal-dialog-centered modal-dialog-scrollable"
                    role="document"
                >
                    <div class="modal-content m-auto" style="min-width: 850px">
                        <div class="modal-header">
                            <button
                                aria-label="Close"
                                class="close"
                                data-dismiss="modal"
                                type="button"
                            >
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="col-lg-12 mb-4">
                                <div class="table-responsive w-100">
                                    <label
                                        >Search:<input
                                            v-model="searchName"
                                            aria-controls="dataTable"
                                            class="form-control form-control"
                                            type="search"
                                    /></label>
                                    <table class="table align-items-center">
                                        <thead>
                                            <tr>
                                                <th style="width: 50%">
                                                    {{
                                                        __(
                                                            "Customer Code/Mobile"
                                                        )
                                                    }}
                                                </th>
                                                <th style="width: 30%">
                                                    {{ __("Customer Name") }}
                                                </th>
                                                <th style="width: 10%">
                                                    {{ __("Mobile") }}
                                                </th>
                                                <th style="width: 10%">
                                                    {{ __("Cuatomer Balance") }}
                                                </th>
                                                <th style="width: 10%">
                                                    {{ __("Select") }}
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr
                                                v-for="(
                                                    customer, index
                                                ) in filterSearch"
                                                :key="index"
                                            >
                                                <td>{{ customer.cust_id }}</td>
                                                <td>
                                                    {{ customer.cust_name }}
                                                </td>
                                                <td>
                                                    {{ customer.cust_mobile }}
                                                </td>
                                                <td>
                                                    {{ customer.cust_balance }}
                                                </td>
                                                <td>
                                                    <button
                                                        class="btn btn-success btn-sm"
                                                        data-dismiss="modal"
                                                        @click="
                                                            selectCustomer(
                                                                customer
                                                            )
                                                        "
                                                    >
                                                        <i
                                                            class="fa fa-plus font-weight-bold text-light"
                                                        ></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button
                                class="btn btn-secondary"
                                data-dismiss="modal"
                                type="button"
                            >
                                Close
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <Printer
                    :bill="bill"
                    :qr="qr"
                    v-if="mixins.printer_type === 1"
                />
                <A4Printer :bill="bill" :qr="qr" v-else />
            </div>
        </div>
        <Spinner v-else :title="title" />
    </div>
</template>

<script>
import Printer from "../printer.vue";

import Spinner from "../spinner/mixinsSpinner.vue";
import { Invoice } from "@axenda/zatca";
import moment from "moment";

import A4Printer from "../A4Printer.vue";
import Tafgeet from "tafgeetjs";

export default {
    components: { Printer, Spinner, A4Printer },
    async created() {
        if (!User.loggedIn()) {
            await this.$router.push("/");
        }
        await axios
            .get("/api/users/" + localStorage.getItem("user_id"))
            .then(({ data }) => (this.user = data))
            .catch((error) => console.log(error));
        await this.getMixins();

        if (this.mixins.bill_with_main_type) {
            await this.allMainType();
        } else {
            this.loading = false;
        }
        await this.allSalesType();

        await this.allPayMethods();
        this.form.sale = this.mixins.sale;
        this.form.is_included = this.mixins.mixins_price_include_vat;
        this.form.current_vat = this.mixins.mixins_vat_val;
    },

    computed: {
        filterSearchInCategory() {
            return this.categories.filter((cat) => {
                return cat.main_type_title_ar.match(this.catName);
            });
        },
        filterSearchInCatType() {
            if (this.category.products) {
                return this.category.products.filter((type) => {
                    return type.type_name_ar.match(this.searchTerm);
                });
            }
        },
        filterSearch() {
            return this.customers.filter((customer) => {
                return customer.cust_name.match(this.customer_name);
            });
        },
    },

    data() {
        return {
            user: {},
            disable: false,

            title: "",
            weight: 0,
            pending: [],
            mixins: {},
            selected: "",
            isNewCustomer: false,

            readerSize: {
                width: 640,
                height: 480,
            },
            detecteds: [],
            searchTypes: [],
            showSearchTypeModal: false,
            output: null,
            qr: "",
            isNewbill: true,
            isPrint: false,
            loading: true,
            products: [],
            payMethods: [],
            categories: [],
            category: {},
            customers: [],
            customer: {
                cust_name: null,
                cust_address: null,
                cust_mobile: null,
                cust_vat_num: null,
            },
            search: "",
            barcode: "",
            id: "",
            searchName: "",
            typeName: "",
            type: {},
            bill_id: 0,
            bill: {},
            cart: [],
            form: {
                is_included: false,
                current_vat: 0,
                sumAfterDiscount: 0.0,
                sale: null,
                user_id: null,
                note: "",
                sum: 0.0,
                discount: 0.0,
                total: 0.0,
                extra: 0.0,
                vat: 0.0,
                cart: [],
                paid: 0.0,
                remain: 0.0,
                customer: {},
                pay: 1,
                isPercentDiscount: true,
                pendingBill: null,
                offerDiscount: 0.0,
                billDiscountPercent: 0.0,
                sale_discount: 0.0,
                stock: [],
            },
            stocks: {
                id: "",
                count: 0,
            },
            salesTypes: [],

            errors: {},
            pending: [],
            selected: "",
            catName: "",
            searchTerm: "",
        };
    },
    methods: {
        logIt(data) {
            console.log("detected", data);
        },
        changeView() {
            this.mixins.pretty = !this.mixins.pretty;
        },
        async getMixins() {
            await axios
                .get("/api/mixins/1")
                .then(({ data }) => {
                    this.mixins = data;
                })
                .catch((error) => console.log(error));
        },

        async allPendingBills() {
            await axios
                .get("/api/cashier/pendingBills")
                .then(({ data }) => (this.pending = data))
                .catch((error) => console.log(error));
        },
        async pendBill() {
            this.form.user_id = localStorage.getItem("user_id");
            this.form.cart = this.cart;
            this.form.customer = this.customer;
            if (this.form.cart.length > 0) {
                await axios.post("api/cashier/pendingBills", this.form);
            }
            await this.clearAll();
        },
        async onSelectPendingBill(bill) {
            this.form.pendingBill = bill;
            if (this.form.pendingBill.table_type.length > 0) {
                this.cart = [];
                await this.form.pendingBill.table_type.forEach(
                    async (product) => {
                        this.product = {};
                        this.product.type_stock = product.type.type_stock;
                        if (product.units != null) {
                            this.product.sell_unit = product.sell_unit;
                            this.product.units = [];
                            this.product.units.push(product.units);
                        } else {
                            this.product.sell_unit = null;
                        }

                        this.product.type_name_ar = product.type.type_name_ar;
                        this.product.type_sill_price = product.type_price;
                        this.product.type_purchases_price =
                            product.type_purchases_price;
                        this.product.type_count = product.type_count;
                        this.product.type_id = product.type_id;
                        this.product.total_type_cost = product.type_total_price;
                        this.product.type_note = product.type_note;
                        this.product.type_discount_value =
                            product.type_discount;
                        this.product.type_vat_percent = product.type_vat;
                        this.cart.push(this.product);
                    }
                );
            }

            await this.calcSum();
            await this.deletePind(bill.id);
        },
        async create() {
            await axios
                .post("/api/customers", this.customer)
                .then(({ data }) => {
                    this.search = data.cust_mobile;
                    this.findCustomer();
                    $("#closeDlg").click();
                    Notification.success();
                })
                .catch((error) => {
                    this.errors = error.response.data.errors;
                })
                .then((error) => {
                    if (this.errors.cust_name)
                        Notification.customMsg(
                            "error",
                            "topRight",
                            this.errors.cust_name[0]
                        );

                    if (this.errors.cust_mobile)
                        Notification.customMsg(
                            "error",
                            "topRight",
                            this.errors.cust_mobile[0]
                        );
                });
        },
        async allMainType() {
            await axios
                .get("/api/AllCategories")
                .then(async ({ data }) => {
                    this.categories = data;
                    this.loading = false;
                    this.category = this.categories[0];
                })
                .then(() => {})
                .catch((error) => console.log(error));
        },

        async allProducts() {
            await axios
                .get("/api/types")
                .then(({ data }) => {
                    this.products = data;
                })
                .catch((error) => console.log(error));
        },
        async allPayMethods() {
            await axios
                .get("/api/payMethods")
                .then(({ data }) => (this.payMethods = data))
                .catch((error) => console.log(error));
        },
        async allCustomers() {
            await axios
                .get("/api/action/all/customers")
                .then(({ data }) => (this.customers = data))
                .catch((error) => console.log(error));
        },
        async findCustomer() {
            this.form.discount = 0.0;
            await axios
                .get("/api/customers/" + this.search)
                .then(({ data }) => {
                    this.customer = data;
                })
                .catch((error) => console.log(error));
            await this.calcSum();
        },

        async findType() {
            await axios
                .get(
                    "/api/findTypeByBarcode/" + this.barcode.replace(/\s/g, "")
                )
                .then(async ({ data }) => {
                    this.type = data;
                    await this.addToCart(this.type);
                    this.barcode = "";
                })
                .catch((error) => {
                    Notification.customMsg(
                        "warning",
                        "topRight",
                        "لايوجد صنف بهذا الاسم"
                    );
                });
        },
        async findTypeByCodeOrId() {
            await axios
                .get("/api/action/find/" + this.id)
                .then(({ data }) => {
                    this.type = data;
                    if (data.type_id != null) {
                        this.addToCart(data);
                        this.id = "";
                    } else {
                        Notification.customMsg(
                            "warning",
                            "topRight",
                            "لايوجد صنف بهذا الاسم"
                        );
                    }
                })
                .catch((error) => console.log(error));
        },
        allSalesType() {
            axios
                .get("/api/saleType")
                .then(({ data }) => {
                    if (data.length >= 0) {
                        this.loading = false;
                        this.salesTypes = data;
                    }
                })
                .catch((error) => console.log(error));
        },
        async checkIfTypeHasOffer(product) {
            await axios
                .get("/api/action/offerType/" + product.type_id)
                .then(({ data }) => {
                    data.map((type) => {
                        if (type.main_type != null) {
                            if (product.type_count === type.main_type_count) {
                                let offer = type.offer_type;
                                offer.type_sill_price =
                                    offer.type_sill_price -
                                    (offer.type_sill_price *
                                        type.offer_discount_percent) /
                                        100.0;
                                offer.type_count = 1;
                                offer.has_Offer = true;
                                this.cart.push(offer);

                                this.calcTotalTypeCost(offer);
                            }
                            this.id = "";
                        }
                    });
                })
                .catch((error) => console.log(error));
        },

        async findTypeByLike() {
            if (this.typeName != "" && this.typeName != null) {
                await axios
                    .get("/api/action/like/" + this.typeName)
                    .then(({ data }) => {
                        this.searchTypes = data;
                    })
                    .catch((error) => console.log(error));
            }
        },
        selectCustomer(customer) {
            this.form.discount = 0.0;
            this.customer = customer;
            this.search = customer.cust_id;
            this.calcSum();
        },

        async print(id) {
            this.bill = null;
            await axios
                .get("api/cashier/bills/" + id)
                .then(async ({ data }) => {
                    this.bill = data;
                    if (this.bill.bill_total > 0) {
                        this.bill.billTotal = new Tafgeet(
                            this.bill.bill_total,
                            this.mixins.country === 1 ? "EGP" : "SAR"
                        ).parse();
                    }
                    if (this.bill != null) {
                        const invoice = new Invoice({
                            sellerName: this.mixins.mixins_name,
                            vatRegistrationNumber: this.mixins.contruct_no,
                            invoiceTimestamp: this.bill.bill_date,
                            invoiceTotal: this.bill.bill_total,
                            invoiceVatTotal: this.bill.bill_vat_val,
                        });
                        this.qr = await invoice.render();
                    }
                })
                .then(() => {
                    $("#printer").click();
                    $("#btn").click();
                })

                .catch((err) => console.log(err));
        },

        async calcIfCustomerHasDiscount() {
            if (
                this.cart.length >= 0 &&
                this.customer &&
                this.form.discount <= 0
            ) {
                if (this.customer.cust_discount_percent > 0) {
                    this.form.discount = 0;
                    this.form.discount = this.customer.cust_discount_percent;
                }
            }
        },
        checkOfferDate() {
            const current = new Date();
            if (
                moment(this.mixins.offer_start_date).isBefore(current) &&
                moment(this.mixins.offer_end_date).isAfter(current)
            ) {
                if (this.mixins.offer_percenet > 0) {
                    this.form.discount = 0;
                    this.form.discount = this.mixins.offer_percenet;
                    return;
                }
            }
        },
        async findTypeStock(id) {
            let stock = 0;
            await axios
                .get("/api/typeStocks/" + id)
                .then(({ data }) => {
                    if (data.mixins_type_stock_id != null) {
                        stock = data.mixins_type_stock;
                    }
                })
                .catch((error) => console.log(error));

            return stock;
        },

        async addToCart(product) {
            await this.checkStock(product);
            this.searchTerm = "";
            this.weight = 0.0;
            if (this.mixins.weight_barcode) {
                if (
                    product.type_barcode != null &&
                    product.type_barcode.length ===
                        this.mixins.weight_barcode_count
                ) {
                    if (this.mixins.weight_barcode_count === 13) {
                        this.weight =
                            product.type_barcode.substring(7, 12) / 1000.0;
                    }
                    if (this.mixins.weight_barcode_count === 12) {
                        this.weight =
                            product.type_barcode.substring(6, 11) / 1000.0;
                    }
                }
            }

            let cloneProduct = await JSON.parse(JSON.stringify(product));

            if (this.weight === 0) {
                cloneProduct.type_count = 1;
            } else {
                cloneProduct.type_count += this.weight;
            }
            this.cart.push(cloneProduct);

            if (this.mixins.active_type_offer) {
                await this.checkIfTypeHasOffer(cloneProduct);
            }
            await this.calcTotalTypeCost(cloneProduct);
        },
        async removeFromCart(product, index) {
            product.type_count = 1;
            product.total_type_cost =
                product.type_count * parseFloat(product.type_sill_price);
            this.$delete(this.cart, index);
            await this.calcSum();
        },
        async checkStock(product) {
            if (this.mixins.reqeust_alert) {
                if (product.type_stock != null) {
                    if (
                        product.type_stock.mixins_type_stock <=
                        this.mixins.item_request_qty
                    ) {
                        if (product.type_request === null) {
                            await this.addToExitStock(product);
                        }
                    }
                } else {
                    await this.addToExitStock(product);
                }
            }
        },
        async increment(product) {
            await this.checkStock(product);

            if (this.weight === 0) {
                product.type_count++;
            } else {
                product.type_count += this.weight;
            }
            await this.calcTotalTypeCost(product);
        },
        async decrement(product) {
            if (this.weight === 0) {
                product.type_count--;
            } else {
                if (product.type_count > this.weight) {
                    product.type_count -= this.weight;
                } else {
                    product.type_count = this.weight;
                }
            }

            await this.calcTotalTypeCost(product);
        },

        async onChangeTypeCost(product) {
            if (product.type_sill_price < product.minimum_sill_price) {
                product.type_sill_price = product.minimum_sill_price;
            }
            await this.calcTotalTypeCost(product);
        },

        async calcTotalTypeCost(product) {
            product.calc_count = 0;
            product.type_sill_price = product.sell_unit.price ?? 0.0;
            if (product.type_stock !== null) {
                if (product.type_stock.mixins_type_stock > 0) {
                    var allNoUintBefore =
                        product.sell_unit.no_of_unit *
                        product.type_stock.mixins_type_stock;
                    var totalNofUnitAfter =
                        allNoUintBefore - product.type_count;
                    product.calc_count =
                        (allNoUintBefore - totalNofUnitAfter) /
                        product.sell_unit.no_of_unit;
                }
            }

            await this.calcSum();
        },
        async calcSum() {
            this.form.sum = 0;
            this.form.vat = 0;
            this.form.total = 0;
            this.cart.filter((product) => {
                product.total_type_cost =
                    product.type_count * parseFloat(product.type_sill_price);
                product.total_type_cost =
                    product.total_type_cost - product.type_discount_value;

                this.form.sum =
                    parseFloat(this.form.sum) +
                    parseFloat(product.total_type_cost);
            });

            if (this.mixins.mixins_price_include_vat && this.mixins.fixed_vat) {
                let vatVal = this.mixins.mixins_vat_val;
                this.form.sum =
                    this.form.sum / (1 + parseFloat(vatVal) / 100.0);
            }
            await this.calcTotal();
        },
        async calcTotal() {
            if (
                this.cart.length === 0 &&
                this.form.discount > this.form.total
            ) {
                Notification.customMsg(
                    "error",
                    "topRight",
                    "لايمكن ان يكون الخصم اكبر من الاجمالي",
                    5000
                );
                this.form.discount = 0;
            }
            this.form.total = 0;
            await this.calcIfCustomerHasDiscount();
            if (this.mixins.active_offer) {
                await this.checkOfferDate();
            }
            this.form.total =
                parseFloat(this.form.sum) + parseFloat(this.form.extra);

            this.form.offerDiscount =
                (parseFloat(this.form.total) *
                    parseFloat(this.form.offerDiscount)) /
                100.0;

            this.form.billDiscountPercent =
                (parseFloat(this.form.total) * parseFloat(this.form.discount)) /
                100.0;
            this.form.total =
                parseFloat(this.form.total) -
                parseFloat(this.form.billDiscountPercent);
            if (this.form.sale != null) {
                this.form.sale_discount =
                    parseFloat(this.form.total) *
                    (parseFloat(this.form.sale.sill_type_discount) / 100.0);
                this.form.total = parseFloat(
                    this.form.total - this.form.sale_discount
                );
            }
            this.form.sumAfterDiscount = this.form.total;

            await this.calcVat(this.form.total);

            this.form.total =
                parseFloat(this.form.total) + parseFloat(this.form.vat);

            //Form number
            this.form.vat = this.format(this.form.vat);
            this.form.sum = this.format(this.form.sum);
            this.form.total = this.format(this.form.total);
            this.form.discount = this.format(this.form.discount);

            if (this.form.pay !== 3) {
                this.form.paid = this.form.total;
                this.form.remain = 0;
            } else {
                this.form.remain = this.form.total;
                this.form.paid = 0;
            }
        },
        calcVat(total) {
            this.form.vat = 0;
            if (!this.mixins.fixed_vat) {
                this.cart.filter((product) => {
                    this.form.vat =
                        parseFloat(this.form.vat) +
                        (product.total_type_cost * product.type_vat_percent) /
                            100.0;
                    console.log(product);
                });
                return;
            }
            if (this.mixins.mixins_vat_val > 0 && this.mixins.fixed_vat) {
                let vatVal = this.mixins.mixins_vat_val;
                this.form.vat = (total * vatVal) / 100.0;
                return;
            }
        },
        calcRemain() {
            this.form.remain = this.form.total - this.form.paid;
            this.form.remain = parseFloat(this.form.remain);
        },
        async saveBill() {
            let isValid = true;
            if (this.cart.length <= 0) {
                isValid = false;
                Notification.customMsg(
                    "error",
                    "topRight",
                    "لايمكن حفظ فاتورة بدون أصناف"
                );
                return;
            }
            if (this.form.total <= 0 && this.form.discount <= 0) {
                isValid = false;
                Notification.customMsg(
                    "error",
                    "topRight",
                    "لايمكن حفظ فاتورة قيمتها صفر"
                );
                return;
            }
            if (this.form.pay === 3 && this.customer.cust_id == null) {
                isValid = false;
                Notification.customMsg(
                    "error",
                    "topRight",
                    "الفاتورة آجل! يجب اختيار عميل",
                    5000
                );
                return;
            }
            if (isValid) await this.saveValidBill();
        },
        async saveValidBill() {
            this.disable = true;
            this.form.user_id = localStorage.getItem("user_id");
            this.form.cart = this.cart;
            this.form.customer = this.customer;
            if (this.form.cart.length > 0) {
                await axios
                    .post("api/cashier/bills", this.form)
                    .then((data) => {
                        Notification.success();
                        this.print(data.data);
                        setTimeout(() => $("#btn").click(), 200);
                        this.isPrint = true;
                        this.clearAll();
                        this.disable = false;
                    })
                    .catch((error) => {
                        this.disable = false;
                    });
            } else {
                Notification.error();
                this.disable = false;
            }
        },
        async addToExitStock(product) {
            if (this.mixins.reqeust_alert) {
                if (confirm("هل تريد إضافة الصنف للنواقص")) {
                    axios
                        .get("/api/action/" + product.type_id)
                        .then(({ data }) =>
                            Notification.successMsg("تم إضافة الصنف للنواقص")
                        )
                        .catch((error) => console.log(error));
                } else {
                    Notification.errorMsg("لم يتم اضافة الصنف للنواقص");
                }
            }
        },

        async clearAll() {
            this.form.vat = 0.0;
            this.customer = {};
            this.search = "";
            this.bill = {};
            this.isPrint = false;
            this.cart = [];
            this.form = {
                sumAfterDiscount: 0.0,
                user_id: null,
                note: "",
                sum: 0.0,
                discount: 0.0,
                total: 0.0,
                extra: 0.0,
                vat: 0.0,
                cart: [],
                paid: 0.0,
                remain: 0.0,
                customer: {
                    cust_name: null,
                    cust_address: null,
                    cust_discount_val: 0,
                    cust_discount_percent: 0,
                    cust_mobile: null,
                    cust_balance: 0,
                },
                pay: 1,
                isPercentDiscount: true,
                offerDiscount: 0.0,
                billDiscountPercent: 0.0,
            };
            this.form.sale = this.mixins.sale;

            this.weight = 0;
            this.barcode = "";
        },
        format(num) {
            return parseFloat(num).toFixed(this.mixins.digit);
        },
        async deletePind(id) {
            await axios
                .delete("/api/cashier/pendingBills/" + id)
                .then(async (data) => {
                    await this.allPendingBills();
                })
                .catch((err) => console.log(err));
        },
    },
};
</script>
<style scoped>
.fa {
    cursor: pointer;
}
.card__shop__price {
    position: absolute;
    bottom: 100%;
    right: 0;
}
.card__shop.card-header {
    padding: 0 0 !important;
}
:root {
    --secondary: linear-gradient(221deg, #8743ff, #4136f1 60%);
    --body: #eaf2ff;
    --card: #fff;
    --text: #000;
    --price: #4136f1;
}

body {
    /*background: var(--secondary);*/
    transition: background 0.3s;
    gap: 20px;
    font-family: "Poppins", sans-serif;
}

.newBill .card {
    background: var(--card);
    font-family: "Poppins", sans-serif;
    display: flex;
    color: var(--text);
    flex-direction: column;
    align-items: flex-start;
    transition: transform 0.3s, background 0.3s;
}

.newBill .card-header {
    font-weight: bolder;
}

.tab-content .card:hover,
.selected .card .card:hover {
    transform: scale(1.09);
}

.newBill .card img {
    width: 160px;
    height: 120px;
    object-fit: cover;
}

.newBill .card__title {
    margin-top: 5px;
    font-size: 15px;
    font-weight: 400;
    transition: color 0.3s;
}

.newBill .card__shop {
    width: 100%;
    margin-top: auto;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.newBill .card__shop__action span {
    color: #fff;
    font-size: 26px;
}
</style>
