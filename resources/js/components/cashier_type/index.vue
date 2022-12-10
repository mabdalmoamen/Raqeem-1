<template>
    <div>
        <div v-if="user.types" class="row">
            <!-- Datatables -->
            <div v-show="!loading" class="col-lg-12">
                <div class="card mb-4">
                    <div
                        class="card-header d-flex flex-row align-items-center justify-content-between"
                    >

                        <h6 class="m-0 font-weight-bold text-primary">
                            كل المنتجات
                        </h6>
                        <router-link
                            v-show="user.create_type"
                            class="m-0 font-weight-bold text-primary"
                            to="/create"
                            >إضافة
                        </router-link>



                        <div
                            class="m-0 font-weight-bold text-primary float-left"
                        >
                            <div id="search">
                                <input
                                    id="filter"
                                    v-model="typeName"
                                    @keyup="findTypeByLike"
                                    class="form-control-sm"
                                    name="filter"
                                    type="text"
                                />
                            </div>
                        </div>
                    </div>
                    <div class="w-100 dragscroll table-wrapper">
                        <div id="pagewrap" class="row">
                            <div id="body" class="col-sm-12">
                                <table
                                    v-if="types.length > 0"
                                    id="types"
                                    class="text-center table-bordered"
                                >
                                    <thead>
                                        <tr>
                                            <th
                                                v-show="
                                                    user.edit_type ||
                                                    user.delete_type
                                                "
                                                class="col-header"
                                                style="width: 15%"
                                            >
                                                إعدادات
                                            </th>

                                            <th
                                                class="col-header"
                                                style="width: 15%"
                                            >
                                                كود
                                            </th>
                                            <th
                                                class="col-header"
                                                style="width: 15%"
                                            >
                                                باركود الصنف
                                            </th>
                                            <th
                                                class="col-header"
                                                style="width: 25%"
                                            >
                                                اسم الصنف عربي
                                            </th>
                                            <th
                                                class="col-header"
                                                style="width: 20%"
                                            >
                                                اسم الصنف انجليزي
                                            </th>
                                            <th
                                                class="col-header"
                                                style="width: 10%"
                                            >
                                                صورة الصنف
                                            </th>
                                            <th
                                                class="col-header"
                                                style="width: 10%"
                                            >
                                                سعر الشراء
                                            </th>
                                            <th
                                                class="col-header"
                                                style="width: 20%"
                                            >
                                                سعر البيع
                                            </th>
                                            <th
                                                class="col-header"
                                                style="width: 10%"
                                            >
                                                أقل سعر البيع
                                            </th>

                                            <th
                                                class="col-header"
                                                style="width: 10%"
                                            >
                                                قيمة الخصم
                                            </th>
                                            <th
                                                class="col-header"
                                                style="width: 10%"
                                            >
                                                المخزون
                                            </th>
                                            <th
                                                class="col-header"
                                                style="width: 10%"
                                            >
                                                الاجمالي بسعر البيع
                                            </th>
                                            <th
                                                class="col-header"
                                                style="width: 10%"
                                            >
                                                الاجمالي بسعر الشراء
                                            </th>
                                            <th
                                                class="col-header"
                                                style="width: 10%"
                                            >
                                                المخزون
                                            </th>
                                            <th
                                                class="col-header"
                                                style="width: 10%"
                                            >
                                                تاريخ الصلاحية
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr
                                            v-for="(type, index) in types"
                                            :key="index"
                                            class="ErrorRow"
                                        >
                                            <td v-if="!isNewbill">
                                                <button
                                                    @click="printBarcode(type)"
                                                >
                                                    <i
                                                        class="fa fa-barcode"
                                                    ></i>
                                                </button>
                                                <router-link
                                                    v-show="user.edit_type"
                                                    :to="{
                                                        name: 'edit',
                                                        params: {
                                                            id: type.type_id,
                                                        },
                                                    }"
                                                    class="btn btn-sm btn-primary"
                                                    ><i class="fa fa-edit"></i>
                                                </router-link>
                                                <a
                                                    v-show="user.delete_type"
                                                    class="btn btn-sm btn-danger"
                                                    @click="
                                                        deleteType(type.type_id)
                                                    "
                                                    ><i class="fa fa-trash"></i
                                                ></a>
                                            </td>
                                            <td v-else>
                                                <button
                                                    type="button"
                                                    class="btn btn-sm btn-primary"
                                                    @click="addToCart(type)"
                                                >
                                                    <i class="fa fa-plus"></i>
                                                </button>
                                            </td>
                                            <td class="sorting_1">
                                                {{ type.type_id }}
                                            </td>
                                            <td class="">
                                                {{ type.type_barcode }}
                                            </td>
                                            <td class="" style="overflow: auto">
                                                {{ type.type_name_ar }}
                                            </td>
                                            <td>{{ type.type_name_en }}</td>
                                            <td class="">
                                                <!-- Button trigger modal -->
                                                <button
                                                    v-show="
                                                        type.type_icon !== '' ||
                                                        type.type_icon != null
                                                    "
                                                    :data-target="
                                                        '#exampleModalCenter-' +
                                                        type.type_id
                                                    "
                                                    class="btn btn-sm btn-primary"
                                                    data-toggle="modal"
                                                    type="button"
                                                >
                                                    <i class="fa fa-search"></i>
                                                </button>
                                                <div
                                                    :id="
                                                        'exampleModalCenter-' +
                                                        type.type_id
                                                    "
                                                    aria-hidden="true"
                                                    aria-labelledby="exampleModalCenterTitle"
                                                    class="modal fade"
                                                    role="dialog"
                                                    tabindex="-1"
                                                >
                                                    <div
                                                        class="modal-dialog modal-dialog-centered"
                                                        role="document"
                                                    >
                                                        <div
                                                            class="modal-content"
                                                            style="width: 500px"
                                                        >
                                                            <div
                                                                class="modal-body"
                                                                style="
                                                                    width: 500px;
                                                                "
                                                            >
                                                                <img
                                                                    :src="
                                                                        type.type_icon
                                                                    "
                                                                    style="
                                                                        width: 100%;
                                                                        height: 100%;
                                                                    "
                                                                />
                                                            </div>
                                                            <div
                                                                class="modal-footer py-1"
                                                            >
                                                                <button
                                                                    class="btn-sm btn btn-secondary"
                                                                    data-dismiss="modal"
                                                                    type="button"
                                                                >
                                                                    إغلاق
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="">
                                                {{ type.type_purchases_price }}
                                            </td>
                                            <td class="">
                                                {{ type.type_sill_price }}
                                            </td>
                                            <td class="">
                                                {{ type.minimum_sill_price }}
                                            </td>

                                            <td class="">
                                                {{ type.type_discount_value }}
                                            </td>
                                            <td>
                                                {{
                                                    type.type_stock
                                                        ? type.type_stock
                                                              .mixins_type_stock
                                                        : 0
                                                }}
                                            </td>
                                            <td>
                                                {{
                                                    type.type_stock
                                                        ? type.type_stock
                                                              .mixins_type_stock *
                                                          type.type_sill_price
                                                        : 0
                                                }}
                                            </td>
                                            <td>
                                                {{
                                                    type.type_stock
                                                        ? type.type_stock
                                                              .mixins_type_stock *
                                                          type.type_purchases_price
                                                        : 0
                                                }}
                                            </td>
                                            <td>{{ type.type_exp_date }}</td>
                                        </tr>
                                    </tbody>
                                    <tfoot></tfoot>
                                </table>
                                <p v-else class="text-center">
                                    {{ __("No Data Yet") }}
                                </p>
                                <div
                                    v-show="types.length > 0"
                                    class="row text-center"
                                >
                                    <ul
                                        class="pagination justify-content-center"
                                    >
                                        <li
                                            :class="
                                                page === 1
                                                    ? 'page-item disabled'
                                                    : 'page-item'
                                            "
                                        >
                                            <a
                                                class="page-link"
                                                href="#"
                                                @click="nextPage(1)"
                                                >البداية</a
                                            >
                                        </li>
                                        <li
                                            :class="
                                                page === 1
                                                    ? 'page-item disabled'
                                                    : 'page-item'
                                            "
                                        >
                                            <a
                                                class="page-link"
                                                href="#"
                                                @click="
                                                    nextPage(current_page - 1)
                                                "
                                                ><i
                                                    class="fa fa-arrow-right"
                                                ></i
                                            ></a>
                                        </li>
                                        <li
                                            class="page-item d-none"
                                            v-for="(i, index) in total"
                                            @click="nextPage(i)"
                                        >
                                            <a class="page-link" href="#">{{
                                                i
                                            }}</a>
                                        </li>
                                        <li
                                            :class="
                                                page === last_page
                                                    ? 'page-item disabled'
                                                    : 'page-item'
                                            "
                                        >
                                            <a
                                                class="page-link"
                                                href="#"
                                                @click="
                                                    nextPage(current_page + 1)
                                                "
                                                ><i class="fa fa-arrow-left"></i
                                            ></a>
                                        </li>
                                        <li
                                            :class="
                                                page === last_page
                                                    ? 'page-item disabled'
                                                    : 'page-item'
                                            "
                                        >
                                            <a
                                                class="page-link"
                                                href="#"
                                                @click="nextPage(total + 1)"
                                                >الاخير</a
                                            >
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div
                    id="printMe"
                    class="d-none text-center"
                    style="margin: auto"
                >
                    <img class="barcode" />
                </div>
            </div>
            <!-- DataTable with Hover -->

            <div v-show="loading" class="text-center" dir="rtl">
                <Spinner :title="title"></Spinner>
            </div>
        </div>
        <Security v-else></Security>
    </div>
