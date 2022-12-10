<template>
    <div>
        <div v-if="!loading">
            <div class="row mb-3 newBill">
                <div class="col-md-12">
                    <!--Start Selected Items-->
                    <div class="selected text-center w-100">
                        <div class="card mb-4 text-center">
                            <div
                                class="card-header w-100 d-flex flex-row align-items-center justify-content-between hideMeInPrint"
                            >
                                <h6 class="m-0 font-weight-bold text-primary">
                                    {{ __("Sales Return") }}
                                </h6>

                                <h6
                                    class="m-0 font-weight-bold text-primary float-left"
                                >
                                    <input
                                        class="form-control-sm w-75"
                                        :placeholder="__('Bill Number')"
                                        type="text"
                                        v-model="bill_id"
                                        @keyup="findBill()"
                                    />
                                </h6>
                                <h6
                                    class="m-0 font-weight-bold text-primary float-left"
                                >
                                    <input
                                        class="form-control-sm w-75"
                                        :placeholder="__('Barcode')"
                                        type="text"
                                        v-model="barcode"
                                        @keyup="findBillByTypeId()"
                                    />
                                </h6>

                                <form
                                    v-show="!period"
                                    class="needs-validation"
                                    @submit.prevent="allBills"
                                >
                                    <div class="form-row">
                                        <div class="col-md-5">
                                            <div class="input-group">
                                                <div
                                                    class="input-group-prepend"
                                                    style="
                                                        width: 50px !important;
                                                    "
                                                >
                                                    <span
                                                        id="validationTooltipUsernamePrepend"
                                                        class="input-group-text"
                                                    >
                                                        {{ __("From") }}
                                                    </span>
                                                </div>
                                                <date-picker
                                                    v-model="reportPeriod.from"
                                                    id="to"
                                                    :wrap="true"
                                                    :config="configs.wrap"
                                                    required
                                                >
                                                </date-picker>
                                            </div>
                                        </div>
                                        <div class="col-md-5">
                                            <div class="input-group">
                                                <div
                                                    class="input-group-prepend float-right"
                                                    style="
                                                        width: 50px !important;
                                                    "
                                                >
                                                    <span
                                                        class="input-group-text"
                                                        for="to"
                                                    >
                                                        {{ __("To") }}
                                                    </span>
                                                </div>
                                                <date-picker
                                                    v-model="reportPeriod.to"
                                                    id="to"
                                                    :wrap="true"
                                                    :config="configs.wrap"
                                                    required
                                                >
                                                </date-picker>
                                            </div>
                                        </div>
                                        <button
                                            class="btn btn-success font-weight-bold text-light btn-sm"
                                            type="submit"
                                        >
                                            {{ __("View") }}
                                        </button>
                                    </div>
                                </form>
                                <form
                                    class="w-25"
                                    direction="rtl"
                                    @submit.prevent="saveBill"
                                >
                                    <table class="table-bordered">
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <b> {{ __("Sum") }} :</b>
                                                    {{ returnBill.sum }}
                                                </td>
                                                <td>
                                                    <b> {{ __("Vat") }} :</b>
                                                    {{ returnBill.vat }}
                                                </td>
                                                <td>
                                                    <b> {{ __("Total") }} :</b>
                                                    {{ returnBill.total }}
                                                </td>
                                                <td>
                                                    <button
                                                        :disabled="
                                                            returnBill.total <=
                                                            0
                                                        "
                                                        class="btn btn-success font-weight-bold text-light"
                                                        type="submit"
                                                    >
                                                        {{ __("Save") }}
                                                    </button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </form>
                            </div>
                            <div class="card-body w-100 text-center">
                                <div
                                    class="table-responsive"
                                    id="printMeReport"
                                    style="height: 50vh"
                                >
                                    <table
                                        id="resultTable"
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
                                                    {{ __("Vat") }}
                                                </th>
                                                <th style="width: 10%">
                                                    {{ __("Total") }}
                                                </th>
                                                <th style="width: 5%">
                                                    {{ __("Discount") }}
                                                </th>
                                                <th style="width: 10%">
                                                    {{ __("Paid") }}
                                                </th>
                                                <th style="width: 10%">
                                                    {{ __("Remain") }}
                                                </th>
                                                <th style="width: 20%">
                                                    {{ __("Bill Date") }}
                                                </th>
                                                <th style="width: 5%">
                                                    {{ __("Pay Method") }}
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
                                                <th
                                                    v-show="user.reprint_bill"
                                                    class="hideMeInPrint"
                                                    style="width: 10%"
                                                >
                                                    {{ __("Print") }}
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr
                                                v-for="bill in bills"
                                                :key="bill.bill_no"
                                                @click="
                                                    showBillDetails(bill);
                                                    selected = bill.bill_no;
                                                "
                                                :class="
                                                    bill.returned
                                                        ? 'text-light bg-secondary'
                                                        : ''
                                                "
                                            >
                                                <td
                                                    :class="
                                                        selected ===
                                                        bill.bill_no
                                                            ? 'selected'
                                                            : ''
                                                    "
                                                >
                                                    {{ bill.bill_no }}
                                                </td>
                                                <td
                                                    :class="
                                                        selected ===
                                                        bill.bill_no
                                                            ? 'selected'
                                                            : ''
                                                    "
                                                >
                                                    {{ bill.bill_sum }}
                                                </td>
                                                <td
                                                    :class="
                                                        selected ===
                                                        bill.bill_no
                                                            ? 'selected'
                                                            : ''
                                                    "
                                                >
                                                    ({{ bill.vat }}%)
                                                    {{ bill.bill_vat_val }}
                                                </td>
                                                <td
                                                    :class="
                                                        selected ===
                                                        bill.bill_no
                                                            ? 'selected'
                                                            : ''
                                                    "
                                                >
                                                    {{ bill.bill_total }}
                                                </td>
                                                <td
                                                    :class="
                                                        selected ===
                                                        bill.bill_no
                                                            ? 'selected'
                                                            : ''
                                                    "
                                                >
                                                    {{ bill.bill_discount }}
                                                </td>
                                                <td
                                                    :class="
                                                        selected ===
                                                        bill.bill_no
                                                            ? 'selected'
                                                            : ''
                                                    "
                                                >
                                                    {{ bill.bill_paid_val }}
                                                </td>
                                                <td
                                                    :class="
                                                        selected ===
                                                        bill.bill_no
                                                            ? 'selected'
                                                            : ''
                                                    "
                                                >
                                                    {{ bill.bill_remain_val }}
                                                </td>
                                                <td
                                                    :class="
                                                        selected ===
                                                        bill.bill_no
                                                            ? 'selected'
                                                            : ''
                                                    "
                                                >
                                                    {{ bill.bill_date }}
                                                </td>
                                                <td
                                                    v-if="bill.pay_methods"
                                                    :class="
                                                        selected ===
                                                        bill.bill_no
                                                            ? 'selected'
                                                            : ''
                                                    "
                                                >
                                                    {{
                                                        bill.pay_methods
                                                            .pay_method_name
                                                    }}
                                                </td>
                                                <td
                                                    :class="
                                                        selected ===
                                                        bill.bill_no
                                                            ? 'selected'
                                                            : ''
                                                    "
                                                >
                                                    {{
                                                        bill.customer
                                                            ? bill.customer
                                                                  .cust_name
                                                            : ""
                                                    }}
                                                </td>
                                                <td
                                                    :class="
                                                        selected ===
                                                        bill.bill_no
                                                            ? 'selected'
                                                            : ''
                                                    "
                                                >
                                                    {{
                                                        bill.user
                                                            ? bill.user.name
                                                            : ""
                                                    }}
                                                </td>
                                                <td
                                                    :class="
                                                        selected ===
                                                        bill.bill_no
                                                            ? 'selected'
                                                            : ''
                                                    "
                                                >
                                                    {{ bill.bill_notes }}
                                                </td>
                                                <td
                                                    v-show="user.reprint_bill"
                                                    :class="
                                                        selected ===
                                                        bill.bill_no
                                                            ? 'hideMeInPrint selected'
                                                            : 'hideMeInPrint'
                                                    "
                                                >
                                                    <a
                                                        class="btn btn-sm btn-success"
                                                        @click="
                                                            preparePrint(bill)
                                                        "
                                                    >
                                                        <i
                                                            class="fa fa-print text-light"
                                                        ></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div style="min-height: 50vh">
                            <div class="w-100 table-wrapper">
                                <div id="pagewrap" class="row">
                                    <div id="body" class="col-sm-12">
                                        <table class="text-center">
                                            <thead>
                                                <tr>
                                                    <th
                                                        class="col-header"
                                                        style="width: 50%"
                                                    >
                                                        {{ __("Type Name") }}
                                                    </th>
                                                    <th
                                                        class="col-header"
                                                        style="width: 10%"
                                                    >
                                                        {{ __("Count") }}
                                                    </th>
                                                    <th
                                                        class="col-header"
                                                        style="width: 10%"
                                                    >
                                                        {{ __("Unit") }}
                                                    </th>
                                                    <th
                                                        class="col-header"
                                                        style="width: 10%"
                                                    >
                                                        {{ __("Sill Price") }}
                                                    </th>
                                                    <th
                                                        class="col-header"
                                                        style="width: 10%"
                                                    >
                                                        {{ __("Return Count") }}
                                                    </th>
                                                    <th
                                                        class="col-header"
                                                        style="width: 10%"
                                                    >
                                                        {{
                                                            __("Total Returend")
                                                        }}
                                                    </th>
                                                    <th
                                                        class="col-header"
                                                        style="width: 10%"
                                                    >
                                                        {{ __("Total") }}
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr
                                                    v-for="(
                                                        product, index
                                                    ) in form.bill_type"
                                                    :key="index"
                                                    :class="
                                                        product.returned
                                                            ? 'font-weight-bold   text-light bg-secondary'
                                                            : 'font-weight-bold'
                                                    "
                                                >
                                                    <td
                                                        :style="
                                                            product.has_Offer
                                                                ? 'color:red!important'
                                                                : ''
                                                        "
                                                    >
                                                        {{
                                                            product.type
                                                                .type_name_ar
                                                        }}
                                                    </td>
                                                    <td>
                                                        {{ product.type_count }}
                                                    </td>

                                                    <td>
                                                        {{
                                                            product.units
                                                                ? product.units
                                                                      .unit
                                                                      .unit_ar_name
                                                                : "-"
                                                        }}
                                                    </td>
                                                    <td>
                                                        {{ product.type_price }}
                                                    </td>
                                                    <td>
                                                        <button
                                                            v-if="
                                                                !product.returned
                                                            "
                                                            class="btn-sm mx-2 btn-warning"
                                                            @click="
                                                                decrement(
                                                                    product
                                                                )
                                                            "
                                                        >
                                                            -
                                                        </button>
                                                        <input
                                                            type="number"
                                                            step="0.01"
                                                            min="0"
                                                            v-if="
                                                                !product.returned
                                                            "
                                                            v-model="
                                                                product.returned_qty
                                                            "
                                                            @keyup="
                                                                onChangeCount(
                                                                    product
                                                                )
                                                            "
                                                            class="btn-sm text-center"
                                                            style="width: 70px"
                                                        />
                                                        <b v-else>{{
                                                            product.returned_qty
                                                        }}</b>
                                                        <button
                                                            v-if="
                                                                !product.returned
                                                            "
                                                            class="btn-sm mx-2 btn-success"
                                                            :disabled="
                                                                product.has_Offer
                                                            "
                                                            @click="
                                                                increment(
                                                                    product
                                                                )
                                                            "
                                                        >
                                                            +
                                                        </button>
                                                    </td>

                                                    <td>
                                                        <b
                                                            class="btn text-bold"
                                                            >{{
                                                                product.returned_total
                                                            }}</b
                                                        >
                                                    </td>
                                                    <td>
                                                        {{
                                                            product.type_total_price
                                                        }}
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End Selected Items-->
                </div>
            </div>
            <div>
                <Printer :bill="bill" />
            </div>
        </div>
        <Spinner v-else :title="title"> </Spinner>
    </div>