</template>

<script>
import Spinner from "../spinner/mixinsSpinner.vue";
import Security from "../spinner/security";
import JsBarcode from "jsbarcode";

export default {
    components: { Security, Spinner },
    props: {
        isNewbill: Boolean,
        addToCart: Function,
    },

    async created() {
        if (!User.loggedIn()) {
            this.$router.push("/");
        }
        await axios
            .get("/api/users/" + localStorage.getItem("user_id"))
            .then(({ data }) => (this.user = data))
            .catch((error) => console.log(error));
        await this.allTypes();
        await axios
            .get("/api/barcodes/" + 1)
            .then(({ data }) => {
                this.barcode = data;
            })
            .catch((error) => console.log(error));
    },
    data() {
        return {
            title: "Types",
            user: {},

            types: [],
            searchTerm: "",
            loading: true,
            total: 1,
            page: 1,
            current_page: "",
            last_page: "",
            typeName: "",
            barcode: {},
        };
    },
    computed: {
        filterSearch() {
            return this.types.filter((type) => {
                return type.type_name_ar.match(this.searchTerm);
            });
        },
    },
    methods: {
        async printBarcode(type) {
            let barcode = type.type_barcode;
            if (
                type.type_barcode == null ||
                type.type_barcode === "" ||
                type.type_barcode.length === 0
            ) {
                barcode = type.type_id;
            }
            JsBarcode(".barcode", barcode, {
                textAlign: this.barcode.textAlign,
                textPosition: this.barcode.textPosition,
                font: this.barcode.font,
                fontOptions: this.barcode.fontOptions,
                textMargin: this.barcode.textMargin,
                format: this.barcode.format,
                displayValue: this.barcode.displayValue,
                height: this.barcode.height,
                width: this.barcode.width,
                fontSize: this.barcode.fontSize,
                background: this.barcode.background,
                lineColor: this.barcode.lineColor,
                margin: this.barcode.margin,
                marginLeft: this.barcode.marginLeft,
                marginTop: this.barcode.marginTop,
                marginBottom: this.barcode.marginBottom,
                marginRight: this.barcode.marginRight,
                flat: this.barcode.flat,
            });
            this.$htmlToPaper("printMe");
        },
        findTypeByLike() {
            axios
                .get("/api/action/like/" + this.typeName)
                .then(({ data }) => {
                    this.types = data;
                })
                .catch((error) => console.log(error));
        },
        allTypes() {
            axios
                .get("/api/cashier/types?page=" + this.page)
                .then(({ data }) => {
                    if (data.data.length >= 0) {
                        this.loading = false;
                        this.total = parseInt(data.total / data.per_page);
                        this.types = data.data;
                        this.current_page = data.current_page;
                        this.last_page = data.last_page;
                    }
                })
                .catch((error) => console.log(error));
        },

        nextPage(i) {
            this.page = i;
            this.allTypes();
        },
        deleteType(id) {
            if (confirm("هل تريد الحذف؟لايمكن الاستعاده مره اخرى.")) {
                axios
                    .delete("/api/types/" + id)
                    .then((data) => {
                        console.log(data);
                        if (data.data) {
                            this.types = this.types.filter((type) => {
                                return type.type_id !== id;
                            });
                            Notification.successMsg("تم الحذف بنجاح");
                        } else {
                            Notification.errorMsg(
                                "لايمكن حذف صنف مرتبط بفواتير أو عمليات"
                            );
                        }
                    })
                    .catch(() => {
                        Notification.error();
                    });
            }
        },
    },
};
</script>
<style>
a,
a:hover {
    text-decoration: none;
    font-weight: bolder;
}

table.table-fit thead th,
table.table-fit tfoot th {
    width: auto !important;
}

table.table-fit tbody td,
table.table-fit tfoot td {
    width: auto !important;
}
</style>