</template>

<script>
import { Invoice } from "@axenda/zatca";
import Spinner from "../spinner/mixinsSpinner";
import Printer from "../printer";
import datePicker from "../date/index";
import "pc-bootstrap4-datetimepicker/build/css/bootstrap-datetimepicker.css";
import moment from "moment";

export default {
    components: { Printer, Spinner, datePicker },
    async created() {
        if (!User.loggedIn()) {
            this.$router.push("/");
        }
        await axios
            .get("/api/users/" + localStorage.getItem("user_id"))
            .then(({ data }) => (this.user = data))
            .catch((error) => console.log(error));
        this.reportPeriod.from = moment().add(-5, "days").format("yyyy-MM-DD");
        this.reportPeriod.to = moment().add(0, "days").format("yyyy-MM-DD");
        await this.allBills();
        await this.getMixins();
        await this.allPayMethods();
        this.reportPeriod.from = moment().add(-5, "days");
        this.reportPeriod.to = moment().add(0, "days");
    },

    data() {
        return {
            configs: {
                wrap: {
                    allowInputToggle: true,
                },
            },
            user: {},
            searchTypes: [],
            showSearchTypeModal: false,
            output: null,
            qr: "",
            selected: "",
            title: "مرتجع بيع",
            isNewbill: true,
            isPrint: false,
            loading: false,
            mixins: {
                bill_column_num: "",
                bill_discount: "",
                bill_with_main_type: "",
                closure_hour: "",
                contruct_no: "",
                default_lang: "",
                end_support_date: "",
                id: "",
                image_path: "",
                bill_type: "",
                item_request_qty: "",
                logo_height: "",
                logo_width: "",
                main_mixins_store: "",
                main_type_column_num: "",
                mixins_adress: "",
                mixins_font_color: "",
                mixins_font_size: "",
                mixins_logo: "",
                mixins_mac_serial: "",
                mixins_main_payment_method: "",
                mixins_mobile: "",
                mixins_name: "",
                mixins_note: "",
                mixins_price_include_vat: false,
                mixins_theme: "",
                mixins_vat_val: "",
                partition_folder: "",
                render_bill_footer_note: "",
                render_bill_img: "",
                render_bill_note: "",
                render_bill_reports: "",
                render_bills: "",
                render_cash: "",
                render_cash_point: "",
                render_en_names: "",
                render_new_bill: "",
                render_purchase_bills: "",
                render_purchase_bills_reports: "",
                render_types_note: "",
                render_withdraw_cash: "",
                show_reset_btn: "",
                type_discount: "",
                use_type_uints: "",
                active_type_offer: "",
            },
            products: [],
            payMethods: [],
            categories: [],
            category: {},
            customers: [],
            customer: {},
            search: "",
            id: "",
            searchName: "",
            typeName: "",
            isPercentDiscount: false,
            type: {},
            bill_id: "",
            barcode: "",
            bill: {},
            cart: [],
            form: {},
            bills: [],
            searchTerm: "",
            period: false,
            reportName: "",
            hideMe: false,
            total: 1,
            page: 1,
            current_page: "",
            reportPeriod: {
                to: null,
                from: null,
            },

            returnBill: {
                sum: 0.0,
                total: 0.0,
                vat: 0.0,
                cart: [],
                prevtype: [],
            },
            billTypes: [],
            typeUnit: {},
        };
    },
    methods: {
        async allPayMethods() {
            await axios
                .get("/api/payMethods")
                .then(({ data }) => (this.payMethods = data))
                .catch((error) => console.log(error));
        },
        async findBill() {
            await axios
                .get("api/action/findBillById/" + this.bill_id)
                .then(async ({ data }) => {
                    if (data.length >= 0) {
                        this.bills = data;
                    } else {
                        Notification.customMsg(
                            "warning",
                            "topRight",
                            "لا يوجد فاتورة بهذا الرقم"
                        );
                    }
                })
                .catch((err) => console.log(err));
        },
        async findBillByTypeId() {
            await axios
                .get("api/action/findBillWithTypeId/" + this.barcode)
                .then(async ({ data }) => {
                    this.bills = [];
                    data.bill_type.map((bill) => {
                        this.bills.push(bill.bill);
                    });
                })
                .catch((err) => console.log(err));
        },
        async print(bill) {
            this.bill = bill;
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
        },
        async getMixins() {
            await axios
                .get("/api/mixins/1")
                .then(({ data }) => {
                    this.mixins = data;
                })
                .catch((error) => console.log(error));
        },

        async decrement(product) {
            if (product.returned_qty < 1) {
                product.returned_qty = 0;
                product.returned_total =
                    product.returned_qty * Number(product.type_sill_price);
                this.cart.slice(product);
            } else {
                product.returned_qty--;
            }

            await this.calcSum();

            await this.calcTotalTypeCost(product);
        },
        async increment(product) {
            if (this.cart.includes(product)) {
                if (product.returned_qty == product.type_count) {
                    product.returned_qty = product.type_count;
                } else {
                    product.returned_qty++;
                }
            } else {
                product.returned_qty = 1;
                this.cart.push(product);
            }

            await this.calcTotalTypeCost(product);
        },
        async onChangeCount(product) {
            if (
                product.returned_qty <= 1 ||
                product.returned_qty > product.type_count
            ) {
                product.returned_qty = 1;
            }
            await this.calcTotalTypeCost(product);
        },
        onChangeTypeCost(product) {
            if (product.type_price < product.minimum_sill_price) {
                product.type_price = product.minimum_sill_price;
            }
            this.calcTotalTypeCost(product);
        },
        onChangeUnit(product) {
            product.returned_qty = 1;
            product.type_count = product.units.no_of_unit * product.count;
            this.calcTotalTypeCost(product);
        },
        async calcUnitPrice(product) {
            product.calc_count = 0;
            if (product.sell_unit !== null && product.units) {
                if (product.type.type_stock !== null) {
                    var allNoUintBefore =
                        product.units.no_of_unit *
                        product.type.type_stock.mixins_type_stock;
                    var totalNofUnitAfter =
                        allNoUintBefore +
                        product.returned_qty / product.units.no_of_unit;
                    product.calc_count = totalNofUnitAfter - allNoUintBefore;
                }
            } else {
                product.type_price = product.type_price;
            }
        },
        async calcTotalTypeCost(product) {
            await this.calcUnitPrice(product);
            product.returned_total =
                product.returned_qty * Number(product.type_price);
            await this.calcDef(product);
        },
        async calcDef(product) {
            if (parseFloat(product.type_discount_value) > 0) {
                product.total_type_cost =
                    (product.type_count - product.returned_qty) *
                    product.type_sill_price;
                product.total_type_cost =
                    product.total_type_cost - product.type_discount_value;
                await this.calcSum();
                return;
            }

            product.total_type_cost =
                (product.type_count - product.returned_qty) *
                Number(product.type_sill_price);
            await this.calcSum();
        },
        async calcSum() {
            this.returnBill.sum = 0;
            this.cart.filter((product) => {
                product.returned_total =
                    parseFloat(product.returned_total) -
                    parseFloat(product.type_discount);
                this.returnBill.sum =
                    parseFloat(this.returnBill.sum) +
                    parseFloat(product.returned_total);
            });
            if (this.form.is_included) {
                this.returnBill.sum =
                    this.returnBill.sum / (1 + this.form.vat / 100.0);
            }
            await this.calcTotal();
        },
        calcVat(total) {
            this.returnBill.vat = 0;
            if (!this.mixins.fixed_vat) {
                this.cart.filter((product) => {
                    this.returnBill.vat =
                        parseFloat(this.returnBill.vat) +
                        (product.returned_total * product.type_vat) /
                            100.0;
                });
                return;
            }
            if (this.form.vat > 0 && this.mixins.fixed_vat) {
                this.returnBill.vat = 0.0;
                let vatVal = this.form.vat;
                this.returnBill.vat =
                    (parseFloat(total) * parseFloat(vatVal)) / 100.0;
            }
        },
        format(num) {
            return parseFloat(num).toFixed(this.mixins.digit);
        },
        calacDiscountPecent() {
            let percent = 0;
            if (this.form.bill_discount_percent) {
                percent =
                    (this.form.bill_discount / this.form.bill_total) * 100.0;
                this.returnBill.vat =
                    this.returnBill.vat -
                    (this.returnBill.vat * percent) / 100.0;
            }
        },
        async calcTotal() {
            this.returnBill.total = this.returnBill.sum;
            this.returnBill.total =
                parseFloat(this.returnBill.total) -
                parseFloat(this.returnBill.total) *
                    (parseFloat(this.form.bill_discount) / 100.0);
            if (this.form.sale != null) {
                this.returnBill.total =
                    parseFloat(this.returnBill.total) -
                    parseFloat(this.returnBill.total) *
                        (parseFloat(this.form.sale.sill_type_discount) / 100.0);
            }
            if (this.form.customer != null) {
                this.returnBill.total =
                    parseFloat(this.returnBill.total) -
                    parseFloat(this.returnBill.total) *
                        (parseFloat(this.form.customer.cust_discount_percent) /
                            100.0);
            }
            this.calcVat(this.returnBill.total);
            this.returnBill.total =
                parseFloat(this.returnBill.total) +
                parseFloat(this.returnBill.vat);
            this.returnBill.vat = this.format(this.returnBill.vat);
            this.returnBill.sum = this.format(this.returnBill.sum);
            this.returnBill.total = this.format(this.returnBill.total);
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
            if (this.form.total <= 0) {
                isValid = false;
                Notification.customMsg(
                    "error",
                    "topRight",
                    "لايمكن حفظ فاتورة قيمتها صفر"
                );
                return;
            }

            if (isValid) {
                await this.saveValidBill();
            }
        },
        async saveValidBill() {
            this.returnBill.cart = this.cart;
            this.returnBill.prevtype = this.form.bill_type;
            this.returnBill.process_bills = false;
            this.returnBill.pay = this.form.bill_paid_type;

            if (this.returnBill.cart.length > 0) {
                await axios
                    .patch(
                        "api/cashier/bills/" + this.form.bill_no,
                        this.returnBill
                    )
                    .then(async (data) => {
                        Notification.success();
                        await this.clearAll();
                        await this.allBills();
                    })
                    .catch((error) => {
                        Notification.error();
                    });
            } else {
                Notification.error();
            }
        },
        clearAll() {
            this.form.bill_type = [];
            this.form = {};
            this.returnBill = {
                sum: 0.0,
                total: 0.0,
                vat: 0.0,
                cart: [],
                prevtype: [],
            };
            this.cart = [];
            this.customer = {};
            this.search = "";
            this.isPrint = false;
        },
        async preparePrint(bill) {
            await this.print(bill);
            $("#btn").click();
            await this.allBills();
        },
        nextPage(i) {
            this.page = i;
            this.allBills();
        },
        printMe() {
            this.$htmlToPaper("printMeReport");
        },
        allBills() {
            axios
                .get(
                    "/api/bill/report/" +
                        this.period +
                        "/" +
                        this.reportPeriod.from +
                        "/" +
                        this.reportPeriod.to +
                        "/25"
                )
                .then(({ data }) => {
                    if (data.data.length >= 0) {
                        // this.loading = false;
                        this.bills = data.data;
                    }
                })
                .catch((error) => console.log(error));
        },
        async showBillDetails(bill) {
            await this.clearAll();
            this.form = bill;

            this.allBills();
        },
    },
};
</script>
<style scoped>
b.btn {
    float: right;
}

.fa {
    cursor: pointer;
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

.newBill .card img {
    width: 160px;
    height: 120px;
    object-fit: cover;
}

.newBill .card__title {
    margin-top: 16px;
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
